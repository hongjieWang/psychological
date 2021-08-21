import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/component/page/mine/setup/setup_controller.dart';
import 'package:standard_app/component/page/mine/setup/setup_state.dart';
import 'package:standard_app/util/toasts.dart';

///修改用户名
class SetupNamePage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final SetupState state = Get.find<SetupController>().state;
  final SetupController logic = Get.put(SetupController());

  @override
  Widget build(BuildContext context) {
    controller.text = state.name.value;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '设置名称',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          leading: Builder(builder: (context) {
            return IconButton(
                icon: Icon(Icons.close, color: Colors.black), //自定义图标
                iconSize: 20,
                onPressed: () {
                  Get.back();
                });
          }),
          actions: <Widget>[
            //导航栏右侧菜单
            TextButton(
                onPressed: () {
                  _onClickNameSuccess();
                },
                child: Text(
                  "确定",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                  ),
                ),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ))
          ]),
      body: _body(),
    );
  }

  ///设置名称
  _body() {
    return Container(child: _row());
  }

  ///点击用户名称修改按钮
  _onClickNameSuccess() {
    if (controller.text == "") {
      Toasts.show("用户名称不能为空");
    } else {
      ApiService()
          .uploadName(controller.text)
          .then((value) => {state.name.value = controller.text, Get.back()});
    }
  }

  Widget _row() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.sp, 20.sp, 20.sp, 0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "请输入用户名",
                prefixIcon: Icon(Icons.person)),
          )),
          InkWell(
            onTap: () {
              controller.text = "";
            },
            child: Icon(
              Icons.cancel,
              color: Colors.black26,
            ),
          )
        ],
      ),
    );
  }
}
