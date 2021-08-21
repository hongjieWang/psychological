///
//  Generated code. Do not modify.
//  source: session.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class SessionProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SessionProto', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'socket.model.proto'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'account')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nid')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId', protoName: 'deviceId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'host')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceModel', protoName: 'deviceModel')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'clientVersion', protoName: 'clientVersion')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'systemVersion', protoName: 'systemVersion')
    ..aInt64(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bindTime', protoName: 'bindTime')
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'longitude', $pb.PbFieldType.OD)
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'latitude', $pb.PbFieldType.OD)
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'location')
    ..a<$core.int>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'apns', $pb.PbFieldType.O3)
    ..a<$core.int>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SessionProto._() : super();
  factory SessionProto({
    $fixnum.Int64? id,
    $core.String? account,
    $core.String? nid,
    $core.String? deviceId,
    $core.String? host,
    $core.String? channel,
    $core.String? deviceModel,
    $core.String? clientVersion,
    $core.String? systemVersion,
    $fixnum.Int64? bindTime,
    $core.double? longitude,
    $core.double? latitude,
    $core.String? location,
    $core.int? apns,
    $core.int? state,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (account != null) {
      _result.account = account;
    }
    if (nid != null) {
      _result.nid = nid;
    }
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    if (host != null) {
      _result.host = host;
    }
    if (channel != null) {
      _result.channel = channel;
    }
    if (deviceModel != null) {
      _result.deviceModel = deviceModel;
    }
    if (clientVersion != null) {
      _result.clientVersion = clientVersion;
    }
    if (systemVersion != null) {
      _result.systemVersion = systemVersion;
    }
    if (bindTime != null) {
      _result.bindTime = bindTime;
    }
    if (longitude != null) {
      _result.longitude = longitude;
    }
    if (latitude != null) {
      _result.latitude = latitude;
    }
    if (location != null) {
      _result.location = location;
    }
    if (apns != null) {
      _result.apns = apns;
    }
    if (state != null) {
      _result.state = state;
    }
    return _result;
  }
  factory SessionProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SessionProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SessionProto clone() => SessionProto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SessionProto copyWith(void Function(SessionProto) updates) => super.copyWith((message) => updates(message as SessionProto)) as SessionProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SessionProto create() => SessionProto._();
  SessionProto createEmptyInstance() => create();
  static $pb.PbList<SessionProto> createRepeated() => $pb.PbList<SessionProto>();
  @$core.pragma('dart2js:noInline')
  static SessionProto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SessionProto>(create);
  static SessionProto? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get account => $_getSZ(1);
  @$pb.TagNumber(2)
  set account($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get nid => $_getSZ(2);
  @$pb.TagNumber(3)
  set nid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNid() => $_has(2);
  @$pb.TagNumber(3)
  void clearNid() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get deviceId => $_getSZ(3);
  @$pb.TagNumber(4)
  set deviceId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDeviceId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get host => $_getSZ(4);
  @$pb.TagNumber(5)
  set host($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHost() => $_has(4);
  @$pb.TagNumber(5)
  void clearHost() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get channel => $_getSZ(5);
  @$pb.TagNumber(6)
  set channel($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasChannel() => $_has(5);
  @$pb.TagNumber(6)
  void clearChannel() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get deviceModel => $_getSZ(6);
  @$pb.TagNumber(7)
  set deviceModel($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDeviceModel() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeviceModel() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get clientVersion => $_getSZ(7);
  @$pb.TagNumber(8)
  set clientVersion($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasClientVersion() => $_has(7);
  @$pb.TagNumber(8)
  void clearClientVersion() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get systemVersion => $_getSZ(8);
  @$pb.TagNumber(9)
  set systemVersion($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSystemVersion() => $_has(8);
  @$pb.TagNumber(9)
  void clearSystemVersion() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get bindTime => $_getI64(9);
  @$pb.TagNumber(10)
  set bindTime($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasBindTime() => $_has(9);
  @$pb.TagNumber(10)
  void clearBindTime() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get longitude => $_getN(10);
  @$pb.TagNumber(11)
  set longitude($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasLongitude() => $_has(10);
  @$pb.TagNumber(11)
  void clearLongitude() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get latitude => $_getN(11);
  @$pb.TagNumber(12)
  set latitude($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasLatitude() => $_has(11);
  @$pb.TagNumber(12)
  void clearLatitude() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get location => $_getSZ(12);
  @$pb.TagNumber(13)
  set location($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasLocation() => $_has(12);
  @$pb.TagNumber(13)
  void clearLocation() => clearField(13);

  @$pb.TagNumber(14)
  $core.int get apns => $_getIZ(13);
  @$pb.TagNumber(14)
  set apns($core.int v) { $_setSignedInt32(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasApns() => $_has(13);
  @$pb.TagNumber(14)
  void clearApns() => clearField(14);

  @$pb.TagNumber(15)
  $core.int get state => $_getIZ(14);
  @$pb.TagNumber(15)
  set state($core.int v) { $_setSignedInt32(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasState() => $_has(14);
  @$pb.TagNumber(15)
  void clearState() => clearField(15);
}

