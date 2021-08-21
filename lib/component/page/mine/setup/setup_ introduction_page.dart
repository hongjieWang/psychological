import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/component/page/mine/setup/setup_controller.dart';
import 'package:standard_app/component/page/mine/setup/setup_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/util/toasts.dart';

///个人简介
class SetupIntroductionPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final SetupState state = Get.find<SetupController>().state;
  final SetupController logic = Get.put(SetupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("个人简介"),
          actions: <Widget>[
            //导航栏右侧菜单
            TextButton(
                onPressed: () {
                  _onClickIntroductionSuccess();
                },
                child: Text(
                  "确定",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w400),
                ))
          ],
        ),
        body: _body());
  }

  ///编辑个人简介
  Widget _body() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.sp, 30.sp, 20.sp, 0.sp),
      child: TextField(
        autofocus: true,
        controller: controller,
        maxLines: 10,
        maxLength: 255,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "介绍一下自己",
        ),
      ),
    );
  }

  ///点击用户名称修改按钮
  _onClickIntroductionSuccess() {
    if (controller.text == "") {
      Toasts.show("简介称不能为空");
    } else {
      ApiService().uploadSignature(controller.text).then((value) => {
            state.introduction.value = controller.text,
            Get.back(),
          });
    }
  }
}
