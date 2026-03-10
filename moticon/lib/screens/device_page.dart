import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../proto/insole.pb.dart';
import '../proto/common.pb.dart' as common;

const String kNordicUartServiceUuid = '6e400001-b5a3-f393-e0a9-e50e24dcca9e';
const String kTxCharUuid            = '6e400003-b5a3-f393-e0a9-e50e24dcca9e';
const String kRxCharUuid            = '6e400002-b5a3-f393-e0a9-e50e24dcca9e';
const double kForceThreshold        = 2.0;

class InsoleTarget {
  final BluetoothDevice device;
  final int side;
  const InsoleTarget({required this.device, required this.side});
}

class _Insole {
  final BluetoothDevice device;
  final int side;
  BluetoothCharacteristic? txChar;
  BluetoothCharacteristic? rxChar;
  StreamSubscription<List<int>>?                notifySub;
  StreamSubscription<BluetoothConnectionState>? connSub;
  final List<int> rxBuf = [];
  int    serviceCounter = 0;
  bool   connected      = false;
  bool   running        = false;
  double force          = 0;
  _Insole(this.device, this.side);
  String get shortId   => device.remoteId.toString().substring(0, 8);
  String get sideLabel => side == 0 ? 'LEFT' : 'RIGHT';
}

class DevicePage extends StatefulWidget {
  final List<InsoleTarget> targets;
  const DevicePage({super.key, required this.targets});
  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  late final List<_Insole> _insoles;
  Timer? _fpsTimer;
  Timer? _demoTimer;
  int    _frameCount = 0, _lastFrameCount = 0, _demoTick = 0;
  double _fps = 0, _peakForce = 0;
  bool   _isBusy = false, _useDemoMode = false, _showDebug = true;
  final List<String> _log = [];

  bool   get _anyRunning    => _insoles.any((i) => i.running);
  double get _leftForce     => _insoles.where((i) => i.side == 0).fold(0.0, (_, i) => i.force);
  double get _rightForce    => _insoles.where((i) => i.side == 1).fold(0.0, (_, i) => i.force);
  bool   get _leftConn      => _insoles.any((i) => i.side == 0 && i.connected);
  bool   get _rightConn     => _insoles.any((i) => i.side == 1 && i.connected);

  String get _statusMsg {
    final c = _insoles.where((i) => i.connected).length;
    final t = _insoles.length;
    if (_anyRunning) return 'Streaming  •  $c/$t connected';
    if (c == t)      return 'Connected $c/$t  •  tap Start';
    return 'Connecting…  $c/$t';
  }

  void L(String msg) {
    final ts = DateTime.now().toIso8601String().substring(11, 23);
    debugPrint('[$ts] $msg');
    if (!mounted) return;
    setState(() { _log.insert(0, '[$ts] $msg'); if (_log.length > 100) _log.removeLast(); });
  }

  @override
  void initState() {
    super.initState();
    _insoles = widget.targets.map((t) => _Insole(t.device, t.side)).toList();
    _fpsTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() { _fps = (_frameCount - _lastFrameCount).toDouble(); _lastFrameCount = _frameCount; });
    });
    for (final ins in _insoles) _connect(ins);
  }

  Future<void> _connect(_Insole ins) async {
    L('Connecting ${ins.shortId} (${ins.sideLabel})');
    ins.connSub = ins.device.connectionState.listen((s) {
      L('${ins.shortId} state=$s');
      if (!mounted) return;
      if (s != BluetoothConnectionState.connected && !_useDemoMode)
        setState(() { ins.connected = false; ins.running = false; ins.force = 0; });
    });
    try {
      await ins.device.connect(timeout: const Duration(seconds: 20));
      L('${ins.shortId} connected');
      // MTU FIRST — before discoverServices on Android
      try {
        final mtu = await ins.device.requestMtu(512);
        L('${ins.shortId} MTU=$mtu');
      } catch (e) { L('${ins.shortId} MTU err: $e'); }
      await Future<void>.delayed(const Duration(milliseconds: 300));
      final svcs = await ins.device.discoverServices();
      L('${ins.shortId} ${svcs.length} services');
      for (final svc in svcs) {
        if (svc.uuid.toString().toLowerCase() != kNordicUartServiceUuid) continue;
        L('${ins.shortId} UART found');
        for (final c in svc.characteristics) {
          final id = c.uuid.toString().toLowerCase();
          if (id == kTxCharUuid) { ins.txChar = c; L('${ins.shortId} TX ok'); }
          if (id == kRxCharUuid) { ins.rxChar = c; L('${ins.shortId} RX ok'); }
        }
      }
      if (ins.txChar == null) { L('${ins.shortId} ERROR: TX not found'); return; }
      if (ins.rxChar == null) { L('${ins.shortId} ERROR: RX not found'); return; }
      await ins.txChar!.setNotifyValue(true);
      L('${ins.shortId} notify ON');
      ins.notifySub = ins.txChar!.onValueReceived.listen(
        (d) { L('${ins.shortId} RX ${d.length}b: ${d.take(6).map((b)=>b.toRadixString(16).padLeft(2,"0")).join(" ")}'); _onBleData(ins, d); },
        onError: (e) => L('${ins.shortId} notify error: $e'),
      );
      if (!mounted) return;
      setState(() => ins.connected = true);
      L('${ins.shortId} READY');
      await _send(ins, InsoleMessage()..insoleInfoReq = (InsoleInfoReq()..type = common.InsoleInfoType.ALL));
      L('${ins.shortId} InfoReq sent');
    } catch (e, st) { L('${ins.shortId} EXCEPTION: $e\n$st'); if (mounted) setState(() {}); }
  }

  Future<void> _startAll() async {
    if (_useDemoMode) { _startDemo(); return; }
    setState(() { _isBusy = true; _peakForce = 0; });
    for (final ins in _insoles) {
      if (!ins.connected || ins.rxChar == null) { L('${ins.shortId} skip (not ready)'); continue; }
      try {
        final msg = InsoleMessage()
          ..startService = (InsoleStartService()
            ..serviceConfig = (common.ServiceConfig()
              ..serviceType = common.ServiceType.LIVE
              ..rate        = 100
              ..enabledPressure.addAll(List<bool>.filled(16, true))
              ..enabledTotalForce = true
              ..enabledCop.addAll(<bool>[true, true])));
        final raw = msg.writeToBuffer();
        L('${ins.shortId} StartService ${raw.length}b');
        await _send(ins, msg);
        L('${ins.shortId} StartService write OK');
        ins.running = true;
      } catch (e) { L('${ins.shortId} StartService FAILED: $e'); }
    }
    if (!mounted) return;
    setState(() => _isBusy = false);
  }

  Future<void> _stopAll() async {
    if (_useDemoMode) { _stopDemo(); return; }
    for (final ins in _insoles) {
      if (!ins.connected || ins.rxChar == null) continue;
      try {
        await _send(ins, InsoleMessage()..stopService = (InsoleStopService()..serviceCounter = ins.serviceCounter));
        L('${ins.shortId} StopService sent');
      } catch (e) { L('${ins.shortId} Stop failed: $e'); }
      ins.running = false; ins.force = 0;
    }
    setState(() => _peakForce = 0);
  }

  Future<void> _send(_Insole ins, InsoleMessage msg) async {
    final payload = msg.writeToBuffer();
    final framed  = Uint8List(2 + payload.length);
    framed[0] = (payload.length >> 8) & 0xFF;
    framed[1] =  payload.length       & 0xFF;
    framed.setRange(2, framed.length, payload);
    L('${ins.shortId} WRITE ${framed.length}b withoutResponse=true');
    await ins.rxChar!.write(framed, withoutResponse: true);
  }

  void _onBleData(_Insole ins, List<int> chunk) { ins.rxBuf.addAll(chunk); _drain(ins); }

  void _drain(_Insole ins) {
    while (ins.rxBuf.length >= 2) {
      final msgLen = (ins.rxBuf[0] << 8) | ins.rxBuf[1];
      if (ins.rxBuf.length < 2 + msgLen) return;
      final bytes = Uint8List.fromList(ins.rxBuf.sublist(2, 2 + msgLen));
      ins.rxBuf.removeRange(0, 2 + msgLen);
      _handleMsg(ins, bytes);
    }
  }

  void _handleMsg(_Insole ins, Uint8List bytes) {
    try {
      final msg = InsoleMessage.fromBuffer(bytes);
      L('${ins.shortId} msg=${msg.whichMsg()}');
      if (msg.hasDataMessage()) {
        _onData(ins, msg.dataMessage);
      } else if (msg.hasStartServiceConf()) {
        ins.serviceCounter = msg.startServiceConf.serviceCounter;
        L('${ins.shortId} Conf ✓ counter=${ins.serviceCounter}');
        // auto-zero after conf so resting = 0
        Future<void>.delayed(const Duration(milliseconds: 400), () async {
          try {
            await _send(ins, InsoleMessage()..zeroing = (common.Zeroing()
              ..source = common.ZeroingSource.MANUAL
              ..mode   = common.ZeroingMode.AUTO));
            L('${ins.shortId} auto-zero sent');
          } catch (_) {}
        });
        if (mounted) setState(() {});
      } else {
        L('${ins.shortId} other: ${msg.whichMsg()}');
      }
    } catch (e) { L('${ins.shortId} parse error: $e'); }
  }

  void _onData(_Insole ins, common.DataMessage dm) {
    final double force = dm.hasTotalForce() ? dm.totalForce.toDouble() : 0.0;
    if (!mounted) return;
    setState(() {
      ins.force = force;
      if (force > _peakForce) _peakForce = force;
      _frameCount++;
    });
  }

  void _startDemo() {
    _demoTimer?.cancel(); _peakForce = 0; _demoTick = 0;
    _demoTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!mounted) return;
      final phase = (_demoTick % 100) / 100.0;
      final f0 = phase < 0.5 ? 600 * sin(phase / 0.5 * pi) : 0.0;
      final f1 = phase >= 0.5 ? 600 * sin((phase - 0.5) / 0.5 * pi) : 0.0;
      setState(() {
        for (final ins in _insoles) ins.force = ins.side == 0 ? f0 : f1;
        if (f0 > _peakForce) _peakForce = f0;
        if (f1 > _peakForce) _peakForce = f1;
        _demoTick++; _frameCount++;
      });
    });
    setState(() => _useDemoMode = true);
  }

  void _stopDemo() {
    _demoTimer?.cancel();
    for (final ins in _insoles) ins.force = 0;
    setState(() { _useDemoMode = false; _peakForce = 0; });
  }

  @override
  void dispose() {
    _fpsTimer?.cancel(); _demoTimer?.cancel();
    for (final ins in _insoles) { ins.notifySub?.cancel(); ins.connSub?.cancel(); }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scale = max(50.0, _peakForce);
    final lf = _anyRunning ? _leftForce  : 0.0;
    final rf = _anyRunning ? _rightForce : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text('Moticon Insoles', style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [Padding(padding: const EdgeInsets.only(right: 12),
            child: Center(child: _StatusDot(active: _anyRunning)))],
      ),
      body: Column(children: [

        // Status
        Container(color: const Color(0xFF111111),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          child: Row(children: [
            Expanded(child: Text(_statusMsg,
                style: const TextStyle(color: Colors.white54, fontSize: 11), overflow: TextOverflow.ellipsis)),
            if (_anyRunning) ...[
              Text('${_fps.toStringAsFixed(0)} fps',
                  style: const TextStyle(color: Colors.greenAccent, fontSize: 11, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
            ],
            for (final ins in _insoles) ...[_ConnDot(ins: ins), const SizedBox(width: 6)],
          ]),
        ),

        // Force bars
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Expanded(child: _PressureColumn(label: 'LEFT',  force: lf, scale: scale, accent: const Color(0xFF1565C0), connected: _leftConn)),
              const SizedBox(width: 16),
              Expanded(child: _PressureColumn(label: 'RIGHT', force: rf, scale: scale, accent: const Color(0xFF6A1B9A), connected: _rightConn)),
            ]),
          ),
        ),

        // Buttons
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Row(children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _anyRunning ? const Color(0xFFC62828) : const Color(0xFF1B5E20),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _isBusy ? null : (_anyRunning ? _stopAll : _startAll),
                icon: Icon(_anyRunning ? Icons.stop : Icons.play_arrow, size: 22),
                label: Text(_anyRunning ? 'Stop' : 'Start',
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              ),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white38,
                side: const BorderSide(color: Colors.white24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
              ),
              onPressed: _useDemoMode ? _stopDemo : _startDemo,
              child: Text(_useDemoMode ? 'Demo ON' : 'Demo', style: const TextStyle(fontSize: 12)),
            ),
          ]),
        ),

        // Debug log
        GestureDetector(
          onTap: () => setState(() => _showDebug = !_showDebug),
          child: Container(color: const Color(0xFF0D0D0D),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(children: [
              const Icon(Icons.terminal, size: 13, color: Colors.greenAccent),
              const SizedBox(width: 6),
              Text('Debug (${_log.length})', style: const TextStyle(color: Colors.greenAccent, fontSize: 11)),
              const Spacer(),
              TextButton(onPressed: () => setState(() => _log.clear()),
                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(40, 20)),
                child: const Text('Clear', style: TextStyle(color: Colors.white30, fontSize: 10))),
              Icon(_showDebug ? Icons.expand_more : Icons.chevron_right, size: 14, color: Colors.white24),
            ]),
          ),
        ),
        if (_showDebug)
          Container(height: 200, color: const Color(0xFF080808),
            child: _log.isEmpty
              ? const Center(child: Text('No logs.', style: TextStyle(color: Colors.white24, fontSize: 11)))
              : ListView.builder(
                  padding: const EdgeInsets.all(6), itemCount: _log.length,
                  itemBuilder: (_, i) {
                    final e = _log[i];
                    Color c = const Color(0xFF80CBC4);
                    if (e.contains('ERROR') || e.contains('EXCEPTION') || e.contains('FAILED')) c = Colors.redAccent;
                    else if (e.contains('✓') || e.contains('READY')) c = Colors.greenAccent;
                    else if (e.contains('RX ')) c = Colors.cyanAccent;
                    else if (e.contains('WRITE')) c = Colors.yellowAccent;
                    return Text(e, style: TextStyle(color: c, fontSize: 9, fontFamily: 'monospace'));
                  }),
          ),
      ]),
    );
  }
}

// ── Widgets ───────────────────────────────────────────────────────────────────

class _PressureColumn extends StatelessWidget {
  final String label; final double force, scale; final Color accent; final bool connected;
  const _PressureColumn({required this.label, required this.force, required this.scale, required this.accent, required this.connected});

  @override
  Widget build(BuildContext context) {
    final double ratio = force >= kForceThreshold ? (force / scale).clamp(0.0, 1.0) : 0.0;
    final Color barTop = Color.lerp(accent, Colors.white, ratio * 0.55)!;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(label, style: TextStyle(color: connected ? accent : Colors.white24,
            fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 3)),
        const SizedBox(width: 6),
        Container(width: 7, height: 7, decoration: BoxDecoration(shape: BoxShape.circle,
            color: connected ? Colors.greenAccent : Colors.white12)),
      ]),
      const SizedBox(height: 8),
      Expanded(child: Container(
        decoration: BoxDecoration(color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: connected ? accent.withOpacity(0.25) : Colors.white12, width: 1.2)),
        child: ClipRRect(borderRadius: BorderRadius.circular(13),
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Positioned.fill(child: CustomPaint(painter: _TickPainter(connected ? accent : Colors.white12))),
            AnimatedFractionallySizedBox(
              duration: const Duration(milliseconds: 60), curve: Curves.easeOut,
              heightFactor: ratio,
              child: Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter,
                    colors: [accent.withOpacity(0.9), barTop]),
                boxShadow: ratio > 0.03 ? [BoxShadow(color: accent.withOpacity(0.5), blurRadius: 18, spreadRadius: 3)] : null,
              )),
            ),
            if (!connected) const Center(child: Text('No insole', style: TextStyle(color: Colors.white24, fontSize: 12))),
          ]),
        ),
      )),
      const SizedBox(height: 14),
      Text(connected && force >= kForceThreshold ? '${force.toStringAsFixed(1)} N' : connected ? '— N' : '',
        textAlign: TextAlign.center,
        style: TextStyle(color: ratio > 0.02 ? barTop : Colors.white24,
            fontSize: 28, fontWeight: FontWeight.w900, fontFamily: 'monospace')),
      const SizedBox(height: 2),
      const Text('Total Force', textAlign: TextAlign.center, style: TextStyle(color: Colors.white30, fontSize: 10)),
      const SizedBox(height: 10),
    ]);
  }
}

class _TickPainter extends CustomPainter {
  final Color color;
  const _TickPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color.withOpacity(0.12)..strokeWidth = 0.8;
    for (final f in [0.25, 0.50, 0.75]) {
      final y = size.height * (1 - f);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
      (TextPainter(text: TextSpan(text: '${(f * 100).toInt()}%',
          style: TextStyle(color: color.withOpacity(0.2), fontSize: 9)), textDirection: TextDirection.ltr)..layout())
        .paint(canvas, Offset(6, y + 2));
    }
  }
  @override bool shouldRepaint(covariant _TickPainter o) => o.color != color;
}

class _StatusDot extends StatelessWidget {
  final bool active;
  const _StatusDot({required this.active});
  @override
  Widget build(BuildContext context) => Container(width: 10, height: 10,
    decoration: BoxDecoration(shape: BoxShape.circle,
      color: active ? Colors.greenAccent : Colors.grey.shade600,
      boxShadow: active ? [BoxShadow(color: Colors.greenAccent.withOpacity(0.6), blurRadius: 8, spreadRadius: 2)] : null));
}

class _ConnDot extends StatelessWidget {
  final _Insole ins;
  const _ConnDot({required this.ins});
  @override
  Widget build(BuildContext context) {
    final color = ins.connected ? Colors.greenAccent : Colors.redAccent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4), border: Border.all(color: color.withOpacity(0.5))),
      child: Text(ins.sideLabel[0], style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)));
  }
}