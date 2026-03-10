// This is a generated file - do not edit.
//
// Generated from insole.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

enum InsoleMessage_Msg {
  insoleInfoReq,
  moticonInsoleInfo,
  zeroing,
  zeroingConf,
  dataMessage,
  startService,
  startServiceConf,
  stopService,
  stopServiceConf,
  serviceInfoReq,
  serviceInfo,
  notSet
}

class InsoleMessage extends $pb.GeneratedMessage {
  factory InsoleMessage({
    InsoleInfoReq? insoleInfoReq,
    MoticonInsoleInfo? moticonInsoleInfo,
    $0.Zeroing? zeroing,
    $0.ZeroingConf? zeroingConf,
    $0.DataMessage? dataMessage,
    InsoleStartService? startService,
    $0.InsoleStartServiceConf? startServiceConf,
    InsoleStopService? stopService,
    InsoleStopServiceConf? stopServiceConf,
    ServiceInfoReq? serviceInfoReq,
    ServiceInfo? serviceInfo,
  }) {
    final result = create();
    if (insoleInfoReq != null) result.insoleInfoReq = insoleInfoReq;
    if (moticonInsoleInfo != null) result.moticonInsoleInfo = moticonInsoleInfo;
    if (zeroing != null) result.zeroing = zeroing;
    if (zeroingConf != null) result.zeroingConf = zeroingConf;
    if (dataMessage != null) result.dataMessage = dataMessage;
    if (startService != null) result.startService = startService;
    if (startServiceConf != null) result.startServiceConf = startServiceConf;
    if (stopService != null) result.stopService = stopService;
    if (stopServiceConf != null) result.stopServiceConf = stopServiceConf;
    if (serviceInfoReq != null) result.serviceInfoReq = serviceInfoReq;
    if (serviceInfo != null) result.serviceInfo = serviceInfo;
    return result;
  }

  InsoleMessage._();

  factory InsoleMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsoleMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, InsoleMessage_Msg> _InsoleMessage_MsgByTag =
      {
    2: InsoleMessage_Msg.insoleInfoReq,
    3: InsoleMessage_Msg.moticonInsoleInfo,
    9: InsoleMessage_Msg.zeroing,
    10: InsoleMessage_Msg.zeroingConf,
    12: InsoleMessage_Msg.dataMessage,
    13: InsoleMessage_Msg.startService,
    14: InsoleMessage_Msg.startServiceConf,
    15: InsoleMessage_Msg.stopService,
    16: InsoleMessage_Msg.stopServiceConf,
    21: InsoleMessage_Msg.serviceInfoReq,
    22: InsoleMessage_Msg.serviceInfo,
    0: InsoleMessage_Msg.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsoleMessage',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto.insole'),
      createEmptyInstance: create)
    ..oo(0, [2, 3, 9, 10, 12, 13, 14, 15, 16, 21, 22])
    ..aOM<InsoleInfoReq>(2, _omitFieldNames ? '' : 'insoleInfoReq',
        subBuilder: InsoleInfoReq.create)
    ..aOM<MoticonInsoleInfo>(3, _omitFieldNames ? '' : 'moticonInsoleInfo',
        subBuilder: MoticonInsoleInfo.create)
    ..aOM<$0.Zeroing>(9, _omitFieldNames ? '' : 'zeroing',
        subBuilder: $0.Zeroing.create)
    ..aOM<$0.ZeroingConf>(10, _omitFieldNames ? '' : 'zeroingConf',
        subBuilder: $0.ZeroingConf.create)
    ..aOM<$0.DataMessage>(12, _omitFieldNames ? '' : 'dataMessage',
        subBuilder: $0.DataMessage.create)
    ..aOM<InsoleStartService>(13, _omitFieldNames ? '' : 'startService',
        subBuilder: InsoleStartService.create)
    ..aOM<$0.InsoleStartServiceConf>(
        14, _omitFieldNames ? '' : 'startServiceConf',
        subBuilder: $0.InsoleStartServiceConf.create)
    ..aOM<InsoleStopService>(15, _omitFieldNames ? '' : 'stopService',
        subBuilder: InsoleStopService.create)
    ..aOM<InsoleStopServiceConf>(16, _omitFieldNames ? '' : 'stopServiceConf',
        subBuilder: InsoleStopServiceConf.create)
    ..aOM<ServiceInfoReq>(21, _omitFieldNames ? '' : 'serviceInfoReq',
        subBuilder: ServiceInfoReq.create)
    ..aOM<ServiceInfo>(22, _omitFieldNames ? '' : 'serviceInfo',
        subBuilder: ServiceInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleMessage copyWith(void Function(InsoleMessage) updates) =>
      super.copyWith((message) => updates(message as InsoleMessage))
          as InsoleMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsoleMessage create() => InsoleMessage._();
  @$core.override
  InsoleMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InsoleMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsoleMessage>(create);
  static InsoleMessage? _defaultInstance;

  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  @$pb.TagNumber(15)
  @$pb.TagNumber(16)
  @$pb.TagNumber(21)
  @$pb.TagNumber(22)
  InsoleMessage_Msg whichMsg() => _InsoleMessage_MsgByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  @$pb.TagNumber(15)
  @$pb.TagNumber(16)
  @$pb.TagNumber(21)
  @$pb.TagNumber(22)
  void clearMsg() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(2)
  InsoleInfoReq get insoleInfoReq => $_getN(0);
  @$pb.TagNumber(2)
  set insoleInfoReq(InsoleInfoReq value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasInsoleInfoReq() => $_has(0);
  @$pb.TagNumber(2)
  void clearInsoleInfoReq() => $_clearField(2);
  @$pb.TagNumber(2)
  InsoleInfoReq ensureInsoleInfoReq() => $_ensure(0);

  @$pb.TagNumber(3)
  MoticonInsoleInfo get moticonInsoleInfo => $_getN(1);
  @$pb.TagNumber(3)
  set moticonInsoleInfo(MoticonInsoleInfo value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasMoticonInsoleInfo() => $_has(1);
  @$pb.TagNumber(3)
  void clearMoticonInsoleInfo() => $_clearField(3);
  @$pb.TagNumber(3)
  MoticonInsoleInfo ensureMoticonInsoleInfo() => $_ensure(1);

  @$pb.TagNumber(9)
  $0.Zeroing get zeroing => $_getN(2);
  @$pb.TagNumber(9)
  set zeroing($0.Zeroing value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasZeroing() => $_has(2);
  @$pb.TagNumber(9)
  void clearZeroing() => $_clearField(9);
  @$pb.TagNumber(9)
  $0.Zeroing ensureZeroing() => $_ensure(2);

  @$pb.TagNumber(10)
  $0.ZeroingConf get zeroingConf => $_getN(3);
  @$pb.TagNumber(10)
  set zeroingConf($0.ZeroingConf value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasZeroingConf() => $_has(3);
  @$pb.TagNumber(10)
  void clearZeroingConf() => $_clearField(10);
  @$pb.TagNumber(10)
  $0.ZeroingConf ensureZeroingConf() => $_ensure(3);

  @$pb.TagNumber(12)
  $0.DataMessage get dataMessage => $_getN(4);
  @$pb.TagNumber(12)
  set dataMessage($0.DataMessage value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasDataMessage() => $_has(4);
  @$pb.TagNumber(12)
  void clearDataMessage() => $_clearField(12);
  @$pb.TagNumber(12)
  $0.DataMessage ensureDataMessage() => $_ensure(4);

  @$pb.TagNumber(13)
  InsoleStartService get startService => $_getN(5);
  @$pb.TagNumber(13)
  set startService(InsoleStartService value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasStartService() => $_has(5);
  @$pb.TagNumber(13)
  void clearStartService() => $_clearField(13);
  @$pb.TagNumber(13)
  InsoleStartService ensureStartService() => $_ensure(5);

  @$pb.TagNumber(14)
  $0.InsoleStartServiceConf get startServiceConf => $_getN(6);
  @$pb.TagNumber(14)
  set startServiceConf($0.InsoleStartServiceConf value) =>
      $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasStartServiceConf() => $_has(6);
  @$pb.TagNumber(14)
  void clearStartServiceConf() => $_clearField(14);
  @$pb.TagNumber(14)
  $0.InsoleStartServiceConf ensureStartServiceConf() => $_ensure(6);

  @$pb.TagNumber(15)
  InsoleStopService get stopService => $_getN(7);
  @$pb.TagNumber(15)
  set stopService(InsoleStopService value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasStopService() => $_has(7);
  @$pb.TagNumber(15)
  void clearStopService() => $_clearField(15);
  @$pb.TagNumber(15)
  InsoleStopService ensureStopService() => $_ensure(7);

  @$pb.TagNumber(16)
  InsoleStopServiceConf get stopServiceConf => $_getN(8);
  @$pb.TagNumber(16)
  set stopServiceConf(InsoleStopServiceConf value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasStopServiceConf() => $_has(8);
  @$pb.TagNumber(16)
  void clearStopServiceConf() => $_clearField(16);
  @$pb.TagNumber(16)
  InsoleStopServiceConf ensureStopServiceConf() => $_ensure(8);

  @$pb.TagNumber(21)
  ServiceInfoReq get serviceInfoReq => $_getN(9);
  @$pb.TagNumber(21)
  set serviceInfoReq(ServiceInfoReq value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasServiceInfoReq() => $_has(9);
  @$pb.TagNumber(21)
  void clearServiceInfoReq() => $_clearField(21);
  @$pb.TagNumber(21)
  ServiceInfoReq ensureServiceInfoReq() => $_ensure(9);

  @$pb.TagNumber(22)
  ServiceInfo get serviceInfo => $_getN(10);
  @$pb.TagNumber(22)
  set serviceInfo(ServiceInfo value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasServiceInfo() => $_has(10);
  @$pb.TagNumber(22)
  void clearServiceInfo() => $_clearField(22);
  @$pb.TagNumber(22)
  ServiceInfo ensureServiceInfo() => $_ensure(10);
}

class MoticonInsoleInfo extends $pb.GeneratedMessage {
  factory MoticonInsoleInfo({
    $0.InsoleInfoType? type,
    $0.InsoleStatus? insoleStatus,
    $0.InsoleState? insoleState,
    $0.InsoleSettings? insoleSettings,
    $0.SensorCoordinates? sensorCoordinates,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (insoleStatus != null) result.insoleStatus = insoleStatus;
    if (insoleState != null) result.insoleState = insoleState;
    if (insoleSettings != null) result.insoleSettings = insoleSettings;
    if (sensorCoordinates != null) result.sensorCoordinates = sensorCoordinates;
    return result;
  }

  MoticonInsoleInfo._();

  factory MoticonInsoleInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MoticonInsoleInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MoticonInsoleInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto.insole'),
      createEmptyInstance: create)
    ..aE<$0.InsoleInfoType>(1, _omitFieldNames ? '' : 'type',
        enumValues: $0.InsoleInfoType.values)
    ..aOM<$0.InsoleStatus>(2, _omitFieldNames ? '' : 'insoleStatus',
        subBuilder: $0.InsoleStatus.create)
    ..aOM<$0.InsoleState>(3, _omitFieldNames ? '' : 'insoleState',
        subBuilder: $0.InsoleState.create)
    ..aOM<$0.InsoleSettings>(4, _omitFieldNames ? '' : 'insoleSettings',
        subBuilder: $0.InsoleSettings.create)
    ..aOM<$0.SensorCoordinates>(5, _omitFieldNames ? '' : 'sensorCoordinates',
        subBuilder: $0.SensorCoordinates.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoticonInsoleInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoticonInsoleInfo copyWith(void Function(MoticonInsoleInfo) updates) =>
      super.copyWith((message) => updates(message as MoticonInsoleInfo))
          as MoticonInsoleInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoticonInsoleInfo create() => MoticonInsoleInfo._();
  @$core.override
  MoticonInsoleInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MoticonInsoleInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MoticonInsoleInfo>(create);
  static MoticonInsoleInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $0.InsoleInfoType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type($0.InsoleInfoType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.InsoleStatus get insoleStatus => $_getN(1);
  @$pb.TagNumber(2)
  set insoleStatus($0.InsoleStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasInsoleStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearInsoleStatus() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.InsoleStatus ensureInsoleStatus() => $_ensure(1);

  @$pb.TagNumber(3)
  $0.InsoleState get insoleState => $_getN(2);
  @$pb.TagNumber(3)
  set insoleState($0.InsoleState value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasInsoleState() => $_has(2);
  @$pb.TagNumber(3)
  void clearInsoleState() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.InsoleState ensureInsoleState() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.InsoleSettings get insoleSettings => $_getN(3);
  @$pb.TagNumber(4)
  set insoleSettings($0.InsoleSettings value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasInsoleSettings() => $_has(3);
  @$pb.TagNumber(4)
  void clearInsoleSettings() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.InsoleSettings ensureInsoleSettings() => $_ensure(3);

  @$pb.TagNumber(5)
  $0.SensorCoordinates get sensorCoordinates => $_getN(4);
  @$pb.TagNumber(5)
  set sensorCoordinates($0.SensorCoordinates value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSensorCoordinates() => $_has(4);
  @$pb.TagNumber(5)
  void clearSensorCoordinates() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.SensorCoordinates ensureSensorCoordinates() => $_ensure(4);
}

class ServiceInfoReq extends $pb.GeneratedMessage {
  factory ServiceInfoReq({
    $0.ServiceType? queriedServiceType,
  }) {
    final result = create();
    if (queriedServiceType != null)
      result.queriedServiceType = queriedServiceType;
    return result;
  }

  ServiceInfoReq._();

  factory ServiceInfoReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ServiceInfoReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceInfoReq',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto.insole'),
      createEmptyInstance: create)
    ..aE<$0.ServiceType>(1, _omitFieldNames ? '' : 'queriedServiceType',
        enumValues: $0.ServiceType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceInfoReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceInfoReq copyWith(void Function(ServiceInfoReq) updates) =>
      super.copyWith((message) => updates(message as ServiceInfoReq))
          as ServiceInfoReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceInfoReq create() => ServiceInfoReq._();
  @$core.override
  ServiceInfoReq createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ServiceInfoReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServiceInfoReq>(create);
  static ServiceInfoReq? _defaultInstance;

  @$pb.TagNumber(1)
  $0.ServiceType get queriedServiceType => $_getN(0);
  @$pb.TagNumber(1)
  set queriedServiceType($0.ServiceType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasQueriedServiceType() => $_has(0);
  @$pb.TagNumber(1)
  void clearQueriedServiceType() => $_clearField(1);
}

class ServiceInfo extends $pb.GeneratedMessage {
  factory ServiceInfo({
    $0.ServiceType? queriedServiceType,
    $core.Iterable<$0.ServiceConfig>? serviceConfig,
  }) {
    final result = create();
    if (queriedServiceType != null)
      result.queriedServiceType = queriedServiceType;
    if (serviceConfig != null) result.serviceConfig.addAll(serviceConfig);
    return result;
  }

  ServiceInfo._();

  factory ServiceInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ServiceInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto.insole'),
      createEmptyInstance: create)
    ..aE<$0.ServiceType>(1, _omitFieldNames ? '' : 'queriedServiceType',
        enumValues: $0.ServiceType.values)
    ..pPM<$0.ServiceConfig>(2, _omitFieldNames ? '' : 'serviceConfig',
        subBuilder: $0.ServiceConfig.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceInfo copyWith(void Function(ServiceInfo) updates) =>
      super.copyWith((message) => updates(message as ServiceInfo))
          as ServiceInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceInfo create() => ServiceInfo._();
  @$core.override
  ServiceInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ServiceInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServiceInfo>(create);
  static ServiceInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $0.ServiceType get queriedServiceType => $_getN(0);
  @$pb.TagNumber(1)
  set queriedServiceType($0.ServiceType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasQueriedServiceType() => $_has(0);
  @$pb.TagNumber(1)
  void clearQueriedServiceType() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$0.ServiceConfig> get serviceConfig => $_getList(1);
}

class InsoleInfoReq extends $pb.GeneratedMessage {
  factory InsoleInfoReq({
    $0.InsoleInfoType? type,
  }) {
    final result = create();
    if (type != null) result.type = type;
    return result;
  }

  InsoleInfoReq._();

  factory InsoleInfoReq.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsoleInfoReq.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsoleInfoReq',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto.insole'),
      createEmptyInstance: create)
    ..aE<$0.InsoleInfoType>(1, _omitFieldNames ? '' : 'type',
        enumValues: $0.InsoleInfoType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleInfoReq clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleInfoReq copyWith(void Function(InsoleInfoReq) updates) =>
      super.copyWith((message) => updates(message as InsoleInfoReq))
          as InsoleInfoReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsoleInfoReq create() => InsoleInfoReq._();
  @$core.override
  InsoleInfoReq createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InsoleInfoReq getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsoleInfoReq>(create);
  static InsoleInfoReq? _defaultInstance;

  @$pb.TagNumber(1)
  $0.InsoleInfoType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type($0.InsoleInfoType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);
}

class InsoleStartService extends $pb.GeneratedMessage {
  factory InsoleStartService({
    $0.ServiceConfig? serviceConfig,
    $0.MeasurementInfo? measurementInfo,
  }) {
    final result = create();
    if (serviceConfig != null) result.serviceConfig = serviceConfig;
    if (measurementInfo != null) result.measurementInfo = measurementInfo;
    return result;
  }

  InsoleStartService._();

  factory InsoleStartService.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsoleStartService.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsoleStartService',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto.insole'),
      createEmptyInstance: create)
    ..aOM<$0.ServiceConfig>(1, _omitFieldNames ? '' : 'serviceConfig',
        subBuilder: $0.ServiceConfig.create)
    ..aOM<$0.MeasurementInfo>(2, _omitFieldNames ? '' : 'measurementInfo',
        subBuilder: $0.MeasurementInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleStartService clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleStartService copyWith(void Function(InsoleStartService) updates) =>
      super.copyWith((message) => updates(message as InsoleStartService))
          as InsoleStartService;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsoleStartService create() => InsoleStartService._();
  @$core.override
  InsoleStartService createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InsoleStartService getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsoleStartService>(create);
  static InsoleStartService? _defaultInstance;

  @$pb.TagNumber(1)
  $0.ServiceConfig get serviceConfig => $_getN(0);
  @$pb.TagNumber(1)
  set serviceConfig($0.ServiceConfig value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasServiceConfig() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceConfig() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.ServiceConfig ensureServiceConfig() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.MeasurementInfo get measurementInfo => $_getN(1);
  @$pb.TagNumber(2)
  set measurementInfo($0.MeasurementInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMeasurementInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearMeasurementInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.MeasurementInfo ensureMeasurementInfo() => $_ensure(1);
}

class InsoleStopService extends $pb.GeneratedMessage {
  factory InsoleStopService({
    $core.int? serviceCounter,
  }) {
    final result = create();
    if (serviceCounter != null) result.serviceCounter = serviceCounter;
    return result;
  }

  InsoleStopService._();

  factory InsoleStopService.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsoleStopService.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsoleStopService',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto.insole'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'serviceCounter',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleStopService clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleStopService copyWith(void Function(InsoleStopService) updates) =>
      super.copyWith((message) => updates(message as InsoleStopService))
          as InsoleStopService;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsoleStopService create() => InsoleStopService._();
  @$core.override
  InsoleStopService createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InsoleStopService getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsoleStopService>(create);
  static InsoleStopService? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get serviceCounter => $_getIZ(0);
  @$pb.TagNumber(1)
  set serviceCounter($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasServiceCounter() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceCounter() => $_clearField(1);
}

class InsoleStopServiceConf extends $pb.GeneratedMessage {
  factory InsoleStopServiceConf({
    $0.Error? error,
  }) {
    final result = create();
    if (error != null) result.error = error;
    return result;
  }

  InsoleStopServiceConf._();

  factory InsoleStopServiceConf.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsoleStopServiceConf.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsoleStopServiceConf',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto.insole'),
      createEmptyInstance: create)
    ..aOM<$0.Error>(1, _omitFieldNames ? '' : 'error',
        subBuilder: $0.Error.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleStopServiceConf clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleStopServiceConf copyWith(
          void Function(InsoleStopServiceConf) updates) =>
      super.copyWith((message) => updates(message as InsoleStopServiceConf))
          as InsoleStopServiceConf;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsoleStopServiceConf create() => InsoleStopServiceConf._();
  @$core.override
  InsoleStopServiceConf createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InsoleStopServiceConf getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsoleStopServiceConf>(create);
  static InsoleStopServiceConf? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Error get error => $_getN(0);
  @$pb.TagNumber(1)
  set error($0.Error value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Error ensureError() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
