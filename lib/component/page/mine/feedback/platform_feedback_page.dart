import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/page/mine/feedback/platform_feedback_controller.dart';
import 'package:standard_app/component/page/mine/feedback/platform_feedback_state.dart';
import 'package:standard_app/util/Toasts.dart';
import 'package:standard_app/util/style.dart';

///意见反馈-个人中心入口
class PlatformFeedbackPage extends StatelessWidget {
  final PlatformFeedbackController logic =
      Get.put(PlatformFeedbackController());
  final PlatformFeedbackState state =
      Get.find<PlatformFeedbackController>().state;

  TextEditingController contentController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("意见反馈"),
      body: _body(),
    );
  }

  ///意见反馈内容
  Widget _body() {
    return Container(
        decoration: BoxDecoration(color: StyleUtils.bgColor),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 22.sp,
              ),
              _drawback(),
              _application(),
              _phone(),
              SizedBox(
                height: 60.sp,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 40.sp),
                  child: TextButton(
                    onPressed: () {
                      submit();
                    },
                    child: Text(
                      "提  交",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      //设置边框
                      //外边框装饰 会覆盖 side 配置的样式
                      // shape: MaterialStateProperty.all(StadiumBorder()),
                      minimumSize:
                          MaterialStateProperty.all(Size(686.sp, 68.sp)),
                      shape: MaterialStateProperty.all(StadiumBorder()),
                      padding: MaterialStateProperty.all(EdgeInsets.all(7)),
                      //背景颜色
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        //设置按下时的背景颜色
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.blue[200];
                        }
                        //默认不使用背景颜色
                        return Colors.blue;
                      }),
                    ),
                  ))
            ],
          ),
        ));
  }

  ///申请说明
  Widget _application() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(32.sp, 20.sp, 32.sp, 20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular((10.0.sp))),
            padding: EdgeInsets.fromLTRB(20.sp, 20.sp, 20.sp, 40.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "申请说明",
                  style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333333)),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Card(
                    color: Colors.grey[80],
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: contentController,
                        maxLines: 10,
                        maxLength: 200,
                        decoration: InputDecoration.collapsed(
                            hintText: "必填，请详细填写申请说明~",
                            hintStyle: TextStyle(
                                color: Color(0xFF999999), fontSize: 22.sp)),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///联系电话
  Widget _phone() {
    return Container(
      width: double.infinity,
      height: 120.sp,
      margin: EdgeInsets.only(left: 32.sp, right: 32.sp),
      padding: EdgeInsets.only(left: 20.sp),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular((10.0.sp))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "联系方式",
            style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333)),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 20.sp),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "请输入手机号",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Color(0xFF999999), fontSize: 12)),
            ),
          ))
        ],
      ),
    );
  }

  /// 问题类型
  Widget _drawback() {
    return Container(
      width: double.infinity,
      height: 120.sp,
      margin: EdgeInsets.only(left: 32.sp, right: 32.sp),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular((10.0.sp))),
      child: InkWell(
        onTap: () {
          Get.bottomSheet(_pursueReason());
        },
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: EdgeInsets.only(left: 20.sp, right: 22.sp),
            child: Row(children: [
              Text(
                "问题类型",
                style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.sp, top: 4.sp),
                child: Obx(() => Text(
                      state.feedback['title'],
                      style: TextStyle(
                          color: StyleUtils.fontColor_3, fontSize: 14),
                    )),
              )
            ]),
          ),
          Icon(
            Icons.chevron_right,
            size: 20,
            color: Color(0xFF999999),
          ),
        ]),
      ),
    );
  }

  void submit() {
    if (contentController.text == "") {
      Toasts.show("详细的说明，能让我更好的帮助到你");
      return;
    }
    Map data = {
      "feedbackTypeId": state.feedback['id'],
      "membersId": Global.getUserId(),
      "crId": "0",
      "feedbackContent": contentController.text,
      "phone": phoneController.text
    };
    ApiService().addFeedback(data).then((value) => Get.back());
  }

  ///显示申请原因
  Widget _pursueReason() {
    return Container(
      height: 0.5.sh,
      width: 750.sp,
      decoration: new BoxDecoration(
        //背景
        color: Colors.white,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(25.0.sp)),
      ),
      child: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 30.sp, bottom: 10.sp),
              child: Text(
                "请选择申请原因",
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _item(),
          )
        ],
      )),
    );
  }

  ///申请原因列表
  List<Widget> _item() {
    List<Widget> list = [];
    state.feedbackList.forEach((element) {
      list.add(Divider());
      list.add(InkWell(
          onTap: () {
            state.feedback.value = element;
            Get.back();
          },
          child: Padding(
              padding: EdgeInsets.fromLTRB(30.sp, 10.sp, 0, 10.sp),
              child: Row(
                children: [
                  Text(
                    element['title'],
                    style: TextStyle(
                      fontSize: 30.sp,
                    ),
                  ),
                ],
              ))));
    });
    return list;
  }
}
