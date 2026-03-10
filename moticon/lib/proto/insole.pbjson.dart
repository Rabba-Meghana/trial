// This is a generated file - do not edit.
//
// Generated from insole.proto.

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

@$core.Deprecated('Use insoleMessageDescriptor instead')
const InsoleMessage$json = {
  '1': 'InsoleMessage',
  '2': [
    {
      '1': 'insole_info_req',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.insole.InsoleInfoReq',
      '9': 0,
      '10': 'insoleInfoReq'
    },
    {
      '1': 'moticon_insole_info',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.insole.MoticonInsoleInfo',
      '9': 0,
      '10': 'moticonInsoleInfo'
    },
    {
      '1': 'zeroing',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.Zeroing',
      '9': 0,
      '10': 'zeroing'
    },
    {
      '1': 'zeroing_conf',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.ZeroingConf',
      '9': 0,
      '10': 'zeroingConf'
    },
    {
      '1': 'data_message',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.DataMessage',
      '9': 0,
      '10': 'dataMessage'
    },
    {
      '1': 'start_service',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.insole.InsoleStartService',
      '9': 0,
      '10': 'startService'
    },
    {
      '1': 'start_service_conf',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.InsoleStartServiceConf',
      '9': 0,
      '10': 'startServiceConf'
    },
    {
      '1': 'stop_service',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.insole.InsoleStopService',
      '9': 0,
      '10': 'stopService'
    },
    {
      '1': 'stop_service_conf',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.insole.InsoleStopServiceConf',
      '9': 0,
      '10': 'stopServiceConf'
    },
    {
      '1': 'service_info_req',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.insole.ServiceInfoReq',
      '9': 0,
      '10': 'serviceInfoReq'
    },
    {
      '1': 'service_info',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.insole.ServiceInfo',
      '9': 0,
      '10': 'serviceInfo'
    },
  ],
  '8': [
    {'1': 'msg'},
  ],
};

/// Descriptor for `InsoleMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insoleMessageDescriptor = $convert.base64Decode(
    'Cg1JbnNvbGVNZXNzYWdlElUKD2luc29sZV9pbmZvX3JlcRgCIAEoCzIrLm1vdGljb25faW5zb2'
    'xlMy5wcm90by5pbnNvbGUuSW5zb2xlSW5mb1JlcUgAUg1pbnNvbGVJbmZvUmVxEmEKE21vdGlj'
    'b25faW5zb2xlX2luZm8YAyABKAsyLy5tb3RpY29uX2luc29sZTMucHJvdG8uaW5zb2xlLk1vdG'
    'ljb25JbnNvbGVJbmZvSABSEW1vdGljb25JbnNvbGVJbmZvEjoKB3plcm9pbmcYCSABKAsyHi5t'
    'b3RpY29uX2luc29sZTMucHJvdG8uWmVyb2luZ0gAUgd6ZXJvaW5nEkcKDHplcm9pbmdfY29uZh'
    'gKIAEoCzIiLm1vdGljb25faW5zb2xlMy5wcm90by5aZXJvaW5nQ29uZkgAUgt6ZXJvaW5nQ29u'
    'ZhJHCgxkYXRhX21lc3NhZ2UYDCABKAsyIi5tb3RpY29uX2luc29sZTMucHJvdG8uRGF0YU1lc3'
    'NhZ2VIAFILZGF0YU1lc3NhZ2USVwoNc3RhcnRfc2VydmljZRgNIAEoCzIwLm1vdGljb25faW5z'
    'b2xlMy5wcm90by5pbnNvbGUuSW5zb2xlU3RhcnRTZXJ2aWNlSABSDHN0YXJ0U2VydmljZRJdCh'
    'JzdGFydF9zZXJ2aWNlX2NvbmYYDiABKAsyLS5tb3RpY29uX2luc29sZTMucHJvdG8uSW5zb2xl'
    'U3RhcnRTZXJ2aWNlQ29uZkgAUhBzdGFydFNlcnZpY2VDb25mElQKDHN0b3Bfc2VydmljZRgPIA'
    'EoCzIvLm1vdGljb25faW5zb2xlMy5wcm90by5pbnNvbGUuSW5zb2xlU3RvcFNlcnZpY2VIAFIL'
    'c3RvcFNlcnZpY2USYQoRc3RvcF9zZXJ2aWNlX2NvbmYYECABKAsyMy5tb3RpY29uX2luc29sZT'
    'MucHJvdG8uaW5zb2xlLkluc29sZVN0b3BTZXJ2aWNlQ29uZkgAUg9zdG9wU2VydmljZUNvbmYS'
    'WAoQc2VydmljZV9pbmZvX3JlcRgVIAEoCzIsLm1vdGljb25faW5zb2xlMy5wcm90by5pbnNvbG'
    'UuU2VydmljZUluZm9SZXFIAFIOc2VydmljZUluZm9SZXESTgoMc2VydmljZV9pbmZvGBYgASgL'
    'MikubW90aWNvbl9pbnNvbGUzLnByb3RvLmluc29sZS5TZXJ2aWNlSW5mb0gAUgtzZXJ2aWNlSW'
    '5mb0IFCgNtc2c=');

@$core.Deprecated('Use moticonInsoleInfoDescriptor instead')
const MoticonInsoleInfo$json = {
  '1': 'MoticonInsoleInfo',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.InsoleInfoType',
      '10': 'type'
    },
    {
      '1': 'insole_status',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.InsoleStatus',
      '10': 'insoleStatus'
    },
    {
      '1': 'insole_state',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.InsoleState',
      '10': 'insoleState'
    },
    {
      '1': 'insole_settings',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.InsoleSettings',
      '10': 'insoleSettings'
    },
    {
      '1': 'sensor_coordinates',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.SensorCoordinates',
      '10': 'sensorCoordinates'
    },
  ],
};

/// Descriptor for `MoticonInsoleInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moticonInsoleInfoDescriptor = $convert.base64Decode(
    'ChFNb3RpY29uSW5zb2xlSW5mbxI5CgR0eXBlGAEgASgOMiUubW90aWNvbl9pbnNvbGUzLnByb3'
    'RvLkluc29sZUluZm9UeXBlUgR0eXBlEkgKDWluc29sZV9zdGF0dXMYAiABKAsyIy5tb3RpY29u'
    'X2luc29sZTMucHJvdG8uSW5zb2xlU3RhdHVzUgxpbnNvbGVTdGF0dXMSRQoMaW5zb2xlX3N0YX'
    'RlGAMgASgLMiIubW90aWNvbl9pbnNvbGUzLnByb3RvLkluc29sZVN0YXRlUgtpbnNvbGVTdGF0'
    'ZRJOCg9pbnNvbGVfc2V0dGluZ3MYBCABKAsyJS5tb3RpY29uX2luc29sZTMucHJvdG8uSW5zb2'
    'xlU2V0dGluZ3NSDmluc29sZVNldHRpbmdzElcKEnNlbnNvcl9jb29yZGluYXRlcxgFIAEoCzIo'
    'Lm1vdGljb25faW5zb2xlMy5wcm90by5TZW5zb3JDb29yZGluYXRlc1IRc2Vuc29yQ29vcmRpbm'
    'F0ZXM=');

@$core.Deprecated('Use serviceInfoReqDescriptor instead')
const ServiceInfoReq$json = {
  '1': 'ServiceInfoReq',
  '2': [
    {
      '1': 'queried_service_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.ServiceType',
      '10': 'queriedServiceType'
    },
  ],
};

/// Descriptor for `ServiceInfoReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceInfoReqDescriptor = $convert.base64Decode(
    'Cg5TZXJ2aWNlSW5mb1JlcRJUChRxdWVyaWVkX3NlcnZpY2VfdHlwZRgBIAEoDjIiLm1vdGljb2'
    '5faW5zb2xlMy5wcm90by5TZXJ2aWNlVHlwZVIScXVlcmllZFNlcnZpY2VUeXBl');

@$core.Deprecated('Use serviceInfoDescriptor instead')
const ServiceInfo$json = {
  '1': 'ServiceInfo',
  '2': [
    {
      '1': 'queried_service_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.ServiceType',
      '10': 'queriedServiceType'
    },
    {
      '1': 'service_config',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.moticon_insole3.proto.ServiceConfig',
      '10': 'serviceConfig'
    },
  ],
};

/// Descriptor for `ServiceInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceInfoDescriptor = $convert.base64Decode(
    'CgtTZXJ2aWNlSW5mbxJUChRxdWVyaWVkX3NlcnZpY2VfdHlwZRgBIAEoDjIiLm1vdGljb25faW'
    '5zb2xlMy5wcm90by5TZXJ2aWNlVHlwZVIScXVlcmllZFNlcnZpY2VUeXBlEksKDnNlcnZpY2Vf'
    'Y29uZmlnGAIgAygLMiQubW90aWNvbl9pbnNvbGUzLnByb3RvLlNlcnZpY2VDb25maWdSDXNlcn'
    'ZpY2VDb25maWc=');

@$core.Deprecated('Use insoleInfoReqDescriptor instead')
const InsoleInfoReq$json = {
  '1': 'InsoleInfoReq',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.moticon_insole3.proto.InsoleInfoType',
      '10': 'type'
    },
  ],
};

/// Descriptor for `InsoleInfoReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insoleInfoReqDescriptor = $convert.base64Decode(
    'Cg1JbnNvbGVJbmZvUmVxEjkKBHR5cGUYASABKA4yJS5tb3RpY29uX2luc29sZTMucHJvdG8uSW'
    '5zb2xlSW5mb1R5cGVSBHR5cGU=');

@$core.Deprecated('Use insoleStartServiceDescriptor instead')
const InsoleStartService$json = {
  '1': 'InsoleStartService',
  '2': [
    {
      '1': 'service_config',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.ServiceConfig',
      '10': 'serviceConfig'
    },
    {
      '1': 'measurement_info',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.MeasurementInfo',
      '10': 'measurementInfo'
    },
  ],
};

/// Descriptor for `InsoleStartService`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insoleStartServiceDescriptor = $convert.base64Decode(
    'ChJJbnNvbGVTdGFydFNlcnZpY2USSwoOc2VydmljZV9jb25maWcYASABKAsyJC5tb3RpY29uX2'
    'luc29sZTMucHJvdG8uU2VydmljZUNvbmZpZ1INc2VydmljZUNvbmZpZxJRChBtZWFzdXJlbWVu'
    'dF9pbmZvGAIgASgLMiYubW90aWNvbl9pbnNvbGUzLnByb3RvLk1lYXN1cmVtZW50SW5mb1IPbW'
    'Vhc3VyZW1lbnRJbmZv');

@$core.Deprecated('Use insoleStopServiceDescriptor instead')
const InsoleStopService$json = {
  '1': 'InsoleStopService',
  '2': [
    {'1': 'service_counter', '3': 1, '4': 1, '5': 13, '10': 'serviceCounter'},
  ],
};

/// Descriptor for `InsoleStopService`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insoleStopServiceDescriptor = $convert.base64Decode(
    'ChFJbnNvbGVTdG9wU2VydmljZRInCg9zZXJ2aWNlX2NvdW50ZXIYASABKA1SDnNlcnZpY2VDb3'
    'VudGVy');

@$core.Deprecated('Use insoleStopServiceConfDescriptor instead')
const InsoleStopServiceConf$json = {
  '1': 'InsoleStopServiceConf',
  '2': [
    {
      '1': 'error',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.moticon_insole3.proto.Error',
      '10': 'error'
    },
  ],
};

/// Descriptor for `InsoleStopServiceConf`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insoleStopServiceConfDescriptor = $convert.base64Decode(
    'ChVJbnNvbGVTdG9wU2VydmljZUNvbmYSMgoFZXJyb3IYASABKAsyHC5tb3RpY29uX2luc29sZT'
    'MucHJvdG8uRXJyb3JSBWVycm9y');
