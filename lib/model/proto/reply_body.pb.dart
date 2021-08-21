///
//  Generated code. Do not modify.
//  source: reply_body.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class ReplyBodyProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReplyBodyProto', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'socket.model.proto'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..m<$core.String, $core.String>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', entryClassName: 'ReplyBodyProto.DataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('socket.model.proto'))
    ..hasRequiredFields = false
  ;

  ReplyBodyProto._() : super();
  factory ReplyBodyProto({
    $core.String? key,
    $core.String? code,
    $core.String? message,
    $fixnum.Int64? timestamp,
    $core.Map<$core.String, $core.String>? data,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (code != null) {
      _result.code = code;
    }
    if (message != null) {
      _result.message = message;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (data != null) {
      _result.data.addAll(data);
    }
    return _result;
  }
  factory ReplyBodyProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReplyBodyProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReplyBodyProto clone() => ReplyBodyProto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReplyBodyProto copyWith(void Function(ReplyBodyProto) updates) => super.copyWith((message) => updates(message as ReplyBodyProto)) as ReplyBodyProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReplyBodyProto create() => ReplyBodyProto._();
  ReplyBodyProto createEmptyInstance() => create();
  static $pb.PbList<ReplyBodyProto> createRepeated() => $pb.PbList<ReplyBodyProto>();
  @$core.pragma('dart2js:noInline')
  static ReplyBodyProto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReplyBodyProto>(create);
  static ReplyBodyProto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get timestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set timestamp($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => clearField(4);

  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.String> get data => $_getMap(4);
}

class SentBodyProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SentBodyProto', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'socket.model.proto'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..m<$core.String, $core.String>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', entryClassName: 'SentBodyProto.DataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('socket.model.proto'))
    ..hasRequiredFields = false
  ;

  SentBodyProto._() : super();
  factory SentBodyProto({
    $core.String? key,
    $fixnum.Int64? timestamp,
    $core.Map<$core.String, $core.String>? data,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (data != null) {
      _result.data.addAll(data);
    }
    return _result;
  }
  factory SentBodyProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SentBodyProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SentBodyProto clone() => SentBodyProto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SentBodyProto copyWith(void Function(SentBodyProto) updates) => super.copyWith((message) => updates(message as SentBodyProto)) as SentBodyProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SentBodyProto create() => SentBodyProto._();
  SentBodyProto createEmptyInstance() => create();
  static $pb.PbList<SentBodyProto> createRepeated() => $pb.PbList<SentBodyProto>();
  @$core.pragma('dart2js:noInline')
  static SentBodyProto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SentBodyProto>(create);
  static SentBodyProto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get timestamp => $_getI64(1);
  @$pb.TagNumber(2)
  set timestamp($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestamp() => clearField(2);

  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get data => $_getMap(2);
}

