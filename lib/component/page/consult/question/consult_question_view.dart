import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/component/common/data_statistics.dart';
import 'package:standard_app/component/page/consult/appointment/appointment_controller.dart';
import 'package:standard_app/component/page/consult/appointment/appointment_state.dart';
import 'package:standard_app/util/Toasts.dart';
import 'package:standard_app/util/standard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/util/style.dart';

//咨询问题
class ConsultQuestionView extends StatefulWidget {
  @override
  _ConsultQuestionViewState createState() => _ConsultQuestionViewState();
}

class _ConsultQuestionViewState extends State<ConsultQuestionView> {
  final AppointmentController logic = Get.put(AppointmentController());
  final AppointmentState state = Get.find<AppointmentController>().state;

  int maxSelectSize = 3;

  @override
  void initState() {
    super.initState();
    ApiService()
        .getLabelsService()
        .then((value) => {state.labelData.value = value['data']['goodWays']});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("咨询描述",
          icon: Icons.arrow_back_ios,
          openAction: true,
          content: "内容将不会被保存，确定返回吗？",
          items: ['取消', '确认离开']),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
        child: Container(
      color: StyleUtils.bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title('问题类型'),
                  _lables(),
                  _title('问题描述'),
                  _content(),
                  _privacy(),
                ],
              )),
          UIUtils.submitBtn('保存', logic.problemDescriptionSubmit)
        ],
      ),
    ));
  }

  ///问题类型标签
  Widget _lables() {
    return Container(
      padding: EdgeInsets.fromLTRB(30.sp, 10.sp, 30.sp, 0),
      child: Wrap(
        spacing: 10.0.sp, // 主轴(水平)方向间距
        runSpacing: -20.0.sp, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.start, //沿主轴方向居中
        children: getLabels(),
      ),
    );
  }

  List<Widget> getLabels() {
    List<Widget> list = [];
    state.labelData.forEach((element) {
      list.add(_item(
          "${element['counselorLabelId']}", element['counselorLabelName']));
    });
    return list;
  }

  Widget _item(String key, String value) {
    return TextButton(
      onPressed: () {
        if (state.problemType.contains(key)) {
          state.problemType.remove(key);
        } else {
          if (state.problemType.length < maxSelectSize) {
            state.problemType.add(key);
          } else {
            Toasts.show("最多只能选择$maxSelectSize个标签");
          }
        }
        ;
      },
      child: Text(
        value,
        style: TextStyle(
            fontSize: 24.sp,
            color: state.problemType.contains(key)
                ? Colors.white
                : StyleUtils.fontColor_3),
      ),
      style: ButtonStyle(
        //背景颜色
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //设置按下时的背景颜色
          if (states.contains(MaterialState.pressed)) {
            return Colors.blue[200];
          }
          //默认不使用背景颜色
          return state.problemType.contains(key)
              ? Colors.blue
              : Color(0xFFE2E2E2);
        }),
        //设置按钮的大小
        minimumSize: MaterialStateProperty.all(Size(158.sp, 42.sp)),
        padding: MaterialStateProperty.all(EdgeInsets.all(6.sp)),
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
    );
  }

  ///问题描述信息
  Widget _content() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.sp, 0, 20.sp, 0),
      child: Card(
          color: Colors.grey[80],
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 10,
              maxLength: 200,
              onChanged: (value) {
                state.problemDescription.value = value;
              },
              decoration: InputDecoration.collapsed(
                  hintText: "简述您需要咨询的问题，便于您更好的咨询沟通。",
                  hintStyle: TextStyle(
                      color: StyleUtils.fontColor_6, fontSize: 20.sp)),
            ),
          )),
    );
  }

  ///标题
  Widget _title(value) {
    return Padding(
        padding: EdgeInsets.fromLTRB(40.sp, 50.sp, 0, 10.sp),
        child: Text(
          value,
          style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w500,
              color: StyleUtils.fontColor_3),
        ));
  }

  ///隐私说明
  Widget _privacy() {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.sp, 10.sp, 30.sp, 40.sp),
      child: Text(
        '隐私保护：平台会全方位保护您的信息安全，您填写的所有信息将受到安全保护',
        style: TextStyle(color: StyleUtils.fontColor_9, fontSize: 20.sp),
      ),
    );
  }

  ///确认离开
  _onBack() {
    Get.back();
    Get.back();
  }
}
