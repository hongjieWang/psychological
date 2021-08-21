import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/page/consult/feedback/feedback_controller.dart';
import 'package:standard_app/component/page/consult/feedback/feedback_state.dart';
import 'package:standard_app/util/Toasts.dart';
import 'package:standard_app/util/style.dart';

class FeedBackDetailPage extends StatefulWidget {
  FeedBackDetailPage({Key key}) : super(key: key);

  @override
  _FeedBackDetailPageState createState() => _FeedBackDetailPageState();
}

class _FeedBackDetailPageState extends State<FeedBackDetailPage> {
  final FeedBackController logic = Get.put(FeedBackController());
  final FeedBackState state = Get.find<FeedBackController>().state;
  final TextEditingController _controller = new TextEditingController();
  Map _item = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: StyleUtils.buildAppBar("意见反馈说明", icon: Icons.arrow_back_ios),
      body: _body(),
    );
  }

  ///意见反馈
  Widget _body() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 0.01.sh,
            ),
            _context(),
            _submit(),
            _agreement()
          ],
        ),
      ),
    );
  }

  ///投诉原因
  Widget _feedback() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      height: 126.sp,
      padding: EdgeInsets.fromLTRB(32.sp, 0.sp, 32.sp, 10.sp),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.zero,
            child: Text(
              '反馈原因',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: StyleUtils.fontColor_3,
                  fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.sp, top: 4.sp),
            child: Text(_item['feedbackTypeName'],
                style: StyleUtils.textStyle(
                    15.0, StyleUtils.fontColor_6, FontWeight.w400)),
          ),
        ],
      ),
    );
  }

  ///补充说明
  Widget _footnote() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30.sp, 10.sp, 32.sp, 10.sp),
            child: Card(
                color: Colors.grey[80],
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "具体情况说明",
                        style: StyleUtils.textStyle(
                            28.sp, StyleUtils.fontColor_3, FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      TextField(
                        controller: _controller,
                        maxLines: 13,
                        maxLength: 255,
                        decoration: InputDecoration.collapsed(
                            hintText: "必填，补充详细的说明，可帮助工作人员更快定位问题，快速处理",
                            hintStyle: StyleUtils.textStyle(22.sp,
                                StyleUtils.fontColor_9, FontWeight.normal)),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _context() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _feedback(),
        _footnote(),
      ],
    );
  }

  ///提交按钮
  Widget _submit() {
    return Padding(
        padding: EdgeInsets.only(top: 40.sp),
        child: TextButton(
          onPressed: () {
            _onClickSubmit();
          },
          child: Text(
            '提交',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                //设置按下时的背景颜色
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue[200];
                }
                //默认不使用背景颜色
                return Colors.blue;
              }),
              //设置按钮内边距
              padding: MaterialStateProperty.all(EdgeInsets.all(14.sp)),
              shape: MaterialStateProperty.all(StadiumBorder()),
              minimumSize: MaterialStateProperty.all(Size(686.sp, 68.sp))),
        ));
  }

  Widget _agreement() {
    return Container(
      padding: EdgeInsets.only(top: 30.sp),
      width: 700.sp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.sp,
          ),
          Text(
            '1.平台可调取与你提交信息相关的记录进行核实',
            style: StyleUtils.textStyle(
                20.sp, StyleUtils.fontColor_9, FontWeight.normal),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Text(
            '2.承担因虚假投诉/举报所造成的一切后果',
            style: StyleUtils.textStyle(
                20.sp, StyleUtils.fontColor_9, FontWeight.normal),
          )
        ],
      ),
    );
  }

  ///点击用户协议
  _onClickUserAgreement() {
    print('点击了用户协议');
  }

  ///用户隐私保护政策
  _onClickPersonalInformationProtectionPolicy() {
    print('点击了个人隐私保护政策');
  }

  ///点击提交按钮
  _onClickSubmit() {
    Map data = {
      "feedbackTypeId": _item['feedbackTypeId'],
      "membersId": Global.getUserId(),
      "crId": state.feedObj['crId'],
      "feedbackContent": _controller.text,
      "phone": Global.getPhone()
    };
    if (_check()) {
      ApiService()
          .addFeedback(data)
          .then((value) => {Toasts.show("意见反馈成功"), Get.back()});
    }
  }

  ///提交数据检查
  bool _check() {
    if (_item['feedbackTypeId'] == null || _item['feedbackTypeId'] == '') {
      Toasts.show("反馈类型不能为空");
      return false;
    }
    if (_controller.text == "") {
      Toasts.show("详细的说明，能让我更好的帮助到你");
      return false;
    }
    return true;
  }
}
