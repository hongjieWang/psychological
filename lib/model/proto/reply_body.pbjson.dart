///
//  Generated code. Do not modify.
//  source: reply_body.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use replyBodyProtoDescriptor instead')
const ReplyBodyProto$json = const {
  '1': 'ReplyBodyProto',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'timestamp', '3': 4, '4': 1, '5': 3, '10': 'timestamp'},
    const {'1': 'data', '3': 5, '4': 3, '5': 11, '6': '.socket.model.proto.ReplyBodyProto.DataEntry', '10': 'data'},
  ],
  '3': const [ReplyBodyProto_DataEntry$json],
};

@$core.Deprecated('Use replyBodyProtoDescriptor instead')
const ReplyBodyProto_DataEntry$json = const {
  '1': 'DataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `ReplyBodyProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List replyBodyProtoDescriptor = $convert.base64Decode('Cg5SZXBseUJvZHlQcm90bxIQCgNrZXkYASABKAlSA2tleRISCgRjb2RlGAIgASgJUgRjb2RlEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2USHAoJdGltZXN0YW1wGAQgASgDUgl0aW1lc3RhbXASQAoEZGF0YRgFIAMoCzIsLnNvY2tldC5tb2RlbC5wcm90by5SZXBseUJvZHlQcm90by5EYXRhRW50cnlSBGRhdGEaNwoJRGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use sentBodyProtoDescriptor instead')
const SentBodyProto$json = const {
  '1': 'SentBodyProto',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'timestamp', '3': 2, '4': 1, '5': 3, '10': 'timestamp'},
    const {'1': 'data', '3': 3, '4': 3, '5': 11, '6': '.socket.model.proto.SentBodyProto.DataEntry', '10': 'data'},
  ],
  '3': const [SentBodyProto_DataEntry$json],
};

@$core.Deprecated('Use sentBodyProtoDescriptor instead')
const SentBodyProto_DataEntry$json = const {
  '1': 'DataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `SentBodyProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sentBodyProtoDescriptor = $convert.base64Decode('Cg1TZW50Qm9keVByb3RvEhAKA2tleRgBIAEoCVIDa2V5EhwKCXRpbWVzdGFtcBgCIAEoA1IJdGltZXN0YW1wEj8KBGRhdGEYAyADKAsyKy5zb2NrZXQubW9kZWwucHJvdG8uU2VudEJvZHlQcm90by5EYXRhRW50cnlSBGRhdGEaNwoJRGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
