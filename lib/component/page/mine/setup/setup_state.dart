import 'package:flutter/material.dart';
import 'package:get/get.dart';

///个人中心设置数据驱动类
class SetupState {
  RxString initProvince, initCity, initTown;
  BuildContext context;
  RxString sex;
  RxString birthdayStr;
  RxString name;
  RxString introduction;
  RxString phone;
  RxString avatar;
  RxString professional;

  SetupState() {
    initProvince = "".obs;
    initCity = "".obs;
    initTown = null;
    sex = "不限".obs;
    birthdayStr = "".obs;
    name = "去登录".obs;
    introduction = "".obs;
    phone = "".obs;
    avatar = "".obs;
    professional = "".obs;
  }
}
