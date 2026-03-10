//   protobuf: ^6.1.0
//   fixnum: ^1.1.0// This is a generated file - do not edit.
// //
// Generated from common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ErrorCode extends $pb.ProtobufEnum {
  static const ErrorCode SUCCESS =
      ErrorCode._(0, _omitEnumNames ? '' : 'SUCCESS');
  static const ErrorCode WRONG_SERVICE_REQUEST_TIME =
      ErrorCode._(1, _omitEnumNames ? '' : 'WRONG_SERVICE_REQUEST_TIME');
  static const ErrorCode WRONG_SERVICE_COUNTER =
      ErrorCode._(2, _omitEnumNames ? '' : 'WRONG_SERVICE_COUNTER');
  static const ErrorCode WRONG_SERIAL_NUMBER =
      ErrorCode._(3, _omitEnumNames ? '' : 'WRONG_SERIAL_NUMBER');
  static const ErrorCode SERVICE_TYPE_BUSY =
      ErrorCode._(4, _omitEnumNames ? '' : 'SERVICE_TYPE_BUSY');
  static const ErrorCode PARAM_NOT_SUPPORTED =
      ErrorCode._(5, _omitEnumNames ? '' : 'PARAM_NOT_SUPPORTED');
  static const ErrorCode PARAM_MISMATCH =
      ErrorCode._(6, _omitEnumNames ? '' : 'PARAM_MISMATCH');
  static const ErrorCode ACTIVITY_MISMATCH =
      ErrorCode._(7, _omitEnumNames ? '' : 'ACTIVITY_MISMATCH');
  static const ErrorCode NO_CONFIGURATION =
      ErrorCode._(8, _omitEnumNames ? '' : 'NO_CONFIGURATION');
  static const ErrorCode NO_COORDINATES =
      ErrorCode._(9, _omitEnumNames ? '' : 'NO_COORDINATES');
  static const ErrorCode NO_CALIBRATION =
      ErrorCode._(10, _omitEnumNames ? '' : 'NO_CALIBRATION');
  static const ErrorCode NO_TIMESYNC =
      ErrorCode._(11, _omitEnumNames ? '' : 'NO_TIMESYNC');
  static const ErrorCode WRONG_STATE =
      ErrorCode._(12, _omitEnumNames ? '' : 'WRONG_STATE');
  static const ErrorCode NO_RESOURCES =
      ErrorCode._(13, _omitEnumNames ? '' : 'NO_RESOURCES');
  static const ErrorCode MEM_FULL =
      ErrorCode._(14, _omitEnumNames ? '' : 'MEM_FULL');
  static const ErrorCode REC_TIMEOUT =
      ErrorCode._(15, _omitEnumNames ? '' : 'REC_TIMEOUT');
  static const ErrorCode SIGNATURE_ERROR =
      ErrorCode._(16, _omitEnumNames ? '' : 'SIGNATURE_ERROR');

  static const $core.List<ErrorCode> values = <ErrorCode>[
    SUCCESS,
    WRONG_SERVICE_REQUEST_TIME,
    WRONG_SERVICE_COUNTER,
    WRONG_SERIAL_NUMBER,
    SERVICE_TYPE_BUSY,
    PARAM_NOT_SUPPORTED,
    PARAM_MISMATCH,
    ACTIVITY_MISMATCH,
    NO_CONFIGURATION,
    NO_COORDINATES,
    NO_CALIBRATION,
    NO_TIMESYNC,
    WRONG_STATE,
    NO_RESOURCES,
    MEM_FULL,
    REC_TIMEOUT,
    SIGNATURE_ERROR,
  ];

  static final $core.List<ErrorCode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 16);
  static ErrorCode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ErrorCode._(super.value, super.name);
}

class Side extends $pb.ProtobufEnum {
  static const Side LEFT = Side._(0, _omitEnumNames ? '' : 'LEFT');
  static const Side RIGHT = Side._(1, _omitEnumNames ? '' : 'RIGHT');
  static const Side PAIR = Side._(2, _omitEnumNames ? '' : 'PAIR');

  static const $core.List<Side> values = <Side>[
    LEFT,
    RIGHT,
    PAIR,
  ];

  static final $core.List<Side?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static Side? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Side._(super.value, super.name);
}

class ZeroingSource extends $pb.ProtobufEnum {
  static const ZeroingSource KEEP =
      ZeroingSource._(0, _omitEnumNames ? '' : 'KEEP');
  static const ZeroingSource MANUAL =
      ZeroingSource._(1, _omitEnumNames ? '' : 'MANUAL');

  static const $core.List<ZeroingSource> values = <ZeroingSource>[
    KEEP,
    MANUAL,
  ];

  static final $core.List<ZeroingSource?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static ZeroingSource? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ZeroingSource._(super.value, super.name);
}

class ZeroingMode extends $pb.ProtobufEnum {
  static const ZeroingMode OFF = ZeroingMode._(0, _omitEnumNames ? '' : 'OFF');
  static const ZeroingMode AUTO =
      ZeroingMode._(1, _omitEnumNames ? '' : 'AUTO');

  static const $core.List<ZeroingMode> values = <ZeroingMode>[
    OFF,
    AUTO,
  ];

  static final $core.List<ZeroingMode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static ZeroingMode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ZeroingMode._(super.value, super.name);
}

class InsoleInfoType extends $pb.ProtobufEnum {
  static const InsoleInfoType ALL =
      InsoleInfoType._(0, _omitEnumNames ? '' : 'ALL');
  static const InsoleInfoType STATUS =
      InsoleInfoType._(1, _omitEnumNames ? '' : 'STATUS');
  static const InsoleInfoType STATE =
      InsoleInfoType._(2, _omitEnumNames ? '' : 'STATE');
  static const InsoleInfoType INFO =
      InsoleInfoType._(3, _omitEnumNames ? '' : 'INFO');
  static const InsoleInfoType GEOMETRY =
      InsoleInfoType._(4, _omitEnumNames ? '' : 'GEOMETRY');

  static const $core.List<InsoleInfoType> values = <InsoleInfoType>[
    ALL,
    STATUS,
    STATE,
    INFO,
    GEOMETRY,
  ];

  static final $core.List<InsoleInfoType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static InsoleInfoType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const InsoleInfoType._(super.value, super.name);
}

class ServiceType extends $pb.ProtobufEnum {
  static const ServiceType UNDEFINED =
      ServiceType._(0, _omitEnumNames ? '' : 'UNDEFINED');
  static const ServiceType LIVE =
      ServiceType._(1, _omitEnumNames ? '' : 'LIVE');
  static const ServiceType RECORD =
      ServiceType._(2, _omitEnumNames ? '' : 'RECORD');

  static const $core.List<ServiceType> values = <ServiceType>[
    UNDEFINED,
    LIVE,
    RECORD,
  ];

  static final $core.List<ServiceType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static ServiceType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ServiceType._(super.value, super.name);
}

class ServiceConfig_AccGRange extends $pb.ProtobufEnum {
  static const ServiceConfig_AccGRange ACC_2_G =
      ServiceConfig_AccGRange._(0, _omitEnumNames ? '' : 'ACC_2_G');
  static const ServiceConfig_AccGRange ACC_4_G =
      ServiceConfig_AccGRange._(1, _omitEnumNames ? '' : 'ACC_4_G');
  static const ServiceConfig_AccGRange ACC_8_G =
      ServiceConfig_AccGRange._(2, _omitEnumNames ? '' : 'ACC_8_G');
  static const ServiceConfig_AccGRange ACC_16_G =
      ServiceConfig_AccGRange._(3, _omitEnumNames ? '' : 'ACC_16_G');

  static const $core.List<ServiceConfig_AccGRange> values =
      <ServiceConfig_AccGRange>[
    ACC_2_G,
    ACC_4_G,
    ACC_8_G,
    ACC_16_G,
  ];

  static final $core.List<ServiceConfig_AccGRange?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static ServiceConfig_AccGRange? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ServiceConfig_AccGRange._(super.value, super.name);
}

class ServiceConfig_AccOdr extends $pb.ProtobufEnum {
  static const ServiceConfig_AccOdr ACC_1_6_ODR =
      ServiceConfig_AccOdr._(0, _omitEnumNames ? '' : 'ACC_1_6_ODR');
  static const ServiceConfig_AccOdr ACC_12_5_ODR =
      ServiceConfig_AccOdr._(1, _omitEnumNames ? '' : 'ACC_12_5_ODR');
  static const ServiceConfig_AccOdr ACC_26_ODR =
      ServiceConfig_AccOdr._(2, _omitEnumNames ? '' : 'ACC_26_ODR');
  static const ServiceConfig_AccOdr ACC_52_ODR =
      ServiceConfig_AccOdr._(3, _omitEnumNames ? '' : 'ACC_52_ODR');
  static const ServiceConfig_AccOdr ACC_104_ODR =
      ServiceConfig_AccOdr._(4, _omitEnumNames ? '' : 'ACC_104_ODR');
  static const ServiceConfig_AccOdr ACC_208_ODR =
      ServiceConfig_AccOdr._(5, _omitEnumNames ? '' : 'ACC_208_ODR');
  static const ServiceConfig_AccOdr ACC_416_ODR =
      ServiceConfig_AccOdr._(6, _omitEnumNames ? '' : 'ACC_416_ODR');
  static const ServiceConfig_AccOdr ACC_833_ODR =
      ServiceConfig_AccOdr._(7, _omitEnumNames ? '' : 'ACC_833_ODR');
  static const ServiceConfig_AccOdr ACC_1666_ODR =
      ServiceConfig_AccOdr._(8, _omitEnumNames ? '' : 'ACC_1666_ODR');
  static const ServiceConfig_AccOdr ACC_3332_ODR =
      ServiceConfig_AccOdr._(9, _omitEnumNames ? '' : 'ACC_3332_ODR');
  static const ServiceConfig_AccOdr ACC_6664_ODR =
      ServiceConfig_AccOdr._(10, _omitEnumNames ? '' : 'ACC_6664_ODR');

  static const $core.List<ServiceConfig_AccOdr> values = <ServiceConfig_AccOdr>[
    ACC_1_6_ODR,
    ACC_12_5_ODR,
    ACC_26_ODR,
    ACC_52_ODR,
    ACC_104_ODR,
    ACC_208_ODR,
    ACC_416_ODR,
    ACC_833_ODR,
    ACC_1666_ODR,
    ACC_3332_ODR,
    ACC_6664_ODR,
  ];

  static final $core.List<ServiceConfig_AccOdr?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 10);
  static ServiceConfig_AccOdr? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ServiceConfig_AccOdr._(super.value, super.name);
}

class ServiceConfig_AngDpsRange extends $pb.ProtobufEnum {
  static const ServiceConfig_AngDpsRange ANG_125_DPS =
      ServiceConfig_AngDpsRange._(0, _omitEnumNames ? '' : 'ANG_125_DPS');
  static const ServiceConfig_AngDpsRange ANG_250_DPS =
      ServiceConfig_AngDpsRange._(1, _omitEnumNames ? '' : 'ANG_250_DPS');
  static const ServiceConfig_AngDpsRange ANG_500_DPS =
      ServiceConfig_AngDpsRange._(2, _omitEnumNames ? '' : 'ANG_500_DPS');
  static const ServiceConfig_AngDpsRange ANG_1000_DPS =
      ServiceConfig_AngDpsRange._(3, _omitEnumNames ? '' : 'ANG_1000_DPS');
  static const ServiceConfig_AngDpsRange ANG_2000_DPS =
      ServiceConfig_AngDpsRange._(4, _omitEnumNames ? '' : 'ANG_2000_DPS');

  static const $core.List<ServiceConfig_AngDpsRange> values =
      <ServiceConfig_AngDpsRange>[
    ANG_125_DPS,
    ANG_250_DPS,
    ANG_500_DPS,
    ANG_1000_DPS,
    ANG_2000_DPS,
  ];

  static final $core.List<ServiceConfig_AngDpsRange?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static ServiceConfig_AngDpsRange? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ServiceConfig_AngDpsRange._(super.value, super.name);
}

class ServiceConfig_AngOdr extends $pb.ProtobufEnum {
  static const ServiceConfig_AngOdr ANG_12_5_ODR =
      ServiceConfig_AngOdr._(0, _omitEnumNames ? '' : 'ANG_12_5_ODR');
  static const ServiceConfig_AngOdr ANG_26_ODR =
      ServiceConfig_AngOdr._(1, _omitEnumNames ? '' : 'ANG_26_ODR');
  static const ServiceConfig_AngOdr ANG_52_ODR =
      ServiceConfig_AngOdr._(2, _omitEnumNames ? '' : 'ANG_52_ODR');
  static const ServiceConfig_AngOdr ANG_104_ODR =
      ServiceConfig_AngOdr._(3, _omitEnumNames ? '' : 'ANG_104_ODR');
  static const ServiceConfig_AngOdr ANG_208_ODR =
      ServiceConfig_AngOdr._(4, _omitEnumNames ? '' : 'ANG_208_ODR');
  static const ServiceConfig_AngOdr ANG_416_ODR =
      ServiceConfig_AngOdr._(5, _omitEnumNames ? '' : 'ANG_416_ODR');
  static const ServiceConfig_AngOdr ANG_833_ODR =
      ServiceConfig_AngOdr._(6, _omitEnumNames ? '' : 'ANG_833_ODR');
  static const ServiceConfig_AngOdr ANG_1666_ODR =
      ServiceConfig_AngOdr._(7, _omitEnumNames ? '' : 'ANG_1666_ODR');
  static const ServiceConfig_AngOdr ANG_3332_ODR =
      ServiceConfig_AngOdr._(8, _omitEnumNames ? '' : 'ANG_3332_ODR');
  static const ServiceConfig_AngOdr ANG_6664_ODR =
      ServiceConfig_AngOdr._(9, _omitEnumNames ? '' : 'ANG_6664_ODR');

  static const $core.List<ServiceConfig_AngOdr> values = <ServiceConfig_AngOdr>[
    ANG_12_5_ODR,
    ANG_26_ODR,
    ANG_52_ODR,
    ANG_104_ODR,
    ANG_208_ODR,
    ANG_416_ODR,
    ANG_833_ODR,
    ANG_1666_ODR,
    ANG_3332_ODR,
    ANG_6664_ODR,
  ];

  static final $core.List<ServiceConfig_AngOdr?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 9);
  static ServiceConfig_AngOdr? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ServiceConfig_AngOdr._(super.value, super.name);
}

class ServiceConfig_ActivityProfile extends $pb.ProtobufEnum {
  static const ServiceConfig_ActivityProfile ACTIVITY_PROFILE_CONTINUOUS =
      ServiceConfig_ActivityProfile._(
          0, _omitEnumNames ? '' : 'ACTIVITY_PROFILE_CONTINUOUS');
  static const ServiceConfig_ActivityProfile ACTIVITY_PROFILE_ACCELERATION =
      ServiceConfig_ActivityProfile._(
          1, _omitEnumNames ? '' : 'ACTIVITY_PROFILE_ACCELERATION');

  static const $core.List<ServiceConfig_ActivityProfile> values =
      <ServiceConfig_ActivityProfile>[
    ACTIVITY_PROFILE_CONTINUOUS,
    ACTIVITY_PROFILE_ACCELERATION,
  ];

  static final $core.List<ServiceConfig_ActivityProfile?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static ServiceConfig_ActivityProfile? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ServiceConfig_ActivityProfile._(super.value, super.name);
}

class ServiceConfig_ActivitySensitivity extends $pb.ProtobufEnum {
  static const ServiceConfig_ActivitySensitivity
      ACTIVITY_SENSITIVITY_INSENSITIVE = ServiceConfig_ActivitySensitivity._(
          0, _omitEnumNames ? '' : 'ACTIVITY_SENSITIVITY_INSENSITIVE');
  static const ServiceConfig_ActivitySensitivity ACTIVITY_SENSITIVITY_MODERATE =
      ServiceConfig_ActivitySensitivity._(
          1, _omitEnumNames ? '' : 'ACTIVITY_SENSITIVITY_MODERATE');
  static const ServiceConfig_ActivitySensitivity
      ACTIVITY_SENSITIVITY_SENSITIVE = ServiceConfig_ActivitySensitivity._(
          2, _omitEnumNames ? '' : 'ACTIVITY_SENSITIVITY_SENSITIVE');

  static const $core.List<ServiceConfig_ActivitySensitivity> values =
      <ServiceConfig_ActivitySensitivity>[
    ACTIVITY_SENSITIVITY_INSENSITIVE,
    ACTIVITY_SENSITIVITY_MODERATE,
    ACTIVITY_SENSITIVITY_SENSITIVE,
  ];

  static final $core.List<ServiceConfig_ActivitySensitivity?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static ServiceConfig_ActivitySensitivity? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ServiceConfig_ActivitySensitivity._(super.value, super.name);
}

class ServiceEndpoint_EndpointType extends $pb.ProtobufEnum {
  static const ServiceEndpoint_EndpointType UNDEFINED =
      ServiceEndpoint_EndpointType._(0, _omitEnumNames ? '' : 'UNDEFINED');
  static const ServiceEndpoint_EndpointType APP =
      ServiceEndpoint_EndpointType._(1, _omitEnumNames ? '' : 'APP');
  static const ServiceEndpoint_EndpointType SERVICE =
      ServiceEndpoint_EndpointType._(2, _omitEnumNames ? '' : 'SERVICE');
  static const ServiceEndpoint_EndpointType PC =
      ServiceEndpoint_EndpointType._(3, _omitEnumNames ? '' : 'PC');

  static const $core.List<ServiceEndpoint_EndpointType> values =
      <ServiceEndpoint_EndpointType>[
    UNDEFINED,
    APP,
    SERVICE,
    PC,
  ];

  static final $core.List<ServiceEndpoint_EndpointType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static ServiceEndpoint_EndpointType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ServiceEndpoint_EndpointType._(super.value, super.name);
}

class Activity_ActivityEvent extends $pb.ProtobufEnum {
  static const Activity_ActivityEvent ACTIVITY_PAUSE =
      Activity_ActivityEvent._(0, _omitEnumNames ? '' : 'ACTIVITY_PAUSE');
  static const Activity_ActivityEvent ACTIVITY_RESUME =
      Activity_ActivityEvent._(1, _omitEnumNames ? '' : 'ACTIVITY_RESUME');
  static const Activity_ActivityEvent ACTIVITY_RESTART =
      Activity_ActivityEvent._(2, _omitEnumNames ? '' : 'ACTIVITY_RESTART');

  static const $core.List<Activity_ActivityEvent> values =
      <Activity_ActivityEvent>[
    ACTIVITY_PAUSE,
    ACTIVITY_RESUME,
    ACTIVITY_RESTART,
  ];

  static final $core.List<Activity_ActivityEvent?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static Activity_ActivityEvent? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Activity_ActivityEvent._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
