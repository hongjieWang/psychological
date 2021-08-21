import 'package:umeng_common_sdk/umeng_common_sdk.dart';

class DataStatistics {
  DataStatistics._privateConstructor();

  static final DataStatistics _instance = DataStatistics._privateConstructor();
  static bool isOpenManual = false;
  static DataStatistics get instance {
    if (!isOpenManual) {
      _instance.setPageCollectionModeManual();
    }
    return _instance;
  }

  ///事件消息
  void event(String key, Map<String, dynamic> value) {
    UmengCommonSdk.onEvent(key, value);
  }

  /// 登录用户
  void setUserId(String userId) {
    UmengCommonSdk.onProfileSignIn(userId);
  }

  ///注销用户
  void onProfileSignOff() {
    UmengCommonSdk.onProfileSignOff();
  }

  ///如果需要使用页面统计，则先打开该设置
  void setPageCollectionModeManual() {
    isOpenManual = true;
    UmengCommonSdk.setPageCollectionModeManual();
  }

  ///如果不需要上述页面统计，在完成后可关闭该设置；如果没有用该功能可忽略；
  void setPageCollectionModeAuto() {
    UmengCommonSdk.setPageCollectionModeAuto();
  }

  ///进入页面统计
  void onPageStart(String page) {
    UmengCommonSdk.onPageStart(page);
  }

  /// 离开页面统计
  void onPageEnd(String page) {
    UmengCommonSdk.onPageEnd(page);
  }

  ///发送错误数据
  void reportError(String msg) {
    UmengCommonSdk.reportError(msg);
  }
}
