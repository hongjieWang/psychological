import 'dart:io';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';

class Global {
  static SharedPreferences _prefs;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static bool isLogin = true;

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    initPlatformState();
  }

  ///获取平台信息
  static String getPlatform() {
    String platform;
    if (Platform.isAndroid) {
      platform = "android";
    } else if (Platform.isIOS) {
      platform = "ios";
    } else if (Platform.isLinux) {
      platform = "linux";
    } else if (Platform.isMacOS) {
      platform = "macos";
    }
    return platform;
  }

  /// 获取设备唯一ID
  static getDeviceId() {
    return getString("deviceId");
  }

  ///获取上个页面
  static getPage() {
    return getString("page");
  }

  ///设置页面
  static setPage(String page) {
    return setString("page", page);
  }

  ///初始化设备信息
  static Future<Map<String, dynamic>> initPlatformState() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};
    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    setString("deviceId", deviceData['deviceId']);
    return deviceData;
  }

  static Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
      "deviceId": build.androidId
    };
  }

  static Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
      "deviceId": data.identifierForVendor
    };
  }

  ///设置缓存数据
  static setString(String key, String value) {
    _prefs.setString(key, value);
  }

  /// 获取存储数据
  static getString(String key) {
    return _prefs.getString(key);
  }

  /// 删除存储数据
  static del(String key) {
    _prefs.remove(key);
  }

  ///设置用户登录token
  static setToken(String token) {
    _prefs.setString("token", token);
  }

  /// 获取token
  static getToken() {
    return _prefs.getString("token");
  }

  ///清除用户token
  static delToken() {
    _prefs.remove("token");
  }

  ///设置当前登录用户ID
  static setUserId(String userId) {
    _prefs.setString("userId", userId);
  }

  static setPhone(String phone) {
    _prefs.setString("phone", phone);
  }

  ///设置咨询师ID
  static setCounselorId(String counselorId) {
    _prefs.setString("counselorId", counselorId);
  }

  ///获取咨询师ID
  static getCounselorId() {
    return _prefs.getString("counselorId") == null
        ? '0'
        : _prefs.getString("counselorId");
  }

  ///获取登录用户ID
  static getUserId() {
    return _prefs.getString("userId") == null
        ? '0'
        : _prefs.getString("userId");
  }

  static getPhone() {
    return _prefs.getString("phone");
  }

  ///清除用户ID
  static delUserId() {
    _prefs.remove("userId");
  }

  ///设置当前登录用户姓名
  static setUserName(String userName) {
    _prefs.setString("userName", userName);
  }

  ///获取登录用户姓名
  static getUserName() {
    return _prefs.getString("userName");
  }

  ///清除用户姓名
  static delUserName() {
    _prefs.remove("userName");
  }
}
