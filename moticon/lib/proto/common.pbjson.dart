// This is a generated file - do not edit.
//
// Generated from common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use errorCodeDescriptor instead')
const ErrorCode$json = {
  '1': 'ErrorCode',
  '2': [
    {'1': 'SUCCESS', '2': 0},
    {'1': 'WRONG_SERVICE_REQUEST_TIME', '2': 1},
    {'1': 'WRONG_SERVICE_COUNTER', '2': 2},
    {'1': 'WRONG_SERIAL_NUMBER', '2': 3},
    {'1': 'SERVICE_TYPE_BUSY', '2': 4},
    {'1': 'PARAM_NOT_SUPPORTED', '2': 5},
    {'1': 'PARAM_MISMATCH', '2': 6},
    {'1': 'ACTIVITY_MISMATCH', '2': 7},
    {'1': 'NO_CONFIGURATION', '2': 8},
    {'1': 'NO_COORDINATES', '2': 9},
    {'1': 'NO_CALIBRATION', '2': 10},
    {'1': 'NO_TIMESYNC', '2': 11},
    {'1': 'WRONG_STATE', '2': 12},
    {'1': 'NO_RESOURCES', '2': 13},
    {'1': 'MEM_FULL', '2': 14},
    {'1': 'REC_TIMEOUT', '2': 15},
    {'1': 'SIGNATURE_ERROR', '2': 16},
  ],
};

/// Descriptor for `ErrorCode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List errorCodeDescriptor = $convert.base64Decode(
    'CglFcnJvckNvZGUSCwoHU1VDQ0VTUxAAEh4KGldST05HX1NFUlZJQ0VfUkVRVUVTVF9USU1FEA'
    'ESGQoVV1JPTkdfU0VSVklDRV9DT1VOVEVSEAISFwoTV1JPTkdfU0VSSUFMX05VTUJFUhADEhUK'
    'EVNFUlZJQ0VfVFlQRV9CVVNZEAQSFwoTUEFSQU1fTk9UX1NVUFBPUlRFRBAFEhIKDlBBUkFNX0'
    '1JU01BVENIEAYSFQoRQUNUSVZJVFlfTUlTTUFUQ0gQBxIUChBOT19DT05GSUdVUkFUSU9OEAgS'
    'EgoOTk9fQ09PUkRJTkFURVMQCRISCg5OT19DQUxJQlJBVElPThAKEg8KC05PX1RJTUVTWU5DEA'
    'sSDwoLV1JPTkdfU1RBVEUQDBIQCgxOT19SRVNPVVJDRVMQDRIMCghNRU1fRlVMTBAOEg8KC1JF'
    'Q19USU1FT1VUEA8SEwoPU0lHTkFUVVJFX0VSUk9SEBA=');

@$core.Deprecated('Use sideDescriptor instead')
const Side$json = {
  '1': 'Side',
  '2': [
    {'1': 'LEFT', '2': 0},
    {'1': 'RIGHT', '2': 1},
    {'1': 'PAIR', '2': 2},
  ],
};

/// Descriptor for `Side`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List sideDescriptor = $convert
    .base64Decode('CgRTaWRlEggKBExFRlQQABIJCgVSSUdIVBABEggKBFBBSVIQAg==');

@$core.Deprecated('Use zeroingSourceDescriptor instead')
const ZeroingSource$json = {
  '1': 'ZeroingSource',
  '2': [
    {'1': 'KEEP', '2': 0},
    {'1': 'MANUAL', '2': 1},
  ],
};

/// Descriptor for `ZeroingSource`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List zeroingSourceDescriptor = $convert
    .base64Decode('Cg1aZXJvaW5nU291cmNlEggKBEtFRVAQABIKCgZNQU5VQUwQAQ==');

@$core.Deprecated('Use zeroingModeDescriptor instead')
const ZeroingMode$json = {
  '1': 'ZeroingMode',
  '2': [
    {'1': 'OFF', '2': 0},
    {'1': 'AUTO', '2': 1},
  ],
};

/// Descriptor for `ZeroingMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List zeroingModeDescriptor =
    $convert.base64Decode('CgtaZXJvaW5nTW9kZRIHCgNPRkYQABIICgRBVVRPEAE=');

@$core.Deprecated('Use insoleInfoTypeDescriptor instead')
const InsoleInfoType$json = {
  '1': 'InsoleInfoType',
  '2': [
    {'1': 'ALL', '2': 0},
    {'1': 'STATUS', '2': 1},
    {'1': 'STATE', '2': 2},
    {'1': 'INFO', '2': 3},
    {'1': 'GEOMETRY', '2': 4},
  ],
};

/// Descriptor for `InsoleInfoType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List insoleInfoTypeDescriptor = $convert.base64Decode(
    'Cg5JbnNvbGVJbmZvVHlwZRIHCgNBTEwQABIKCgZTVEFUVVMQARIJCgVTVEFURRACEggKBElORk'
    '8QAxIMCghHRU9NRVRSWRAE');

@$core.Deprecated('Use serviceTypeDescriptor instead')
const ServiceType$json = {
  '1': 'ServiceType',
  '2': [
    {'1': 'UNDEFINED', '2': 0},
    {'1': 'LIVE', '2': 1},
    {'1': 'RECORD', '2': 2},
  ],
};

/// Descriptor for `ServiceType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List serviceTypeDescriptor = $convert.base64Decode(
    'CgtTZXJ2aWNlVHlwZRINCglVTkRFRklORUQQABIICgRMSVZFEAESCgoGUkVDT1JEEAI=');

@$core.Deprecated('Use errorDescriptor instead')
const Error$json = {
  '1': 'Error',
  '2': [
    {
      '1': 'error_code',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.ErrorCode',
      '10': 'errorCode'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `Error`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorDescriptor = $convert.base64Decode(
    'CgVFcnJvchI/CgplcnJvcl9jb2RlGAEgASgOMiAubW90aWNvbl9pbnNvbGUzLnByb3RvLkVycm'
    '9yQ29kZVIJZXJyb3JDb2RlEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use versionDescriptor instead')
const Version$json = {
  '1': 'Version',
  '2': [
    {'1': 'major', '3': 1, '4': 1, '5': 13, '10': 'major'},
    {'1': 'minor', '3': 2, '4': 1, '5': 13, '10': 'minor'},
    {'1': 'bugfix', '3': 3, '4': 1, '5': 13, '10': 'bugfix'},
  ],
};

/// Descriptor for `Version`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionDescriptor = $convert.base64Decode(
    'CgdWZXJzaW9uEhQKBW1ham9yGAEgASgNUgVtYWpvchIUCgVtaW5vchgCIAEoDVIFbWlub3ISFg'
    'oGYnVnZml4GAMgASgNUgZidWdmaXg=');

@$core.Deprecated('Use serviceIdDescriptor instead')
const ServiceId$json = {
  '1': 'ServiceId',
  '2': [
    {
      '1': 'left_serial_number',
      '3': 1,
      '4': 1,
      '5': 13,
      '10': 'leftSerialNumber'
    },
    {
      '1': 'right_serial_number',
      '3': 2,
      '4': 1,
      '5': 13,
      '10': 'rightSerialNumber'
    },
    {'1': 'service_counter', '3': 3, '4': 1, '5': 13, '10': 'serviceCounter'},
  ],
};

/// Descriptor for `ServiceId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceIdDescriptor = $convert.base64Decode(
    'CglTZXJ2aWNlSWQSLAoSbGVmdF9zZXJpYWxfbnVtYmVyGAEgASgNUhBsZWZ0U2VyaWFsTnVtYm'
    'VyEi4KE3JpZ2h0X3NlcmlhbF9udW1iZXIYAiABKA1SEXJpZ2h0U2VyaWFsTnVtYmVyEicKD3Nl'
    'cnZpY2VfY291bnRlchgDIAEoDVIOc2VydmljZUNvdW50ZXI=');

@$core.Deprecated('Use serviceConfigDescriptor instead')
const ServiceConfig$json = {
  '1': 'ServiceConfig',
  '2': [
    {
      '1': 'service_start_time',
      '3': 1,
      '4': 1,
      '5': 4,
      '10': 'serviceStartTime'
    },
    {
      '1': 'service_id',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.ServiceId',
      '10': 'serviceId'
    },
    {
      '1': 'service_type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.ServiceType',
      '10': 'serviceType'
    },
    {'1': 'rate', '3': 5, '4': 1, '5': 13, '10': 'rate'},
    {
      '1': 'enabled_pressure',
      '3': 6,
      '4': 3,
      '5': 8,
      '8': {'2': true},
      '10': 'enabledPressure',
    },
    {
      '1': 'enabled_acceleration',
      '3': 7,
      '4': 3,
      '5': 8,
      '8': {'2': true},
      '10': 'enabledAcceleration',
    },
    {
      '1': 'acc_g_range',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.ServiceConfig.AccGRange',
      '10': 'accGRange'
    },
    {
      '1': 'acc_odr',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.ServiceConfig.AccOdr',
      '10': 'accOdr'
    },
    {
      '1': 'enabled_angular',
      '3': 10,
      '4': 3,
      '5': 8,
      '8': {'2': true},
      '10': 'enabledAngular',
    },
    {
      '1': 'ang_dps_range',
      '3': 11,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.ServiceConfig.AngDpsRange',
      '10': 'angDpsRange'
    },
    {
      '1': 'ang_odr',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.ServiceConfig.AngOdr',
      '10': 'angOdr'
    },
    {
      '1': 'enabled_temperature',
      '3': 13,
      '4': 1,
      '5': 8,
      '10': 'enabledTemperature'
    },
    {
      '1': 'enabled_total_force',
      '3': 14,
      '4': 1,
      '5': 8,
      '10': 'enabledTotalForce'
    },
    {
      '1': 'enabled_cop',
      '3': 15,
      '4': 3,
      '5': 8,
      '8': {'2': true},
      '10': 'enabledCop',
    },
    {
      '1': 'activity_profile',
      '3': 19,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.ServiceConfig.ActivityProfile',
      '10': 'activityProfile'
    },
    {
      '1': 'activity_sensitivity',
      '3': 22,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.ServiceConfig.ActivitySensitivity',
      '10': 'activitySensitivity'
    },
    {'1': 'rec_timeout', '3': 21, '4': 1, '5': 13, '10': 'recTimeout'},
    {
      '1': 'rec_flush_interval',
      '3': 23,
      '4': 1,
      '5': 13,
      '10': 'recFlushInterval'
    },
    {'1': 'is_preview', '3': 24, '4': 1, '5': 8, '10': 'isPreview'},
  ],
  '4': [
    ServiceConfig_AccGRange$json,
    ServiceConfig_AccOdr$json,
    ServiceConfig_AngDpsRange$json,
    ServiceConfig_AngOdr$json,
    ServiceConfig_ActivityProfile$json,
    ServiceConfig_ActivitySensitivity$json
  ],
};

@$core.Deprecated('Use serviceConfigDescriptor instead')
const ServiceConfig_AccGRange$json = {
  '1': 'AccGRange',
  '2': [
    {'1': 'ACC_2_G', '2': 0},
    {'1': 'ACC_4_G', '2': 1},
    {'1': 'ACC_8_G', '2': 2},
    {'1': 'ACC_16_G', '2': 3},
  ],
};

@$core.Deprecated('Use serviceConfigDescriptor instead')
const ServiceConfig_AccOdr$json = {
  '1': 'AccOdr',
  '2': [
    {'1': 'ACC_1_6_ODR', '2': 0},
    {'1': 'ACC_12_5_ODR', '2': 1},
    {'1': 'ACC_26_ODR', '2': 2},
    {'1': 'ACC_52_ODR', '2': 3},
    {'1': 'ACC_104_ODR', '2': 4},
    {'1': 'ACC_208_ODR', '2': 5},
    {'1': 'ACC_416_ODR', '2': 6},
    {'1': 'ACC_833_ODR', '2': 7},
    {'1': 'ACC_1666_ODR', '2': 8},
    {'1': 'ACC_3332_ODR', '2': 9},
    {'1': 'ACC_6664_ODR', '2': 10},
  ],
};

@$core.Deprecated('Use serviceConfigDescriptor instead')
const ServiceConfig_AngDpsRange$json = {
  '1': 'AngDpsRange',
  '2': [
    {'1': 'ANG_125_DPS', '2': 0},
    {'1': 'ANG_250_DPS', '2': 1},
    {'1': 'ANG_500_DPS', '2': 2},
    {'1': 'ANG_1000_DPS', '2': 3},
    {'1': 'ANG_2000_DPS', '2': 4},
  ],
};

@$core.Deprecated('Use serviceConfigDescriptor instead')
const ServiceConfig_AngOdr$json = {
  '1': 'AngOdr',
  '2': [
    {'1': 'ANG_12_5_ODR', '2': 0},
    {'1': 'ANG_26_ODR', '2': 1},
    {'1': 'ANG_52_ODR', '2': 2},
    {'1': 'ANG_104_ODR', '2': 3},
    {'1': 'ANG_208_ODR', '2': 4},
    {'1': 'ANG_416_ODR', '2': 5},
    {'1': 'ANG_833_ODR', '2': 6},
    {'1': 'ANG_1666_ODR', '2': 7},
    {'1': 'ANG_3332_ODR', '2': 8},
    {'1': 'ANG_6664_ODR', '2': 9},
  ],
};

@$core.Deprecated('Use serviceConfigDescriptor instead')
const ServiceConfig_ActivityProfile$json = {
  '1': 'ActivityProfile',
  '2': [
    {'1': 'ACTIVITY_PROFILE_CONTINUOUS', '2': 0},
    {'1': 'ACTIVITY_PROFILE_ACCELERATION', '2': 1},
  ],
};

@$core.Deprecated('Use serviceConfigDescriptor instead')
const ServiceConfig_ActivitySensitivity$json = {
  '1': 'ActivitySensitivity',
  '2': [
    {'1': 'ACTIVITY_SENSITIVITY_INSENSITIVE', '2': 0},
    {'1': 'ACTIVITY_SENSITIVITY_MODERATE', '2': 1},
    {'1': 'ACTIVITY_SENSITIVITY_SENSITIVE', '2': 2},
  ],
};

/// Descriptor for `ServiceConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceConfigDescriptor = $convert.base64Decode(
    'Cg1TZXJ2aWNlQ29uZmlnEiwKEnNlcnZpY2Vfc3RhcnRfdGltZRgBIAEoBFIQc2VydmljZVN0YX'
    'J0VGltZRI/CgpzZXJ2aWNlX2lkGAIgASgLMiAubW90aWNvbl9pbnNvbGUzLnByb3RvLlNlcnZp'
    'Y2VJZFIJc2VydmljZUlkEkUKDHNlcnZpY2VfdHlwZRgDIAEoDjIiLm1vdGljb25faW5zb2xlMy'
    '5wcm90by5TZXJ2aWNlVHlwZVILc2VydmljZVR5cGUSEgoEcmF0ZRgFIAEoDVIEcmF0ZRItChBl'
    'bmFibGVkX3ByZXNzdXJlGAYgAygIQgIQAVIPZW5hYmxlZFByZXNzdXJlEjUKFGVuYWJsZWRfYW'
    'NjZWxlcmF0aW9uGAcgAygIQgIQAVITZW5hYmxlZEFjY2VsZXJhdGlvbhJOCgthY2NfZ19yYW5n'
    'ZRgIIAEoDjIuLm1vdGljb25faW5zb2xlMy5wcm90by5TZXJ2aWNlQ29uZmlnLkFjY0dSYW5nZV'
    'IJYWNjR1JhbmdlEkQKB2FjY19vZHIYCSABKA4yKy5tb3RpY29uX2luc29sZTMucHJvdG8uU2Vy'
    'dmljZUNvbmZpZy5BY2NPZHJSBmFjY09kchIrCg9lbmFibGVkX2FuZ3VsYXIYCiADKAhCAhABUg'
    '5lbmFibGVkQW5ndWxhchJUCg1hbmdfZHBzX3JhbmdlGAsgASgOMjAubW90aWNvbl9pbnNvbGUz'
    'LnByb3RvLlNlcnZpY2VDb25maWcuQW5nRHBzUmFuZ2VSC2FuZ0Rwc1JhbmdlEkQKB2FuZ19vZH'
    'IYDCABKA4yKy5tb3RpY29uX2luc29sZTMucHJvdG8uU2VydmljZUNvbmZpZy5BbmdPZHJSBmFu'
    'Z09kchIvChNlbmFibGVkX3RlbXBlcmF0dXJlGA0gASgIUhJlbmFibGVkVGVtcGVyYXR1cmUSLg'
    'oTZW5hYmxlZF90b3RhbF9mb3JjZRgOIAEoCFIRZW5hYmxlZFRvdGFsRm9yY2USIwoLZW5hYmxl'
    'ZF9jb3AYDyADKAhCAhABUgplbmFibGVkQ29wEl8KEGFjdGl2aXR5X3Byb2ZpbGUYEyABKA4yNC'
    '5tb3RpY29uX2luc29sZTMucHJvdG8uU2VydmljZUNvbmZpZy5BY3Rpdml0eVByb2ZpbGVSD2Fj'
    'dGl2aXR5UHJvZmlsZRJrChRhY3Rpdml0eV9zZW5zaXRpdml0eRgWIAEoDjI4Lm1vdGljb25faW'
    '5zb2xlMy5wcm90by5TZXJ2aWNlQ29uZmlnLkFjdGl2aXR5U2Vuc2l0aXZpdHlSE2FjdGl2aXR5'
    'U2Vuc2l0aXZpdHkSHwoLcmVjX3RpbWVvdXQYFSABKA1SCnJlY1RpbWVvdXQSLAoScmVjX2ZsdX'
    'NoX2ludGVydmFsGBcgASgNUhByZWNGbHVzaEludGVydmFsEh0KCmlzX3ByZXZpZXcYGCABKAhS'
    'CWlzUHJldmlldyJACglBY2NHUmFuZ2USCwoHQUNDXzJfRxAAEgsKB0FDQ180X0cQARILCgdBQ0'
    'NfOF9HEAISDAoIQUNDXzE2X0cQAyLFAQoGQWNjT2RyEg8KC0FDQ18xXzZfT0RSEAASEAoMQUND'
    'XzEyXzVfT0RSEAESDgoKQUNDXzI2X09EUhACEg4KCkFDQ181Ml9PRFIQAxIPCgtBQ0NfMTA0X0'
    '9EUhAEEg8KC0FDQ18yMDhfT0RSEAUSDwoLQUNDXzQxNl9PRFIQBhIPCgtBQ0NfODMzX09EUhAH'
    'EhAKDEFDQ18xNjY2X09EUhAIEhAKDEFDQ18zMzMyX09EUhAJEhAKDEFDQ182NjY0X09EUhAKIm'
    'QKC0FuZ0Rwc1JhbmdlEg8KC0FOR18xMjVfRFBTEAASDwoLQU5HXzI1MF9EUFMQARIPCgtBTkdf'
    'NTAwX0RQUxACEhAKDEFOR18xMDAwX0RQUxADEhAKDEFOR18yMDAwX0RQUxAEIrQBCgZBbmdPZH'
    'ISEAoMQU5HXzEyXzVfT0RSEAASDgoKQU5HXzI2X09EUhABEg4KCkFOR181Ml9PRFIQAhIPCgtB'
    'TkdfMTA0X09EUhADEg8KC0FOR18yMDhfT0RSEAQSDwoLQU5HXzQxNl9PRFIQBRIPCgtBTkdfOD'
    'MzX09EUhAGEhAKDEFOR18xNjY2X09EUhAHEhAKDEFOR18zMzMyX09EUhAIEhAKDEFOR182NjY0'
    'X09EUhAJIlUKD0FjdGl2aXR5UHJvZmlsZRIfChtBQ1RJVklUWV9QUk9GSUxFX0NPTlRJTlVPVV'
    'MQABIhCh1BQ1RJVklUWV9QUk9GSUxFX0FDQ0VMRVJBVElPThABIoIBChNBY3Rpdml0eVNlbnNp'
    'dGl2aXR5EiQKIEFDVElWSVRZX1NFTlNJVElWSVRZX0lOU0VOU0lUSVZFEAASIQodQUNUSVZJVF'
    'lfU0VOU0lUSVZJVFlfTU9ERVJBVEUQARIiCh5BQ1RJVklUWV9TRU5TSVRJVklUWV9TRU5TSVRJ'
    'VkUQAg==');

@$core.Deprecated('Use insoleStatusDescriptor instead')
const InsoleStatus$json = {
  '1': 'InsoleStatus',
  '2': [
    {'1': 'memory_usage', '3': 1, '4': 1, '5': 13, '10': 'memoryUsage'},
    {'1': 'battery_level', '3': 2, '4': 1, '5': 13, '10': 'batteryLevel'},
    {'1': 'restart_counter', '3': 3, '4': 1, '5': 13, '10': 'restartCounter'},
    {'1': 'sys_clock', '3': 4, '4': 1, '5': 4, '10': 'sysClock'},
    {'1': 'erase_progress', '3': 5, '4': 1, '5': 13, '10': 'eraseProgress'},
    {
      '1': 'zeroing_status',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.ZeroingStatus',
      '10': 'zeroingStatus'
    },
  ],
};

/// Descriptor for `InsoleStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insoleStatusDescriptor = $convert.base64Decode(
    'CgxJbnNvbGVTdGF0dXMSIQoMbWVtb3J5X3VzYWdlGAEgASgNUgttZW1vcnlVc2FnZRIjCg1iYX'
    'R0ZXJ5X2xldmVsGAIgASgNUgxiYXR0ZXJ5TGV2ZWwSJwoPcmVzdGFydF9jb3VudGVyGAMgASgN'
    'Ug5yZXN0YXJ0Q291bnRlchIbCglzeXNfY2xvY2sYBCABKARSCHN5c0Nsb2NrEiUKDmVyYXNlX3'
    'Byb2dyZXNzGAUgASgNUg1lcmFzZVByb2dyZXNzEksKDnplcm9pbmdfc3RhdHVzGAcgASgLMiQu'
    'bW90aWNvbl9pbnNvbGUzLnByb3RvLlplcm9pbmdTdGF0dXNSDXplcm9pbmdTdGF0dXM=');

@$core.Deprecated('Use insoleStateDescriptor instead')
const InsoleState$json = {
  '1': 'InsoleState',
  '2': [
    {'1': 'on_time', '3': 1, '4': 1, '5': 4, '10': 'onTime'},
    {'1': 'use_time', '3': 2, '4': 1, '5': 4, '10': 'useTime'},
    {'1': 'restart_counter', '3': 3, '4': 1, '5': 13, '10': 'restartCounter'},
    {'1': 'sys_clock', '3': 4, '4': 1, '5': 4, '10': 'sysClock'},
    {'1': 'defect_sensors', '3': 7, '4': 1, '5': 4, '10': 'defectSensors'},
    {'1': 'force_cycles', '3': 9, '4': 1, '5': 4, '10': 'forceCycles'},
    {'1': 'force_integral', '3': 10, '4': 1, '5': 4, '10': 'forceIntegral'},
  ],
};

/// Descriptor for `InsoleState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insoleStateDescriptor = $convert.base64Decode(
    'CgtJbnNvbGVTdGF0ZRIXCgdvbl90aW1lGAEgASgEUgZvblRpbWUSGQoIdXNlX3RpbWUYAiABKA'
    'RSB3VzZVRpbWUSJwoPcmVzdGFydF9jb3VudGVyGAMgASgNUg5yZXN0YXJ0Q291bnRlchIbCglz'
    'eXNfY2xvY2sYBCABKARSCHN5c0Nsb2NrEiUKDmRlZmVjdF9zZW5zb3JzGAcgASgEUg1kZWZlY3'
    'RTZW5zb3JzEiEKDGZvcmNlX2N5Y2xlcxgJIAEoBFILZm9yY2VDeWNsZXMSJQoOZm9yY2VfaW50'
    'ZWdyYWwYCiABKARSDWZvcmNlSW50ZWdyYWw=');

@$core.Deprecated('Use zeroingStatusDescriptor instead')
const ZeroingStatus$json = {
  '1': 'ZeroingStatus',
  '2': [
    {'1': 'confidence', '3': 1, '4': 1, '5': 13, '10': 'confidence'},
    {'1': 'validity_period', '3': 2, '4': 1, '5': 13, '10': 'validityPeriod'},
    {'1': 'warmup', '3': 3, '4': 1, '5': 13, '10': 'warmup'},
  ],
};

/// Descriptor for `ZeroingStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zeroingStatusDescriptor = $convert.base64Decode(
    'Cg1aZXJvaW5nU3RhdHVzEh4KCmNvbmZpZGVuY2UYASABKA1SCmNvbmZpZGVuY2USJwoPdmFsaW'
    'RpdHlfcGVyaW9kGAIgASgNUg52YWxpZGl0eVBlcmlvZBIWCgZ3YXJtdXAYAyABKA1SBndhcm11'
    'cA==');

@$core.Deprecated('Use insoleSettingsDescriptor instead')
const InsoleSettings$json = {
  '1': 'InsoleSettings',
  '2': [
    {'1': 'serial_number', '3': 1, '4': 1, '5': 13, '10': 'serialNumber'},
    {'1': 'size', '3': 2, '4': 1, '5': 13, '10': 'size'},
    {
      '1': 'side',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.Side',
      '10': 'side'
    },
    {'1': 'num_sensors', '3': 8, '4': 1, '5': 13, '10': 'numSensors'},
    {'1': 'mpu_hash', '3': 11, '4': 1, '5': 12, '10': 'mpuHash'},
    {
      '1': 'mpu_version',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.Version',
      '10': 'mpuVersion'
    },
    {'1': 'mpu_modified', '3': 13, '4': 1, '5': 8, '10': 'mpuModified'},
    {'1': 'memory_size', '3': 22, '4': 1, '5': 13, '10': 'memorySize'},
    {
      '1': 'zeroing',
      '3': 27,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.Zeroing',
      '10': 'zeroing'
    },
    {'1': 'fw_version_code', '3': 28, '4': 1, '5': 13, '10': 'fwVersionCode'},
  ],
};

/// Descriptor for `InsoleSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insoleSettingsDescriptor = $convert.base64Decode(
    'Cg5JbnNvbGVTZXR0aW5ncxIjCg1zZXJpYWxfbnVtYmVyGAEgASgNUgxzZXJpYWxOdW1iZXISEg'
    'oEc2l6ZRgCIAEoDVIEc2l6ZRIvCgRzaWRlGAMgASgOMhsubW90aWNvbl9pbnNvbGUzLnByb3Rv'
    'LlNpZGVSBHNpZGUSHwoLbnVtX3NlbnNvcnMYCCABKA1SCm51bVNlbnNvcnMSGQoIbXB1X2hhc2'
    'gYCyABKAxSB21wdUhhc2gSPwoLbXB1X3ZlcnNpb24YDCABKAsyHi5tb3RpY29uX2luc29sZTMu'
    'cHJvdG8uVmVyc2lvblIKbXB1VmVyc2lvbhIhCgxtcHVfbW9kaWZpZWQYDSABKAhSC21wdU1vZG'
    'lmaWVkEh8KC21lbW9yeV9zaXplGBYgASgNUgptZW1vcnlTaXplEjgKB3plcm9pbmcYGyABKAsy'
    'Hi5tb3RpY29uX2luc29sZTMucHJvdG8uWmVyb2luZ1IHemVyb2luZxImCg9md192ZXJzaW9uX2'
    'NvZGUYHCABKA1SDWZ3VmVyc2lvbkNvZGU=');

@$core.Deprecated('Use sensorCoordinatesDescriptor instead')
const SensorCoordinates$json = {
  '1': 'SensorCoordinates',
  '2': [
    {
      '1': 'x',
      '3': 1,
      '4': 3,
      '5': 2,
      '8': {'2': true},
      '10': 'x',
    },
    {
      '1': 'y',
      '3': 2,
      '4': 3,
      '5': 2,
      '8': {'2': true},
      '10': 'y',
    },
    {
      '1': 'area',
      '3': 3,
      '4': 3,
      '5': 2,
      '8': {'2': true},
      '10': 'area',
    },
    {
      '1': 'area_factor',
      '3': 4,
      '4': 3,
      '5': 2,
      '8': {'2': true},
      '10': 'areaFactor',
    },
  ],
};

/// Descriptor for `SensorCoordinates`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorCoordinatesDescriptor = $convert.base64Decode(
    'ChFTZW5zb3JDb29yZGluYXRlcxIQCgF4GAEgAygCQgIQAVIBeBIQCgF5GAIgAygCQgIQAVIBeR'
    'IWCgRhcmVhGAMgAygCQgIQAVIEYXJlYRIjCgthcmVhX2ZhY3RvchgEIAMoAkICEAFSCmFyZWFG'
    'YWN0b3I=');

@$core.Deprecated('Use zeroingDescriptor instead')
const Zeroing$json = {
  '1': 'Zeroing',
  '2': [
    {
      '1': 'source',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.ZeroingSource',
      '10': 'source'
    },
    {
      '1': 'mode',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.ZeroingMode',
      '10': 'mode'
    },
    {
      '1': 'side',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.Side',
      '10': 'side'
    },
  ],
};

/// Descriptor for `Zeroing`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zeroingDescriptor = $convert.base64Decode(
    'CgdaZXJvaW5nEjwKBnNvdXJjZRgBIAEoDjIkLm1vdGljb25faW5zb2xlMy5wcm90by5aZXJvaW'
    '5nU291cmNlUgZzb3VyY2USNgoEbW9kZRgCIAEoDjIiLm1vdGljb25faW5zb2xlMy5wcm90by5a'
    'ZXJvaW5nTW9kZVIEbW9kZRIvCgRzaWRlGAQgASgOMhsubW90aWNvbl9pbnNvbGUzLnByb3RvLl'
    'NpZGVSBHNpZGU=');

@$core.Deprecated('Use zeroingConfDescriptor instead')
const ZeroingConf$json = {
  '1': 'ZeroingConf',
  '2': [
    {
      '1': 'error',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.Error',
      '10': 'error'
    },
    {
      '1': 'side',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.Side',
      '10': 'side'
    },
  ],
};

/// Descriptor for `ZeroingConf`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zeroingConfDescriptor = $convert.base64Decode(
    'CgtaZXJvaW5nQ29uZhIyCgVlcnJvchgBIAEoCzIcLm1vdGljb25faW5zb2xlMy5wcm90by5Fcn'
    'JvclIFZXJyb3ISLwoEc2lkZRgCIAEoDjIbLm1vdGljb25faW5zb2xlMy5wcm90by5TaWRlUgRz'
    'aWRl');

@$core.Deprecated('Use endpointSettingsDescriptor instead')
const EndpointSettings$json = {
  '1': 'EndpointSettings',
  '2': [
    {'1': 'ip_address', '3': 1, '4': 1, '5': 9, '10': 'ipAddress'},
    {'1': 'port', '3': 2, '4': 1, '5': 13, '10': 'port'},
  ],
};

/// Descriptor for `EndpointSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List endpointSettingsDescriptor = $convert.base64Decode(
    'ChBFbmRwb2ludFNldHRpbmdzEh0KCmlwX2FkZHJlc3MYASABKAlSCWlwQWRkcmVzcxISCgRwb3'
    'J0GAIgASgNUgRwb3J0');

@$core.Deprecated('Use serviceEndpointDescriptor instead')
const ServiceEndpoint$json = {
  '1': 'ServiceEndpoint',
  '2': [
    {
      '1': 'endpoint_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.ServiceEndpoint.EndpointType',
      '10': 'endpointType'
    },
    {
      '1': 'endpoint_settings',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.EndpointSettings',
      '10': 'endpointSettings'
    },
    {'1': 'service_counter', '3': 3, '4': 1, '5': 13, '10': 'serviceCounter'},
  ],
  '4': [ServiceEndpoint_EndpointType$json],
};

@$core.Deprecated('Use serviceEndpointDescriptor instead')
const ServiceEndpoint_EndpointType$json = {
  '1': 'EndpointType',
  '2': [
    {'1': 'UNDEFINED', '2': 0},
    {'1': 'APP', '2': 1},
    {'1': 'SERVICE', '2': 2},
    {'1': 'PC', '2': 3},
  ],
};

/// Descriptor for `ServiceEndpoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceEndpointDescriptor = $convert.base64Decode(
    'Cg9TZXJ2aWNlRW5kcG9pbnQSWAoNZW5kcG9pbnRfdHlwZRgBIAEoDjIzLm1vdGljb25faW5zb2'
    'xlMy5wcm90by5TZXJ2aWNlRW5kcG9pbnQuRW5kcG9pbnRUeXBlUgxlbmRwb2ludFR5cGUSVAoR'
    'ZW5kcG9pbnRfc2V0dGluZ3MYAiABKAsyJy5tb3RpY29uX2luc29sZTMucHJvdG8uRW5kcG9pbn'
    'RTZXR0aW5nc1IQZW5kcG9pbnRTZXR0aW5ncxInCg9zZXJ2aWNlX2NvdW50ZXIYAyABKA1SDnNl'
    'cnZpY2VDb3VudGVyIjsKDEVuZHBvaW50VHlwZRINCglVTkRFRklORUQQABIHCgNBUFAQARILCg'
    'dTRVJWSUNFEAISBgoCUEMQAw==');

@$core.Deprecated('Use insoleStartServiceConfDescriptor instead')
const InsoleStartServiceConf$json = {
  '1': 'InsoleStartServiceConf',
  '2': [
    {
      '1': 'error',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.Error',
      '10': 'error'
    },
    {'1': 'service_counter', '3': 2, '4': 1, '5': 13, '10': 'serviceCounter'},
  ],
};

/// Descriptor for `InsoleStartServiceConf`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insoleStartServiceConfDescriptor = $convert.base64Decode(
    'ChZJbnNvbGVTdGFydFNlcnZpY2VDb25mEjIKBWVycm9yGAEgASgLMhwubW90aWNvbl9pbnNvbG'
    'UzLnByb3RvLkVycm9yUgVlcnJvchInCg9zZXJ2aWNlX2NvdW50ZXIYAiABKA1SDnNlcnZpY2VD'
    'b3VudGVy');

@$core.Deprecated('Use measurementInfoDescriptor instead')
const MeasurementInfo$json = {
  '1': 'MeasurementInfo',
  '2': [
    {'1': 'start_time', '3': 1, '4': 1, '5': 4, '10': 'startTime'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'tag', '3': 3, '4': 3, '5': 9, '10': 'tag'},
    {'1': 'comment', '3': 4, '4': 1, '5': 9, '10': 'comment'},
  ],
};

/// Descriptor for `MeasurementInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List measurementInfoDescriptor = $convert.base64Decode(
    'Cg9NZWFzdXJlbWVudEluZm8SHQoKc3RhcnRfdGltZRgBIAEoBFIJc3RhcnRUaW1lEhIKBG5hbW'
    'UYAiABKAlSBG5hbWUSEAoDdGFnGAMgAygJUgN0YWcSGAoHY29tbWVudBgEIAEoCVIHY29tbWVu'
    'dA==');

@$core.Deprecated('Use dataMessageDescriptor instead')
const DataMessage$json = {
  '1': 'DataMessage',
  '2': [
    {
      '1': 'service_id',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.ServiceId',
      '10': 'serviceId'
    },
    {'1': 'time', '3': 2, '4': 1, '5': 4, '10': 'time'},
    {
      '1': 'side',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.Side',
      '10': 'side'
    },
    {
      '1': 'pressure',
      '3': 4,
      '4': 3,
      '5': 13,
      '8': {'2': true},
      '10': 'pressure',
    },
    {
      '1': 'acceleration',
      '3': 5,
      '4': 3,
      '5': 2,
      '8': {'2': true},
      '10': 'acceleration',
    },
    {
      '1': 'angular',
      '3': 6,
      '4': 3,
      '5': 2,
      '8': {'2': true},
      '10': 'angular',
    },
    {'1': 'temperature', '3': 7, '4': 1, '5': 2, '10': 'temperature'},
    {'1': 'total_force', '3': 8, '4': 1, '5': 13, '10': 'totalForce'},
    {
      '1': 'cop',
      '3': 9,
      '4': 3,
      '5': 2,
      '8': {'2': true},
      '10': 'cop',
    },
  ],
};

/// Descriptor for `DataMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataMessageDescriptor = $convert.base64Decode(
    'CgtEYXRhTWVzc2FnZRI/CgpzZXJ2aWNlX2lkGAEgASgLMiAubW90aWNvbl9pbnNvbGUzLnByb3'
    'RvLlNlcnZpY2VJZFIJc2VydmljZUlkEhIKBHRpbWUYAiABKARSBHRpbWUSLwoEc2lkZRgDIAEo'
    'DjIbLm1vdGljb25faW5zb2xlMy5wcm90by5TaWRlUgRzaWRlEh4KCHByZXNzdXJlGAQgAygNQg'
    'IQAVIIcHJlc3N1cmUSJgoMYWNjZWxlcmF0aW9uGAUgAygCQgIQAVIMYWNjZWxlcmF0aW9uEhwK'
    'B2FuZ3VsYXIYBiADKAJCAhABUgdhbmd1bGFyEiAKC3RlbXBlcmF0dXJlGAcgASgCUgt0ZW1wZX'
    'JhdHVyZRIfCgt0b3RhbF9mb3JjZRgIIAEoDVIKdG90YWxGb3JjZRIUCgNjb3AYCSADKAJCAhAB'
    'UgNjb3A=');

@$core.Deprecated('Use activityDescriptor instead')
const Activity$json = {
  '1': 'Activity',
  '2': [
    {
      '1': 'service_id',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.ServiceId',
      '10': 'serviceId'
    },
    {'1': 'time', '3': 2, '4': 1, '5': 4, '10': 'time'},
    {
      '1': 'side',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.Side',
      '10': 'side'
    },
    {
      '1': 'event',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.Activity.ActivityEvent',
      '10': 'event'
    },
  ],
  '4': [Activity_ActivityEvent$json],
};

@$core.Deprecated('Use activityDescriptor instead')
const Activity_ActivityEvent$json = {
  '1': 'ActivityEvent',
  '2': [
    {'1': 'ACTIVITY_PAUSE', '2': 0},
    {'1': 'ACTIVITY_RESUME', '2': 1},
    {'1': 'ACTIVITY_RESTART', '2': 2},
  ],
};

/// Descriptor for `Activity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List activityDescriptor = $convert.base64Decode(
    'CghBY3Rpdml0eRI/CgpzZXJ2aWNlX2lkGAEgASgLMiAubW90aWNvbl9pbnNvbGUzLnByb3RvLl'
    'NlcnZpY2VJZFIJc2VydmljZUlkEhIKBHRpbWUYAiABKARSBHRpbWUSLwoEc2lkZRgDIAEoDjIb'
    'Lm1vdGljb25faW5zb2xlMy5wcm90by5TaWRlUgRzaWRlEkMKBWV2ZW50GAQgASgOMi0ubW90aW'
    'Nvbl9pbnNvbGUzLnByb3RvLkFjdGl2aXR5LkFjdGl2aXR5RXZlbnRSBWV2ZW50Ik4KDUFjdGl2'
    'aXR5RXZlbnQSEgoOQUNUSVZJVFlfUEFVU0UQABITCg9BQ1RJVklUWV9SRVNVTUUQARIUChBBQ1'
    'RJVklUWV9SRVNUQVJUEAI=');

@$core.Deprecated('Use timestampConfDescriptor instead')
const TimestampConf$json = {
  '1': 'TimestampConf',
  '2': [
    {'1': 'seq_num', '3': 1, '4': 1, '5': 13, '10': 'seqNum'},
    {'1': 'time_tx', '3': 2, '4': 1, '5': 4, '10': 'timeTx'},
    {'1': 'time_rx', '3': 3, '4': 1, '5': 4, '10': 'timeRx'},
    {'1': 'time_conf_tx', '3': 4, '4': 1, '5': 4, '10': 'timeConfTx'},
  ],
};

/// Descriptor for `TimestampConf`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timestampConfDescriptor = $convert.base64Decode(
    'Cg1UaW1lc3RhbXBDb25mEhcKB3NlcV9udW0YASABKA1SBnNlcU51bRIXCgd0aW1lX3R4GAIgAS'
    'gEUgZ0aW1lVHgSFwoHdGltZV9yeBgDIAEoBFIGdGltZVJ4EiAKDHRpbWVfY29uZl90eBgEIAEo'
    'BFIKdGltZUNvbmZUeA==');

@$core.Deprecated('Use insoleRecDeleteDescriptor instead')
const InsoleRecDelete$json = {
  '1': 'InsoleRecDelete',
  '2': [
    {
      '1': 'side',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.Side',
      '10': 'side'
    },
    {'1': 'service_counter', '3': 2, '4': 1, '5': 13, '10': 'serviceCounter'},
    {'1': 'force_erase', '3': 3, '4': 1, '5': 8, '10': 'forceErase'},
  ],
};

/// Descriptor for `InsoleRecDelete`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insoleRecDeleteDescriptor = $convert.base64Decode(
    'Cg9JbnNvbGVSZWNEZWxldGUSLwoEc2lkZRgBIAEoDjIbLm1vdGljb25faW5zb2xlMy5wcm90by'
    '5TaWRlUgRzaWRlEicKD3NlcnZpY2VfY291bnRlchgCIAEoDVIOc2VydmljZUNvdW50ZXISHwoL'
    'Zm9yY2VfZXJhc2UYAyABKAhSCmZvcmNlRXJhc2U=');

@$core.Deprecated('Use insoleRecDeleteConfDescriptor instead')
const InsoleRecDeleteConf$json = {
  '1': 'InsoleRecDeleteConf',
  '2': [
    {
      '1': 'side',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.Side',
      '10': 'side'
    },
    {'1': 'service_counter', '3': 2, '4': 1, '5': 13, '10': 'serviceCounter'},
    {
      '1': 'error',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.Error',
      '10': 'error'
    },
  ],
};

/// Descriptor for `InsoleRecDeleteConf`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insoleRecDeleteConfDescriptor = $convert.base64Decode(
    'ChNJbnNvbGVSZWNEZWxldGVDb25mEi8KBHNpZGUYASABKA4yGy5tb3RpY29uX2luc29sZTMucH'
    'JvdG8uU2lkZVIEc2lkZRInCg9zZXJ2aWNlX2NvdW50ZXIYAiABKA1SDnNlcnZpY2VDb3VudGVy'
    'EjIKBWVycm9yGAMgASgLMhwubW90aWNvbl9pbnNvbGUzLnByb3RvLkVycm9yUgVlcnJvcg==');

@$core.Deprecated('Use recStateDescriptor instead')
const RecState$json = {
  '1': 'RecState',
  '2': [
    {'1': 'packet_count', '3': 1, '4': 1, '5': 13, '10': 'packetCount'},
    {'1': 'stopped', '3': 2, '4': 1, '5': 8, '10': 'stopped'},
  ],
};

/// Descriptor for `RecState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recStateDescriptor = $convert.base64Decode(
    'CghSZWNTdGF0ZRIhCgxwYWNrZXRfY291bnQYASABKA1SC3BhY2tldENvdW50EhgKB3N0b3BwZW'
    'QYAiABKAhSB3N0b3BwZWQ=');

@$core.Deprecated('Use enterBootloaderDescriptor instead')
const EnterBootloader$json = {
  '1': 'EnterBootloader',
  '2': [
    {
      '1': 'side',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.Side',
      '10': 'side'
    },
    {'1': 'fast_boot', '3': 2, '4': 1, '5': 8, '10': 'fastBoot'},
  ],
};

/// Descriptor for `EnterBootloader`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List enterBootloaderDescriptor = $convert.base64Decode(
    'Cg9FbnRlckJvb3Rsb2FkZXISLwoEc2lkZRgBIAEoDjIbLm1vdGljb25faW5zb2xlMy5wcm90by'
    '5TaWRlUgRzaWRlEhsKCWZhc3RfYm9vdBgCIAEoCFIIZmFzdEJvb3Q=');
