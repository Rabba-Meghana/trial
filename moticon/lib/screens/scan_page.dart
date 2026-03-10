import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'device_page.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});
  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  static const int moticonManufacturerId = 0x08AE;
  final Map<String, ScanResult> _devices = {};
  final Set<String> _selected = {};
  StreamSubscription<List<ScanResult>>? _scanSub;
  StreamSubscription<bool>? _scanningSub;
  StreamSubscription<BluetoothAdapterState>? _adapterSub;
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  bool _isScanning = false;
  String _status = 'Idle';

  @override
  void initState() {
    super.initState();
    _adapterSub = FlutterBluePlus.adapterState.listen((s) { if (mounted) setState(() => _adapterState = s); });
    _scanningSub = FlutterBluePlus.isScanning.listen((v) {
      if (!mounted) return;
      setState(() {
        _isScanning = v;
        if (!v && _status == 'Scanning...')
          _status = _devices.isEmpty ? 'No insoles found.' : 'Found ${_devices.length}. Select up to 2.';
      });
    });
    _scanSub = FlutterBluePlus.onScanResults.listen((results) {
      bool changed = false;
      for (final r in results) {
        if (r.advertisementData.manufacturerData.containsKey(moticonManufacturerId)) {
          _devices[r.device.remoteId.str] = r; changed = true;
        }
      }
      if (mounted && changed) setState(() {});
    }, onError: (e) { if (mounted) setState(() => _status = 'Scan error: $e'); });
  }

  Uint8List? _payload(ScanResult r) {
    final d = r.advertisementData.manufacturerData[moticonManufacturerId];
    return d == null ? null : Uint8List.fromList(d);
  }

  int _side(ScanResult r) {
    final p = _payload(r);
    if (p == null || p.length < 6) return 0;
    return (p[5] >> 4) & 0x01;
  }

  String _name(ScanResult r) {
    final p = _payload(r);
    if (p == null || p.length < 16) return 'Moticon Insole';
    final side    = _side(r) == 0 ? 'LEFT' : 'RIGHT';
    final size    = p[5] & 0x0F;
    final sn      = ByteData.sublistView(p).getUint32(6, Endian.little);
    final battery = p[15] & 0x7F;
    final error   = (p[14] & 0x01) == 1;
    return 'Moticon $side | Size $size | SN $sn | Bat $battery%${error ? " | ⚠" : ""}';
  }

  Future<void> _scan() async {
    if (!await FlutterBluePlus.isOn) { setState(() => _status = 'BT off'); return; }
    await FlutterBluePlus.stopScan();
    _devices.clear(); _selected.clear();
    setState(() => _status = 'Scanning...');
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10), androidUsesFineLocation: true);
  }

  void _toggle(String id) {
    setState(() {
      if (_selected.contains(id)) _selected.remove(id);
      else if (_selected.length < 2) _selected.add(id);
    });
  }

  Future<void> _connect() async {
    if (_selected.isEmpty) return;
    await FlutterBluePlus.stopScan();
    if (!mounted) return;
    final targets = _selected.map((id) {
      final r = _devices[id]!;
      return InsoleTarget(device: r.device, side: _side(r));
    }).toList();
    Navigator.push(context, MaterialPageRoute(builder: (_) => DevicePage(targets: targets)));
  }

  @override
  void dispose() {
    _scanSub?.cancel(); _scanningSub?.cancel(); _adapterSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final devs = _devices.values.toList()..sort((a, b) => b.rssi.compareTo(a.rssi));
    return Scaffold(
      appBar: AppBar(title: const Text('Moticon Insoles'), centerTitle: true),
      body: Column(children: [
        Container(width: double.infinity, padding: const EdgeInsets.all(16),
          color: Colors.indigo.withOpacity(0.08),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Bluetooth: ${_adapterState.name}', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4), Text(_status), const SizedBox(height: 12),
            Row(children: [
              Expanded(child: ElevatedButton.icon(onPressed: _isScanning ? null : _scan,
                  icon: const Icon(Icons.search), label: const Text('Scan'))),
              const SizedBox(width: 10),
              Expanded(child: OutlinedButton.icon(
                  onPressed: _isScanning ? () => FlutterBluePlus.stopScan() : null,
                  icon: const Icon(Icons.stop), label: const Text('Stop'))),
            ]),
          ]),
        ),
        if (devs.isNotEmpty)
          Container(width: double.infinity, color: Colors.indigo.withOpacity(0.05),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [
              const Icon(Icons.touch_app, size: 14, color: Colors.indigo),
              const SizedBox(width: 8),
              const Expanded(child: Text('Tap to select (max 2), then Connect',
                  style: TextStyle(fontSize: 12, color: Colors.indigo))),
              if (_selected.isNotEmpty)
                Text('${_selected.length}/2', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo, fontSize: 12)),
            ]),
          ),
        Expanded(
          child: devs.isEmpty
            ? const Center(child: Text('No insoles found.\nPress Scan.', textAlign: TextAlign.center))
            : ListView.builder(itemCount: devs.length, itemBuilder: (_, i) {
                final r   = devs[i];
                final id  = r.device.remoteId.str;
                final sel = _selected.contains(id);
                final can = sel || _selected.length < 2;
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  color: sel ? Colors.indigo.withOpacity(0.12) : null,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                      side: sel ? const BorderSide(color: Colors.indigo, width: 2) : BorderSide.none),
                  child: ListTile(
                    leading: const Icon(Icons.sensors),
                    title: Text(_name(r)),
                    subtitle: Text('RSSI: ${r.rssi}'),
                    trailing: can ? (sel ? const Icon(Icons.check_circle, color: Colors.indigo)
                        : const Icon(Icons.radio_button_unchecked, color: Colors.grey))
                        : const Icon(Icons.block, color: Colors.grey, size: 18),
                    onTap: can ? () => _toggle(id) : null,
                  ),
                );
              }),
        ),
        if (_selected.isNotEmpty)
          SafeArea(top: false, child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 52),
                  backgroundColor: Colors.indigo, foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: _connect,
              icon: const Icon(Icons.bluetooth_connected),
              label: Text('Connect ${_selected.length} Insole${_selected.length > 1 ? "s" : ""}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          )),
      ]),
    );
  }
}