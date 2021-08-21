import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pickers/address_picker/locations_data.dart';
import 'package:flutter_pickers/more_pickers/init_data.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/component/common/alert_dialog.dart';
import 'package:standard_app/component/common/crop_image_route.dart';
import 'package:standard_app/component/page/mine/setup/setup_controller.dart';
import 'package:standard_app/component/page/mine/setup/setup_state.dart';
import 'package:standard_app/util/dialog.dart';
import 'package:standard_app/util/style.dart';

///个人中心设置页面
class SetupPage extends StatelessWidget {
  final SetupController logic = Get.put(SetupController());
  final SetupState state = Get.find<SetupController>().state;

  @override
  Widget build(BuildContext context) {
    state.context = context;
    return Scaffold(
      appBar: StyleUtils.buildAppBar("个人信息"),
      body: _body(),
    );
  }

  /// 个人设置
  Widget _body() {
    return Container(
        child: Obx(
      () => SingleChildScrollView(
        child: Flex(
          direction: Axis.vertical,
          children: [
            _avatar(),
            _divider(),
            renderCard([
              renderItem("用户名",
                  child: Text(
                    state.name.value,
                    style: TextStyle(color: Color(0xff999999), fontSize: 12),
                  ),
                  func: logic.changeName),
              renderItem("手机号",
                  child: Text(
                    state.phone.value,
                    style: TextStyle(color: Color(0xff999999), fontSize: 12),
                  )),
            ]),
            _divider(),
            renderCard([
              renderItem("性别",
                  child: Text(
                    state.sex.value,
                    style: TextStyle(color: Color(0xff999999), fontSize: 12),
                  ),
                  func: _checkSex),
              renderItem("生日",
                  child: Text(
                    state.birthdayStr.isNotEmpty
                        ? state.birthdayStr.value
                        : "设置",
                    style: TextStyle(color: Color(0xff999999), fontSize: 12),
                  ),
                  func: _birthday),
              renderItem("所在地",
                  child: Text(
                    _showAddress(),
                    style: TextStyle(color: Color(0xff999999), fontSize: 12),
                  ),
                  func: _checkLocation),
            ]),
            _divider(),
            renderCard([
              renderItem("职业",
                  child: Text(
                    state.professional.value == null
                        ? "请选择职业"
                        : state.professional.value,
                    style: TextStyle(color: Color(0xff999999), fontSize: 12),
                  ),
                  func: _checkProfessional),
              renderItem("微信",
                  child: Text(
                    "已绑定",
                    style: TextStyle(color: Color(0xff999999), fontSize: 12),
                  )),
            ]),
            SizedBox(
              height: 10,
            ),
            // renderCard([renderItem("关于")]),
            Container(
              height: 55,
              color: Colors.white,
              width: double.maxFinite,
              child: InkWell(
                  onTap: () => {
                        popDialog(
                            Get.context,
                            ShowAlertDialog(
                              items: ['取消', '确认'],
                              title: '提示',
                              content: '确认要退出登录吗？',
                              onTap: (index) {
                                if (index == 1) {
                                  logic.exit();
                                }
                              },
                            ))
                      },
                  child: Center(
                    child: Text(
                      "退出登录",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Center(
                  child: Text("706在线心理咨询平台",
                      style:
                          TextStyle(color: Color(0xff999999), fontSize: 14))),
            )
          ],
        ),
      ),
    ));
  }

  ///生日选择器
  _birthday() {
    Pickers.showDatePicker(
      state.context,
      onConfirm: (p) {
        ApiService().uploadBirthday("${p.year}-${p.month}-${p.day}").then(
            (value) =>
                state.birthdayStr.value = "${p.year}-${p.month}-${p.day}");
      },
    );
  }

  ///职业选择
  _checkProfessional() {
    Pickers.showSinglePicker(state.context,
        data: AppConstant.professional,
        selectData: state.professional.value,
        pickerStyle: DefaultPickerStyle(), onConfirm: (p, y) {
      ApiService()
          .uploadProfessional(p)
          .then((value) => state.professional.value = p);
    });
  }

  ///性别选择
  _checkSex() {
    Pickers.showSinglePicker(state.context,
        data: AppConstant.sex,
        selectData: state.sex.value,
        pickerStyle: DefaultPickerStyle(), onConfirm: (p, y) {
      ApiService().uploadSex("$y").then((value) => state.sex.value = p);
    });
  }

  ///格式化地区数据
  String _showAddress() {
    if (state.initProvince.value == "") return "未选择";
    return "${state.initProvince.value}-${state.initCity.value}";
  }

  ///点击选择城市
  _checkLocation() {
    Pickers.showAddressPicker(
      state.context,
      initProvince: state.initProvince.value,
      initCity: state.initCity.value,
      onConfirm: (p, c, t) {
        List code = Address.getCityCodeByName(provinceName: p, cityName: c);
        String pCode = code[0];
        String cCode;
        if (code.length >= 2) {
          cCode = code[1];
        }
        ApiService().uploadLocation(pCode, cCode).then((value) =>
            {state.initProvince.value = p, state.initCity.value = c});
      },
    );
  }

  ///头像
  Widget _avatar() {
    return Container(
      padding: EdgeInsets.fromLTRB(30.sp, 40.sp, 30.sp, 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _title("头像"),
          InkWell(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(50.sp)),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  state.avatar.value != null
                      ? state.avatar.value
                      : "http://pub.julywhj.cn/%E5%A4%B4%E5%83%8F.jpeg",
                  width: 100.r,
                  height: 100.r,
                )),
            onTap: () {
              chooseImage();
            },
          ),
        ],
      ),
    );
  }

  ///从相册选取
  Future chooseImage() async {
    // 实例化
    await ImagePicker()
        .getImage(source: ImageSource.gallery)
        .then((image) => cropImage(File(image.path)));
  }

  void cropImage(File originalImage) async {
    String result = await Navigator.push(Get.context,
        MaterialPageRoute(builder: (context) => CropImageRoute(originalImage)));
    if (result.isEmpty) {
    } else {
      ApiService()
          .uploadAvatar(result)
          .then((value) => state.avatar.value = result);
    }
  }

  ///数值
  Widget _value(value) {
    return Padding(
        padding: EdgeInsets.only(left: 40.sp),
        child: Container(
          width: 0.6.sw,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(color: Colors.black38, fontSize: 12),
          ),
        ));
  }

  Widget _title(value) {
    return Text(
      value,
      style: TextStyle(fontSize: 30.sp),
    );
  }

  Widget renderItem(String title, {Widget child, Function func}) {
    List<Widget> list = [
      Text(
        title,
        style: TextStyle(color: Color(0xff333333)),
      ),
      child != null ? child : Container()
    ];

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        child: InkWell(
          onTap: () {
            if (func != null) {
              func();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: list.toList(),
          ),
        ));
  }

  ///分隔线
  Widget _divider() {
    return SizedBox(
      height: 10,
    );
  }

  /// 点击手机号
  void phone() {
    print("点击手机号");
  }

  Widget renderCard(List widgets) {
    List<Widget> list = [];

    for (int i = 0; i < widgets.length; i++) {
      list
        ..add(widgets[i])
        ..add(Divider(
          height: 1,
        ));
    }

    return Container(
        color: Colors.white,
        child: Column(
          children: list.toList(),
        ));
  }
}
