import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/page/mine/setup/setup_state.dart';
import 'package:standard_app/routes/routes.dart';

///个人中心设置控制器
class SetupController extends GetxController {
  SetupState state = SetupState();

  ///跳转修改用户名称
  changeName() {
    Get.toNamed(RouteConfig.setupNamePage);
  }

  ///跳转到修改简介
  setupIntroductionPage() {
    Get.toNamed(RouteConfig.setupIntroductionPage);
  }

  ///取消退出登录
  onCanel() {
    Get.back();
  }

  ///退出登录
  exit() {
    Global.setToken("null");
    Global.setUserId("null");
    Get.offAllNamed(RouteConfig.main);
  }
}
