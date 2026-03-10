// This is a generated file - do not edit.
//
// Generated from common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'common.pbenum.dart';

class Error extends $pb.GeneratedMessage {
  factory Error({
    ErrorCode? errorCode,
    $core.String? message,
  }) {
    final result = create();
    if (errorCode != null) result.errorCode = errorCode;
    if (message != null) result.message = message;
    return result;
  }

  Error._();

  factory Error.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Error.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Error',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aE<ErrorCode>(1, _omitFieldNames ? '' : 'errorCode',
        enumValues: ErrorCode.values)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Error clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Error copyWith(void Function(Error) updates) =>
      super.copyWith((message) => updates(message as Error)) as Error;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Error create() => Error._();
  @$core.override
  Error createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Error getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Error>(create);
  static Error? _defaultInstance;

  @$pb.TagNumber(1)
  ErrorCode get errorCode => $_getN(0);
  @$pb.TagNumber(1)
  set errorCode(ErrorCode value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasErrorCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearErrorCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class Version extends $pb.GeneratedMessage {
  factory Version({
    $core.int? major,
    $core.int? minor,
    $core.int? bugfix,
  }) {
    final result = create();
    if (major != null) result.major = major;
    if (minor != null) result.minor = minor;
    if (bugfix != null) result.bugfix = bugfix;
    return result;
  }

  Version._();

  factory Version.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Version.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Version',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'major', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'minor', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'bugfix', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Version clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Version copyWith(void Function(Version) updates) =>
      super.copyWith((message) => updates(message as Version)) as Version;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Version create() => Version._();
  @$core.override
  Version createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Version getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Version>(create);
  static Version? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get major => $_getIZ(0);
  @$pb.TagNumber(1)
  set major($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMajor() => $_has(0);
  @$pb.TagNumber(1)
  void clearMajor() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get minor => $_getIZ(1);
  @$pb.TagNumber(2)
  set minor($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearMinor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get bugfix => $_getIZ(2);
  @$pb.TagNumber(3)
  set bugfix($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBugfix() => $_has(2);
  @$pb.TagNumber(3)
  void clearBugfix() => $_clearField(3);
}

class ServiceId extends $pb.GeneratedMessage {
  factory ServiceId({
    $core.int? leftSerialNumber,
    $core.int? rightSerialNumber,
    $core.int? serviceCounter,
  }) {
    final result = create();
    if (leftSerialNumber != null) result.leftSerialNumber = leftSerialNumber;
    if (rightSerialNumber != null) result.rightSerialNumber = rightSerialNumber;
    if (serviceCounter != null) result.serviceCounter = serviceCounter;
    return result;
  }

  ServiceId._();

  factory ServiceId.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ServiceId.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceId',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'leftSerialNumber',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'rightSerialNumber',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'serviceCounter',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceId clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceId copyWith(void Function(ServiceId) updates) =>
      super.copyWith((message) => updates(message as ServiceId)) as ServiceId;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceId create() => ServiceId._();
  @$core.override
  ServiceId createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ServiceId getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ServiceId>(create);
  static ServiceId? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get leftSerialNumber => $_getIZ(0);
  @$pb.TagNumber(1)
  set leftSerialNumber($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLeftSerialNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearLeftSerialNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get rightSerialNumber => $_getIZ(1);
  @$pb.TagNumber(2)
  set rightSerialNumber($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRightSerialNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearRightSerialNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get serviceCounter => $_getIZ(2);
  @$pb.TagNumber(3)
  set serviceCounter($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasServiceCounter() => $_has(2);
  @$pb.TagNumber(3)
  void clearServiceCounter() => $_clearField(3);
}

class ServiceConfig extends $pb.GeneratedMessage {
  factory ServiceConfig({
    $fixnum.Int64? serviceStartTime,
    ServiceId? serviceId,
    ServiceType? serviceType,
    $core.int? rate,
    $core.Iterable<$core.bool>? enabledPressure,
    $core.Iterable<$core.bool>? enabledAcceleration,
    ServiceConfig_AccGRange? accGRange,
    ServiceConfig_AccOdr? accOdr,
    $core.Iterable<$core.bool>? enabledAngular,
    ServiceConfig_AngDpsRange? angDpsRange,
    ServiceConfig_AngOdr? angOdr,
    $core.bool? enabledTemperature,
    $core.bool? enabledTotalForce,
    $core.Iterable<$core.bool>? enabledCop,
    ServiceConfig_ActivityProfile? activityProfile,
    $core.int? recTimeout,
    ServiceConfig_ActivitySensitivity? activitySensitivity,
    $core.int? recFlushInterval,
    $core.bool? isPreview,
  }) {
    final result = create();
    if (serviceStartTime != null) result.serviceStartTime = serviceStartTime;
    if (serviceId != null) result.serviceId = serviceId;
    if (serviceType != null) result.serviceType = serviceType;
    if (rate != null) result.rate = rate;
    if (enabledPressure != null) result.enabledPressure.addAll(enabledPressure);
    if (enabledAcceleration != null)
      result.enabledAcceleration.addAll(enabledAcceleration);
    if (accGRange != null) result.accGRange = accGRange;
    if (accOdr != null) result.accOdr = accOdr;
    if (enabledAngular != null) result.enabledAngular.addAll(enabledAngular);
    if (angDpsRange != null) result.angDpsRange = angDpsRange;
    if (angOdr != null) result.angOdr = angOdr;
    if (enabledTemperature != null)
      result.enabledTemperature = enabledTemperature;
    if (enabledTotalForce != null) result.enabledTotalForce = enabledTotalForce;
    if (enabledCop != null) result.enabledCop.addAll(enabledCop);
    if (activityProfile != null) result.activityProfile = activityProfile;
    if (recTimeout != null) result.recTimeout = recTimeout;
    if (activitySensitivity != null)
      result.activitySensitivity = activitySensitivity;
    if (recFlushInterval != null) result.recFlushInterval = recFlushInterval;
    if (isPreview != null) result.isPreview = isPreview;
    return result;
  }

  ServiceConfig._();

  factory ServiceConfig.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ServiceConfig.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceConfig',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'serviceStartTime', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<ServiceId>(2, _omitFieldNames ? '' : 'serviceId',
        subBuilder: ServiceId.create)
    ..aE<ServiceType>(3, _omitFieldNames ? '' : 'serviceType',
        enumValues: ServiceType.values)
    ..aI(5, _omitFieldNames ? '' : 'rate', fieldType: $pb.PbFieldType.OU3)
    ..p<$core.bool>(
        6, _omitFieldNames ? '' : 'enabledPressure', $pb.PbFieldType.KB)
    ..p<$core.bool>(
        7, _omitFieldNames ? '' : 'enabledAcceleration', $pb.PbFieldType.KB)
    ..aE<ServiceConfig_AccGRange>(8, _omitFieldNames ? '' : 'accGRange',
        enumValues: ServiceConfig_AccGRange.values)
    ..aE<ServiceConfig_AccOdr>(9, _omitFieldNames ? '' : 'accOdr',
        enumValues: ServiceConfig_AccOdr.values)
    ..p<$core.bool>(
        10, _omitFieldNames ? '' : 'enabledAngular', $pb.PbFieldType.KB)
    ..aE<ServiceConfig_AngDpsRange>(11, _omitFieldNames ? '' : 'angDpsRange',
        enumValues: ServiceConfig_AngDpsRange.values)
    ..aE<ServiceConfig_AngOdr>(12, _omitFieldNames ? '' : 'angOdr',
        enumValues: ServiceConfig_AngOdr.values)
    ..aOB(13, _omitFieldNames ? '' : 'enabledTemperature')
    ..aOB(14, _omitFieldNames ? '' : 'enabledTotalForce')
    ..p<$core.bool>(15, _omitFieldNames ? '' : 'enabledCop', $pb.PbFieldType.KB)
    ..aE<ServiceConfig_ActivityProfile>(
        19, _omitFieldNames ? '' : 'activityProfile',
        enumValues: ServiceConfig_ActivityProfile.values)
    ..aI(21, _omitFieldNames ? '' : 'recTimeout',
        fieldType: $pb.PbFieldType.OU3)
    ..aE<ServiceConfig_ActivitySensitivity>(
        22, _omitFieldNames ? '' : 'activitySensitivity',
        enumValues: ServiceConfig_ActivitySensitivity.values)
    ..aI(23, _omitFieldNames ? '' : 'recFlushInterval',
        fieldType: $pb.PbFieldType.OU3)
    ..aOB(24, _omitFieldNames ? '' : 'isPreview')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceConfig clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceConfig copyWith(void Function(ServiceConfig) updates) =>
      super.copyWith((message) => updates(message as ServiceConfig))
          as ServiceConfig;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceConfig create() => ServiceConfig._();
  @$core.override
  ServiceConfig createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ServiceConfig getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServiceConfig>(create);
  static ServiceConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get serviceStartTime => $_getI64(0);
  @$pb.TagNumber(1)
  set serviceStartTime($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasServiceStartTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceStartTime() => $_clearField(1);

  @$pb.TagNumber(2)
  ServiceId get serviceId => $_getN(1);
  @$pb.TagNumber(2)
  set serviceId(ServiceId value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasServiceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearServiceId() => $_clearField(2);
  @$pb.TagNumber(2)
  ServiceId ensureServiceId() => $_ensure(1);

  @$pb.TagNumber(3)
  ServiceType get serviceType => $_getN(2);
  @$pb.TagNumber(3)
  set serviceType(ServiceType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasServiceType() => $_has(2);
  @$pb.TagNumber(3)
  void clearServiceType() => $_clearField(3);

  @$pb.TagNumber(5)
  $core.int get rate => $_getIZ(3);
  @$pb.TagNumber(5)
  set rate($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(5)
  $core.bool hasRate() => $_has(3);
  @$pb.TagNumber(5)
  void clearRate() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.bool> get enabledPressure => $_getList(4);

  @$pb.TagNumber(7)
  $pb.PbList<$core.bool> get enabledAcceleration => $_getList(5);

  @$pb.TagNumber(8)
  ServiceConfig_AccGRange get accGRange => $_getN(6);
  @$pb.TagNumber(8)
  set accGRange(ServiceConfig_AccGRange value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasAccGRange() => $_has(6);
  @$pb.TagNumber(8)
  void clearAccGRange() => $_clearField(8);

  @$pb.TagNumber(9)
  ServiceConfig_AccOdr get accOdr => $_getN(7);
  @$pb.TagNumber(9)
  set accOdr(ServiceConfig_AccOdr value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasAccOdr() => $_has(7);
  @$pb.TagNumber(9)
  void clearAccOdr() => $_clearField(9);

  @$pb.TagNumber(10)
  $pb.PbList<$core.bool> get enabledAngular => $_getList(8);

  @$pb.TagNumber(11)
  ServiceConfig_AngDpsRange get angDpsRange => $_getN(9);
  @$pb.TagNumber(11)
  set angDpsRange(ServiceConfig_AngDpsRange value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasAngDpsRange() => $_has(9);
  @$pb.TagNumber(11)
  void clearAngDpsRange() => $_clearField(11);

  @$pb.TagNumber(12)
  ServiceConfig_AngOdr get angOdr => $_getN(10);
  @$pb.TagNumber(12)
  set angOdr(ServiceConfig_AngOdr value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasAngOdr() => $_has(10);
  @$pb.TagNumber(12)
  void clearAngOdr() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.bool get enabledTemperature => $_getBF(11);
  @$pb.TagNumber(13)
  set enabledTemperature($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(13)
  $core.bool hasEnabledTemperature() => $_has(11);
  @$pb.TagNumber(13)
  void clearEnabledTemperature() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.bool get enabledTotalForce => $_getBF(12);
  @$pb.TagNumber(14)
  set enabledTotalForce($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(14)
  $core.bool hasEnabledTotalForce() => $_has(12);
  @$pb.TagNumber(14)
  void clearEnabledTotalForce() => $_clearField(14);

  @$pb.TagNumber(15)
  $pb.PbList<$core.bool> get enabledCop => $_getList(13);

  @$pb.TagNumber(19)
  ServiceConfig_ActivityProfile get activityProfile => $_getN(14);
  @$pb.TagNumber(19)
  set activityProfile(ServiceConfig_ActivityProfile value) =>
      $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasActivityProfile() => $_has(14);
  @$pb.TagNumber(19)
  void clearActivityProfile() => $_clearField(19);

  @$pb.TagNumber(21)
  $core.int get recTimeout => $_getIZ(15);
  @$pb.TagNumber(21)
  set recTimeout($core.int value) => $_setUnsignedInt32(15, value);
  @$pb.TagNumber(21)
  $core.bool hasRecTimeout() => $_has(15);
  @$pb.TagNumber(21)
  void clearRecTimeout() => $_clearField(21);

  @$pb.TagNumber(22)
  ServiceConfig_ActivitySensitivity get activitySensitivity => $_getN(16);
  @$pb.TagNumber(22)
  set activitySensitivity(ServiceConfig_ActivitySensitivity value) =>
      $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasActivitySensitivity() => $_has(16);
  @$pb.TagNumber(22)
  void clearActivitySensitivity() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.int get recFlushInterval => $_getIZ(17);
  @$pb.TagNumber(23)
  set recFlushInterval($core.int value) => $_setUnsignedInt32(17, value);
  @$pb.TagNumber(23)
  $core.bool hasRecFlushInterval() => $_has(17);
  @$pb.TagNumber(23)
  void clearRecFlushInterval() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.bool get isPreview => $_getBF(18);
  @$pb.TagNumber(24)
  set isPreview($core.bool value) => $_setBool(18, value);
  @$pb.TagNumber(24)
  $core.bool hasIsPreview() => $_has(18);
  @$pb.TagNumber(24)
  void clearIsPreview() => $_clearField(24);
}

class InsoleStatus extends $pb.GeneratedMessage {
  factory InsoleStatus({
    $core.int? memoryUsage,
    $core.int? batteryLevel,
    $core.int? restartCounter,
    $fixnum.Int64? sysClock,
    $core.int? eraseProgress,
    ZeroingStatus? zeroingStatus,
  }) {
    final result = create();
    if (memoryUsage != null) result.memoryUsage = memoryUsage;
    if (batteryLevel != null) result.batteryLevel = batteryLevel;
    if (restartCounter != null) result.restartCounter = restartCounter;
    if (sysClock != null) result.sysClock = sysClock;
    if (eraseProgress != null) result.eraseProgress = eraseProgress;
    if (zeroingStatus != null) result.zeroingStatus = zeroingStatus;
    return result;
  }

  InsoleStatus._();

  factory InsoleStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsoleStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsoleStatus',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'memoryUsage',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'batteryLevel',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'restartCounter',
        fieldType: $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'sysClock', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aI(5, _omitFieldNames ? '' : 'eraseProgress',
        fieldType: $pb.PbFieldType.OU3)
    ..aOM<ZeroingStatus>(7, _omitFieldNames ? '' : 'zeroingStatus',
        subBuilder: ZeroingStatus.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleStatus copyWith(void Function(InsoleStatus) updates) =>
      super.copyWith((message) => updates(message as InsoleStatus))
          as InsoleStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsoleStatus create() => InsoleStatus._();
  @$core.override
  InsoleStatus createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InsoleStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsoleStatus>(create);
  static InsoleStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get memoryUsage => $_getIZ(0);
  @$pb.TagNumber(1)
  set memoryUsage($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMemoryUsage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMemoryUsage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get batteryLevel => $_getIZ(1);
  @$pb.TagNumber(2)
  set batteryLevel($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBatteryLevel() => $_has(1);
  @$pb.TagNumber(2)
  void clearBatteryLevel() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get restartCounter => $_getIZ(2);
  @$pb.TagNumber(3)
  set restartCounter($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRestartCounter() => $_has(2);
  @$pb.TagNumber(3)
  void clearRestartCounter() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get sysClock => $_getI64(3);
  @$pb.TagNumber(4)
  set sysClock($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSysClock() => $_has(3);
  @$pb.TagNumber(4)
  void clearSysClock() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get eraseProgress => $_getIZ(4);
  @$pb.TagNumber(5)
  set eraseProgress($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEraseProgress() => $_has(4);
  @$pb.TagNumber(5)
  void clearEraseProgress() => $_clearField(5);

  @$pb.TagNumber(7)
  ZeroingStatus get zeroingStatus => $_getN(5);
  @$pb.TagNumber(7)
  set zeroingStatus(ZeroingStatus value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasZeroingStatus() => $_has(5);
  @$pb.TagNumber(7)
  void clearZeroingStatus() => $_clearField(7);
  @$pb.TagNumber(7)
  ZeroingStatus ensureZeroingStatus() => $_ensure(5);
}

class InsoleState extends $pb.GeneratedMessage {
  factory InsoleState({
    $fixnum.Int64? onTime,
    $fixnum.Int64? useTime,
    $core.int? restartCounter,
    $fixnum.Int64? sysClock,
    $fixnum.Int64? defectSensors,
    $fixnum.Int64? forceCycles,
    $fixnum.Int64? forceIntegral,
  }) {
    final result = create();
    if (onTime != null) result.onTime = onTime;
    if (useTime != null) result.useTime = useTime;
    if (restartCounter != null) result.restartCounter = restartCounter;
    if (sysClock != null) result.sysClock = sysClock;
    if (defectSensors != null) result.defectSensors = defectSensors;
    if (forceCycles != null) result.forceCycles = forceCycles;
    if (forceIntegral != null) result.forceIntegral = forceIntegral;
    return result;
  }

  InsoleState._();

  factory InsoleState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsoleState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsoleState',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'onTime', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'useTime', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aI(3, _omitFieldNames ? '' : 'restartCounter',
        fieldType: $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'sysClock', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        7, _omitFieldNames ? '' : 'defectSensors', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        9, _omitFieldNames ? '' : 'forceCycles', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        10, _omitFieldNames ? '' : 'forceIntegral', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleState clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleState copyWith(void Function(InsoleState) updates) =>
      super.copyWith((message) => updates(message as InsoleState))
          as InsoleState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsoleState create() => InsoleState._();
  @$core.override
  InsoleState createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InsoleState getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsoleState>(create);
  static InsoleState? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get onTime => $_getI64(0);
  @$pb.TagNumber(1)
  set onTime($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOnTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearOnTime() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get useTime => $_getI64(1);
  @$pb.TagNumber(2)
  set useTime($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUseTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearUseTime() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get restartCounter => $_getIZ(2);
  @$pb.TagNumber(3)
  set restartCounter($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRestartCounter() => $_has(2);
  @$pb.TagNumber(3)
  void clearRestartCounter() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get sysClock => $_getI64(3);
  @$pb.TagNumber(4)
  set sysClock($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSysClock() => $_has(3);
  @$pb.TagNumber(4)
  void clearSysClock() => $_clearField(4);

  @$pb.TagNumber(7)
  $fixnum.Int64 get defectSensors => $_getI64(4);
  @$pb.TagNumber(7)
  set defectSensors($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(7)
  $core.bool hasDefectSensors() => $_has(4);
  @$pb.TagNumber(7)
  void clearDefectSensors() => $_clearField(7);

  @$pb.TagNumber(9)
  $fixnum.Int64 get forceCycles => $_getI64(5);
  @$pb.TagNumber(9)
  set forceCycles($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(9)
  $core.bool hasForceCycles() => $_has(5);
  @$pb.TagNumber(9)
  void clearForceCycles() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get forceIntegral => $_getI64(6);
  @$pb.TagNumber(10)
  set forceIntegral($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(10)
  $core.bool hasForceIntegral() => $_has(6);
  @$pb.TagNumber(10)
  void clearForceIntegral() => $_clearField(10);
}

class ZeroingStatus extends $pb.GeneratedMessage {
  factory ZeroingStatus({
    $core.int? confidence,
    $core.int? validityPeriod,
    $core.int? warmup,
  }) {
    final result = create();
    if (confidence != null) result.confidence = confidence;
    if (validityPeriod != null) result.validityPeriod = validityPeriod;
    if (warmup != null) result.warmup = warmup;
    return result;
  }

  ZeroingStatus._();

  factory ZeroingStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ZeroingStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ZeroingStatus',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'confidence', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'validityPeriod',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'warmup', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZeroingStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZeroingStatus copyWith(void Function(ZeroingStatus) updates) =>
      super.copyWith((message) => updates(message as ZeroingStatus))
          as ZeroingStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ZeroingStatus create() => ZeroingStatus._();
  @$core.override
  ZeroingStatus createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ZeroingStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ZeroingStatus>(create);
  static ZeroingStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get confidence => $_getIZ(0);
  @$pb.TagNumber(1)
  set confidence($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConfidence() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfidence() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get validityPeriod => $_getIZ(1);
  @$pb.TagNumber(2)
  set validityPeriod($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValidityPeriod() => $_has(1);
  @$pb.TagNumber(2)
  void clearValidityPeriod() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get warmup => $_getIZ(2);
  @$pb.TagNumber(3)
  set warmup($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWarmup() => $_has(2);
  @$pb.TagNumber(3)
  void clearWarmup() => $_clearField(3);
}

class InsoleSettings extends $pb.GeneratedMessage {
  factory InsoleSettings({
    $core.int? serialNumber,
    $core.int? size,
    Side? side,
    $core.int? numSensors,
    $core.List<$core.int>? mpuHash,
    Version? mpuVersion,
    $core.bool? mpuModified,
    $core.int? memorySize,
    Zeroing? zeroing,
    $core.int? fwVersionCode,
  }) {
    final result = create();
    if (serialNumber != null) result.serialNumber = serialNumber;
    if (size != null) result.size = size;
    if (side != null) result.side = side;
    if (numSensors != null) result.numSensors = numSensors;
    if (mpuHash != null) result.mpuHash = mpuHash;
    if (mpuVersion != null) result.mpuVersion = mpuVersion;
    if (mpuModified != null) result.mpuModified = mpuModified;
    if (memorySize != null) result.memorySize = memorySize;
    if (zeroing != null) result.zeroing = zeroing;
    if (fwVersionCode != null) result.fwVersionCode = fwVersionCode;
    return result;
  }

  InsoleSettings._();

  factory InsoleSettings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsoleSettings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsoleSettings',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'serialNumber',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'size', fieldType: $pb.PbFieldType.OU3)
    ..aE<Side>(3, _omitFieldNames ? '' : 'side', enumValues: Side.values)
    ..aI(8, _omitFieldNames ? '' : 'numSensors', fieldType: $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(
        11, _omitFieldNames ? '' : 'mpuHash', $pb.PbFieldType.OY)
    ..aOM<Version>(12, _omitFieldNames ? '' : 'mpuVersion',
        subBuilder: Version.create)
    ..aOB(13, _omitFieldNames ? '' : 'mpuModified')
    ..aI(22, _omitFieldNames ? '' : 'memorySize',
        fieldType: $pb.PbFieldType.OU3)
    ..aOM<Zeroing>(27, _omitFieldNames ? '' : 'zeroing',
        subBuilder: Zeroing.create)
    ..aI(28, _omitFieldNames ? '' : 'fwVersionCode',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleSettings clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleSettings copyWith(void Function(InsoleSettings) updates) =>
      super.copyWith((message) => updates(message as InsoleSettings))
          as InsoleSettings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsoleSettings create() => InsoleSettings._();
  @$core.override
  InsoleSettings createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InsoleSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsoleSettings>(create);
  static InsoleSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get serialNumber => $_getIZ(0);
  @$pb.TagNumber(1)
  set serialNumber($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSerialNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearSerialNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get size => $_getIZ(1);
  @$pb.TagNumber(2)
  set size($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearSize() => $_clearField(2);

  @$pb.TagNumber(3)
  Side get side => $_getN(2);
  @$pb.TagNumber(3)
  set side(Side value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSide() => $_has(2);
  @$pb.TagNumber(3)
  void clearSide() => $_clearField(3);

  @$pb.TagNumber(8)
  $core.int get numSensors => $_getIZ(3);
  @$pb.TagNumber(8)
  set numSensors($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(8)
  $core.bool hasNumSensors() => $_has(3);
  @$pb.TagNumber(8)
  void clearNumSensors() => $_clearField(8);

  @$pb.TagNumber(11)
  $core.List<$core.int> get mpuHash => $_getN(4);
  @$pb.TagNumber(11)
  set mpuHash($core.List<$core.int> value) => $_setBytes(4, value);
  @$pb.TagNumber(11)
  $core.bool hasMpuHash() => $_has(4);
  @$pb.TagNumber(11)
  void clearMpuHash() => $_clearField(11);

  @$pb.TagNumber(12)
  Version get mpuVersion => $_getN(5);
  @$pb.TagNumber(12)
  set mpuVersion(Version value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasMpuVersion() => $_has(5);
  @$pb.TagNumber(12)
  void clearMpuVersion() => $_clearField(12);
  @$pb.TagNumber(12)
  Version ensureMpuVersion() => $_ensure(5);

  @$pb.TagNumber(13)
  $core.bool get mpuModified => $_getBF(6);
  @$pb.TagNumber(13)
  set mpuModified($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(13)
  $core.bool hasMpuModified() => $_has(6);
  @$pb.TagNumber(13)
  void clearMpuModified() => $_clearField(13);

  @$pb.TagNumber(22)
  $core.int get memorySize => $_getIZ(7);
  @$pb.TagNumber(22)
  set memorySize($core.int value) => $_setUnsignedInt32(7, value);
  @$pb.TagNumber(22)
  $core.bool hasMemorySize() => $_has(7);
  @$pb.TagNumber(22)
  void clearMemorySize() => $_clearField(22);

  @$pb.TagNumber(27)
  Zeroing get zeroing => $_getN(8);
  @$pb.TagNumber(27)
  set zeroing(Zeroing value) => $_setField(27, value);
  @$pb.TagNumber(27)
  $core.bool hasZeroing() => $_has(8);
  @$pb.TagNumber(27)
  void clearZeroing() => $_clearField(27);
  @$pb.TagNumber(27)
  Zeroing ensureZeroing() => $_ensure(8);

  @$pb.TagNumber(28)
  $core.int get fwVersionCode => $_getIZ(9);
  @$pb.TagNumber(28)
  set fwVersionCode($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(28)
  $core.bool hasFwVersionCode() => $_has(9);
  @$pb.TagNumber(28)
  void clearFwVersionCode() => $_clearField(28);
}

class SensorCoordinates extends $pb.GeneratedMessage {
  factory SensorCoordinates({
    $core.Iterable<$core.double>? x,
    $core.Iterable<$core.double>? y,
    $core.Iterable<$core.double>? area,
    $core.Iterable<$core.double>? areaFactor,
  }) {
    final result = create();
    if (x != null) result.x.addAll(x);
    if (y != null) result.y.addAll(y);
    if (area != null) result.area.addAll(area);
    if (areaFactor != null) result.areaFactor.addAll(areaFactor);
    return result;
  }

  SensorCoordinates._();

  factory SensorCoordinates.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SensorCoordinates.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SensorCoordinates',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..p<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.KF)
    ..p<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.KF)
    ..p<$core.double>(3, _omitFieldNames ? '' : 'area', $pb.PbFieldType.KF)
    ..p<$core.double>(
        4, _omitFieldNames ? '' : 'areaFactor', $pb.PbFieldType.KF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SensorCoordinates clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SensorCoordinates copyWith(void Function(SensorCoordinates) updates) =>
      super.copyWith((message) => updates(message as SensorCoordinates))
          as SensorCoordinates;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SensorCoordinates create() => SensorCoordinates._();
  @$core.override
  SensorCoordinates createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SensorCoordinates getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SensorCoordinates>(create);
  static SensorCoordinates? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.double> get x => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.double> get y => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$core.double> get area => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.double> get areaFactor => $_getList(3);
}

class Zeroing extends $pb.GeneratedMessage {
  factory Zeroing({
    ZeroingSource? source,
    ZeroingMode? mode,
    Side? side,
  }) {
    final result = create();
    if (source != null) result.source = source;
    if (mode != null) result.mode = mode;
    if (side != null) result.side = side;
    return result;
  }

  Zeroing._();

  factory Zeroing.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Zeroing.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Zeroing',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aE<ZeroingSource>(1, _omitFieldNames ? '' : 'source',
        enumValues: ZeroingSource.values)
    ..aE<ZeroingMode>(2, _omitFieldNames ? '' : 'mode',
        enumValues: ZeroingMode.values)
    ..aE<Side>(4, _omitFieldNames ? '' : 'side', enumValues: Side.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Zeroing clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Zeroing copyWith(void Function(Zeroing) updates) =>
      super.copyWith((message) => updates(message as Zeroing)) as Zeroing;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Zeroing create() => Zeroing._();
  @$core.override
  Zeroing createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Zeroing getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Zeroing>(create);
  static Zeroing? _defaultInstance;

  @$pb.TagNumber(1)
  ZeroingSource get source => $_getN(0);
  @$pb.TagNumber(1)
  set source(ZeroingSource value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSource() => $_has(0);
  @$pb.TagNumber(1)
  void clearSource() => $_clearField(1);

  @$pb.TagNumber(2)
  ZeroingMode get mode => $_getN(1);
  @$pb.TagNumber(2)
  set mode(ZeroingMode value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearMode() => $_clearField(2);

  @$pb.TagNumber(4)
  Side get side => $_getN(2);
  @$pb.TagNumber(4)
  set side(Side value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSide() => $_has(2);
  @$pb.TagNumber(4)
  void clearSide() => $_clearField(4);
}

class ZeroingConf extends $pb.GeneratedMessage {
  factory ZeroingConf({
    Error? error,
    Side? side,
  }) {
    final result = create();
    if (error != null) result.error = error;
    if (side != null) result.side = side;
    return result;
  }

  ZeroingConf._();

  factory ZeroingConf.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ZeroingConf.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ZeroingConf',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aOM<Error>(1, _omitFieldNames ? '' : 'error', subBuilder: Error.create)
    ..aE<Side>(2, _omitFieldNames ? '' : 'side', enumValues: Side.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZeroingConf clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZeroingConf copyWith(void Function(ZeroingConf) updates) =>
      super.copyWith((message) => updates(message as ZeroingConf))
          as ZeroingConf;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ZeroingConf create() => ZeroingConf._();
  @$core.override
  ZeroingConf createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ZeroingConf getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ZeroingConf>(create);
  static ZeroingConf? _defaultInstance;

  @$pb.TagNumber(1)
  Error get error => $_getN(0);
  @$pb.TagNumber(1)
  set error(Error value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => $_clearField(1);
  @$pb.TagNumber(1)
  Error ensureError() => $_ensure(0);

  @$pb.TagNumber(2)
  Side get side => $_getN(1);
  @$pb.TagNumber(2)
  set side(Side value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSide() => $_has(1);
  @$pb.TagNumber(2)
  void clearSide() => $_clearField(2);
}

class EndpointSettings extends $pb.GeneratedMessage {
  factory EndpointSettings({
    $core.String? ipAddress,
    $core.int? port,
  }) {
    final result = create();
    if (ipAddress != null) result.ipAddress = ipAddress;
    if (port != null) result.port = port;
    return result;
  }

  EndpointSettings._();

  factory EndpointSettings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EndpointSettings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EndpointSettings',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ipAddress')
    ..aI(2, _omitFieldNames ? '' : 'port', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EndpointSettings clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EndpointSettings copyWith(void Function(EndpointSettings) updates) =>
      super.copyWith((message) => updates(message as EndpointSettings))
          as EndpointSettings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EndpointSettings create() => EndpointSettings._();
  @$core.override
  EndpointSettings createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EndpointSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EndpointSettings>(create);
  static EndpointSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ipAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set ipAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIpAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearIpAddress() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get port => $_getIZ(1);
  @$pb.TagNumber(2)
  set port($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearPort() => $_clearField(2);
}

class ServiceEndpoint extends $pb.GeneratedMessage {
  factory ServiceEndpoint({
    ServiceEndpoint_EndpointType? endpointType,
    EndpointSettings? endpointSettings,
    $core.int? serviceCounter,
  }) {
    final result = create();
    if (endpointType != null) result.endpointType = endpointType;
    if (endpointSettings != null) result.endpointSettings = endpointSettings;
    if (serviceCounter != null) result.serviceCounter = serviceCounter;
    return result;
  }

  ServiceEndpoint._();

  factory ServiceEndpoint.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ServiceEndpoint.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceEndpoint',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aE<ServiceEndpoint_EndpointType>(1, _omitFieldNames ? '' : 'endpointType',
        enumValues: ServiceEndpoint_EndpointType.values)
    ..aOM<EndpointSettings>(2, _omitFieldNames ? '' : 'endpointSettings',
        subBuilder: EndpointSettings.create)
    ..aI(3, _omitFieldNames ? '' : 'serviceCounter',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceEndpoint clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceEndpoint copyWith(void Function(ServiceEndpoint) updates) =>
      super.copyWith((message) => updates(message as ServiceEndpoint))
          as ServiceEndpoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceEndpoint create() => ServiceEndpoint._();
  @$core.override
  ServiceEndpoint createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ServiceEndpoint getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServiceEndpoint>(create);
  static ServiceEndpoint? _defaultInstance;

  @$pb.TagNumber(1)
  ServiceEndpoint_EndpointType get endpointType => $_getN(0);
  @$pb.TagNumber(1)
  set endpointType(ServiceEndpoint_EndpointType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEndpointType() => $_has(0);
  @$pb.TagNumber(1)
  void clearEndpointType() => $_clearField(1);

  @$pb.TagNumber(2)
  EndpointSettings get endpointSettings => $_getN(1);
  @$pb.TagNumber(2)
  set endpointSettings(EndpointSettings value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndpointSettings() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndpointSettings() => $_clearField(2);
  @$pb.TagNumber(2)
  EndpointSettings ensureEndpointSettings() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get serviceCounter => $_getIZ(2);
  @$pb.TagNumber(3)
  set serviceCounter($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasServiceCounter() => $_has(2);
  @$pb.TagNumber(3)
  void clearServiceCounter() => $_clearField(3);
}

class InsoleStartServiceConf extends $pb.GeneratedMessage {
  factory InsoleStartServiceConf({
    Error? error,
    $core.int? serviceCounter,
  }) {
    final result = create();
    if (error != null) result.error = error;
    if (serviceCounter != null) result.serviceCounter = serviceCounter;
    return result;
  }

  InsoleStartServiceConf._();

  factory InsoleStartServiceConf.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsoleStartServiceConf.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsoleStartServiceConf',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aOM<Error>(1, _omitFieldNames ? '' : 'error', subBuilder: Error.create)
    ..aI(2, _omitFieldNames ? '' : 'serviceCounter',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleStartServiceConf clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleStartServiceConf copyWith(
          void Function(InsoleStartServiceConf) updates) =>
      super.copyWith((message) => updates(message as InsoleStartServiceConf))
          as InsoleStartServiceConf;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsoleStartServiceConf create() => InsoleStartServiceConf._();
  @$core.override
  InsoleStartServiceConf createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InsoleStartServiceConf getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsoleStartServiceConf>(create);
  static InsoleStartServiceConf? _defaultInstance;

  @$pb.TagNumber(1)
  Error get error => $_getN(0);
  @$pb.TagNumber(1)
  set error(Error value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => $_clearField(1);
  @$pb.TagNumber(1)
  Error ensureError() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get serviceCounter => $_getIZ(1);
  @$pb.TagNumber(2)
  set serviceCounter($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasServiceCounter() => $_has(1);
  @$pb.TagNumber(2)
  void clearServiceCounter() => $_clearField(2);
}

class MeasurementInfo extends $pb.GeneratedMessage {
  factory MeasurementInfo({
    $fixnum.Int64? startTime,
    $core.String? name,
    $core.Iterable<$core.String>? tag,
    $core.String? comment,
  }) {
    final result = create();
    if (startTime != null) result.startTime = startTime;
    if (name != null) result.name = name;
    if (tag != null) result.tag.addAll(tag);
    if (comment != null) result.comment = comment;
    return result;
  }

  MeasurementInfo._();

  factory MeasurementInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MeasurementInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MeasurementInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'startTime', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pPS(3, _omitFieldNames ? '' : 'tag')
    ..aOS(4, _omitFieldNames ? '' : 'comment')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MeasurementInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MeasurementInfo copyWith(void Function(MeasurementInfo) updates) =>
      super.copyWith((message) => updates(message as MeasurementInfo))
          as MeasurementInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MeasurementInfo create() => MeasurementInfo._();
  @$core.override
  MeasurementInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MeasurementInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MeasurementInfo>(create);
  static MeasurementInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get startTime => $_getI64(0);
  @$pb.TagNumber(1)
  set startTime($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStartTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartTime() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get tag => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get comment => $_getSZ(3);
  @$pb.TagNumber(4)
  set comment($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasComment() => $_has(3);
  @$pb.TagNumber(4)
  void clearComment() => $_clearField(4);
}

class DataMessage extends $pb.GeneratedMessage {
  factory DataMessage({
    ServiceId? serviceId,
    $fixnum.Int64? time,
    Side? side,
    $core.Iterable<$core.int>? pressure,
    $core.Iterable<$core.double>? acceleration,
    $core.Iterable<$core.double>? angular,
    $core.double? temperature,
    $core.int? totalForce,
    $core.Iterable<$core.double>? cop,
  }) {
    final result = create();
    if (serviceId != null) result.serviceId = serviceId;
    if (time != null) result.time = time;
    if (side != null) result.side = side;
    if (pressure != null) result.pressure.addAll(pressure);
    if (acceleration != null) result.acceleration.addAll(acceleration);
    if (angular != null) result.angular.addAll(angular);
    if (temperature != null) result.temperature = temperature;
    if (totalForce != null) result.totalForce = totalForce;
    if (cop != null) result.cop.addAll(cop);
    return result;
  }

  DataMessage._();

  factory DataMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DataMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DataMessage',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aOM<ServiceId>(1, _omitFieldNames ? '' : 'serviceId',
        subBuilder: ServiceId.create)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'time', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aE<Side>(3, _omitFieldNames ? '' : 'side', enumValues: Side.values)
    ..p<$core.int>(4, _omitFieldNames ? '' : 'pressure', $pb.PbFieldType.KU3)
    ..p<$core.double>(
        5, _omitFieldNames ? '' : 'acceleration', $pb.PbFieldType.KF)
    ..p<$core.double>(6, _omitFieldNames ? '' : 'angular', $pb.PbFieldType.KF)
    ..aD(7, _omitFieldNames ? '' : 'temperature', fieldType: $pb.PbFieldType.OF)
    ..aI(8, _omitFieldNames ? '' : 'totalForce', fieldType: $pb.PbFieldType.OU3)
    ..p<$core.double>(9, _omitFieldNames ? '' : 'cop', $pb.PbFieldType.KF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataMessage copyWith(void Function(DataMessage) updates) =>
      super.copyWith((message) => updates(message as DataMessage))
          as DataMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DataMessage create() => DataMessage._();
  @$core.override
  DataMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DataMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DataMessage>(create);
  static DataMessage? _defaultInstance;

  @$pb.TagNumber(1)
  ServiceId get serviceId => $_getN(0);
  @$pb.TagNumber(1)
  set serviceId(ServiceId value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasServiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceId() => $_clearField(1);
  @$pb.TagNumber(1)
  ServiceId ensureServiceId() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get time => $_getI64(1);
  @$pb.TagNumber(2)
  set time($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearTime() => $_clearField(2);

  @$pb.TagNumber(3)
  Side get side => $_getN(2);
  @$pb.TagNumber(3)
  set side(Side value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSide() => $_has(2);
  @$pb.TagNumber(3)
  void clearSide() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.int> get pressure => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<$core.double> get acceleration => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<$core.double> get angular => $_getList(5);

  @$pb.TagNumber(7)
  $core.double get temperature => $_getN(6);
  @$pb.TagNumber(7)
  set temperature($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTemperature() => $_has(6);
  @$pb.TagNumber(7)
  void clearTemperature() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get totalForce => $_getIZ(7);
  @$pb.TagNumber(8)
  set totalForce($core.int value) => $_setUnsignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalForce() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalForce() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.double> get cop => $_getList(8);
}

class Activity extends $pb.GeneratedMessage {
  factory Activity({
    ServiceId? serviceId,
    $fixnum.Int64? time,
    Side? side,
    Activity_ActivityEvent? event,
  }) {
    final result = create();
    if (serviceId != null) result.serviceId = serviceId;
    if (time != null) result.time = time;
    if (side != null) result.side = side;
    if (event != null) result.event = event;
    return result;
  }

  Activity._();

  factory Activity.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Activity.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Activity',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aOM<ServiceId>(1, _omitFieldNames ? '' : 'serviceId',
        subBuilder: ServiceId.create)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'time', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aE<Side>(3, _omitFieldNames ? '' : 'side', enumValues: Side.values)
    ..aE<Activity_ActivityEvent>(4, _omitFieldNames ? '' : 'event',
        enumValues: Activity_ActivityEvent.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Activity clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Activity copyWith(void Function(Activity) updates) =>
      super.copyWith((message) => updates(message as Activity)) as Activity;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Activity create() => Activity._();
  @$core.override
  Activity createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Activity getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Activity>(create);
  static Activity? _defaultInstance;

  @$pb.TagNumber(1)
  ServiceId get serviceId => $_getN(0);
  @$pb.TagNumber(1)
  set serviceId(ServiceId value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasServiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceId() => $_clearField(1);
  @$pb.TagNumber(1)
  ServiceId ensureServiceId() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get time => $_getI64(1);
  @$pb.TagNumber(2)
  set time($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearTime() => $_clearField(2);

  @$pb.TagNumber(3)
  Side get side => $_getN(2);
  @$pb.TagNumber(3)
  set side(Side value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSide() => $_has(2);
  @$pb.TagNumber(3)
  void clearSide() => $_clearField(3);

  @$pb.TagNumber(4)
  Activity_ActivityEvent get event => $_getN(3);
  @$pb.TagNumber(4)
  set event(Activity_ActivityEvent value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEvent() => $_has(3);
  @$pb.TagNumber(4)
  void clearEvent() => $_clearField(4);
}

class TimestampConf extends $pb.GeneratedMessage {
  factory TimestampConf({
    $core.int? seqNum,
    $fixnum.Int64? timeTx,
    $fixnum.Int64? timeRx,
    $fixnum.Int64? timeConfTx,
  }) {
    final result = create();
    if (seqNum != null) result.seqNum = seqNum;
    if (timeTx != null) result.timeTx = timeTx;
    if (timeRx != null) result.timeRx = timeRx;
    if (timeConfTx != null) result.timeConfTx = timeConfTx;
    return result;
  }

  TimestampConf._();

  factory TimestampConf.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TimestampConf.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TimestampConf',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'seqNum', fieldType: $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'timeTx', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'timeRx', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'timeConfTx', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimestampConf clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimestampConf copyWith(void Function(TimestampConf) updates) =>
      super.copyWith((message) => updates(message as TimestampConf))
          as TimestampConf;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimestampConf create() => TimestampConf._();
  @$core.override
  TimestampConf createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TimestampConf getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TimestampConf>(create);
  static TimestampConf? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get seqNum => $_getIZ(0);
  @$pb.TagNumber(1)
  set seqNum($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSeqNum() => $_has(0);
  @$pb.TagNumber(1)
  void clearSeqNum() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get timeTx => $_getI64(1);
  @$pb.TagNumber(2)
  set timeTx($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTimeTx() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimeTx() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get timeRx => $_getI64(2);
  @$pb.TagNumber(3)
  set timeRx($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimeRx() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimeRx() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get timeConfTx => $_getI64(3);
  @$pb.TagNumber(4)
  set timeConfTx($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTimeConfTx() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimeConfTx() => $_clearField(4);
}

class InsoleRecDelete extends $pb.GeneratedMessage {
  factory InsoleRecDelete({
    Side? side,
    $core.int? serviceCounter,
    $core.bool? forceErase,
  }) {
    final result = create();
    if (side != null) result.side = side;
    if (serviceCounter != null) result.serviceCounter = serviceCounter;
    if (forceErase != null) result.forceErase = forceErase;
    return result;
  }

  InsoleRecDelete._();

  factory InsoleRecDelete.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsoleRecDelete.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsoleRecDelete',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aE<Side>(1, _omitFieldNames ? '' : 'side', enumValues: Side.values)
    ..aI(2, _omitFieldNames ? '' : 'serviceCounter',
        fieldType: $pb.PbFieldType.OU3)
    ..aOB(3, _omitFieldNames ? '' : 'forceErase')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleRecDelete clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleRecDelete copyWith(void Function(InsoleRecDelete) updates) =>
      super.copyWith((message) => updates(message as InsoleRecDelete))
          as InsoleRecDelete;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsoleRecDelete create() => InsoleRecDelete._();
  @$core.override
  InsoleRecDelete createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InsoleRecDelete getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsoleRecDelete>(create);
  static InsoleRecDelete? _defaultInstance;

  @$pb.TagNumber(1)
  Side get side => $_getN(0);
  @$pb.TagNumber(1)
  set side(Side value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSide() => $_has(0);
  @$pb.TagNumber(1)
  void clearSide() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get serviceCounter => $_getIZ(1);
  @$pb.TagNumber(2)
  set serviceCounter($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasServiceCounter() => $_has(1);
  @$pb.TagNumber(2)
  void clearServiceCounter() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get forceErase => $_getBF(2);
  @$pb.TagNumber(3)
  set forceErase($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasForceErase() => $_has(2);
  @$pb.TagNumber(3)
  void clearForceErase() => $_clearField(3);
}

class InsoleRecDeleteConf extends $pb.GeneratedMessage {
  factory InsoleRecDeleteConf({
    Side? side,
    $core.int? serviceCounter,
    Error? error,
  }) {
    final result = create();
    if (side != null) result.side = side;
    if (serviceCounter != null) result.serviceCounter = serviceCounter;
    if (error != null) result.error = error;
    return result;
  }

  InsoleRecDeleteConf._();

  factory InsoleRecDeleteConf.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsoleRecDeleteConf.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsoleRecDeleteConf',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aE<Side>(1, _omitFieldNames ? '' : 'side', enumValues: Side.values)
    ..aI(2, _omitFieldNames ? '' : 'serviceCounter',
        fieldType: $pb.PbFieldType.OU3)
    ..aOM<Error>(3, _omitFieldNames ? '' : 'error', subBuilder: Error.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleRecDeleteConf clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsoleRecDeleteConf copyWith(void Function(InsoleRecDeleteConf) updates) =>
      super.copyWith((message) => updates(message as InsoleRecDeleteConf))
          as InsoleRecDeleteConf;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsoleRecDeleteConf create() => InsoleRecDeleteConf._();
  @$core.override
  InsoleRecDeleteConf createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InsoleRecDeleteConf getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsoleRecDeleteConf>(create);
  static InsoleRecDeleteConf? _defaultInstance;

  @$pb.TagNumber(1)
  Side get side => $_getN(0);
  @$pb.TagNumber(1)
  set side(Side value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSide() => $_has(0);
  @$pb.TagNumber(1)
  void clearSide() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get serviceCounter => $_getIZ(1);
  @$pb.TagNumber(2)
  set serviceCounter($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasServiceCounter() => $_has(1);
  @$pb.TagNumber(2)
  void clearServiceCounter() => $_clearField(2);

  @$pb.TagNumber(3)
  Error get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(Error value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
  @$pb.TagNumber(3)
  Error ensureError() => $_ensure(2);
}

class RecState extends $pb.GeneratedMessage {
  factory RecState({
    $core.int? packetCount,
    $core.bool? stopped,
  }) {
    final result = create();
    if (packetCount != null) result.packetCount = packetCount;
    if (stopped != null) result.stopped = stopped;
    return result;
  }

  RecState._();

  factory RecState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecState',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'packetCount',
        fieldType: $pb.PbFieldType.OU3)
    ..aOB(2, _omitFieldNames ? '' : 'stopped')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecState clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecState copyWith(void Function(RecState) updates) =>
      super.copyWith((message) => updates(message as RecState)) as RecState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecState create() => RecState._();
  @$core.override
  RecState createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecState getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecState>(create);
  static RecState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get packetCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set packetCount($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPacketCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearPacketCount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get stopped => $_getBF(1);
  @$pb.TagNumber(2)
  set stopped($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStopped() => $_has(1);
  @$pb.TagNumber(2)
  void clearStopped() => $_clearField(2);
}

class EnterBootloader extends $pb.GeneratedMessage {
  factory EnterBootloader({
    Side? side,
    $core.bool? fastBoot,
  }) {
    final result = create();
    if (side != null) result.side = side;
    if (fastBoot != null) result.fastBoot = fastBoot;
    return result;
  }

  EnterBootloader._();

  factory EnterBootloader.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EnterBootloader.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnterBootloader',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'moticon_insole3.proto'),
      createEmptyInstance: create)
    ..aE<Side>(1, _omitFieldNames ? '' : 'side', enumValues: Side.values)
    ..aOB(2, _omitFieldNames ? '' : 'fastBoot')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnterBootloader clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnterBootloader copyWith(void Function(EnterBootloader) updates) =>
      super.copyWith((message) => updates(message as EnterBootloader))
          as EnterBootloader;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnterBootloader create() => EnterBootloader._();
  @$core.override
  EnterBootloader createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EnterBootloader getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnterBootloader>(create);
  static EnterBootloader? _defaultInstance;

  @$pb.TagNumber(1)
  Side get side => $_getN(0);
  @$pb.TagNumber(1)
  set side(Side value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSide() => $_has(0);
  @$pb.TagNumber(1)
  void clearSide() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get fastBoot => $_getBF(1);
  @$pb.TagNumber(2)
  set fastBoot($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFastBoot() => $_has(1);
  @$pb.TagNumber(2)
  void clearFastBoot() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
