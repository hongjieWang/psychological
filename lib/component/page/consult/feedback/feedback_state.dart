import 'package:get/get.dart';

class FeedBackState {
  //反馈类型列表
  RxList feeds;
  //反馈对象
  RxMap feedObj;

  RxString btnName;
  //签到按钮
  RxString signBtnName;

  ///是否显示签到按钮
  RxBool showSignIn;

  ///取消按钮控制
  RxBool showCancelBtn;

  /// 评价按钮控制
  RxBool showEvaluateBtn;

  FeedBackState() {
    feeds = [].obs;
    feedObj = {}.obs;
    btnName = "".obs;
    showSignIn = false.obs;
    showCancelBtn = false.obs;
    showEvaluateBtn = false.obs;
    signBtnName = "签到".obs;
  }
}
