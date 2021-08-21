import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/common/cross_datetime.dart';
import 'package:standard_app/component/common/data_statistics.dart';
import 'package:standard_app/component/page/consult/appointment/appointment_controller.dart';
import 'package:standard_app/component/page/consult/appointment/appointment_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/standard.dart';
import 'package:standard_app/util/style.dart';
import 'package:standard_app/util/toasts.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final AppointmentController logic = Get.put(AppointmentController());
  final AppointmentState state = Get.find<AppointmentController>().state;
  final List selectedTime = [];
  final List times = [];
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    var map = Get.arguments;
    state.customerRelationship.value = map;
    logic.phoneController.text = Global.getPhone();
    state.title.value = map['counselorName'];
    times.addAll(map['data']);
    this.context = context;
    return Scaffold(
        appBar: StyleUtils.buildAppBar('${state.title}',
            icon: Icons.arrow_back_ios),
        body: _body());
  }

  /// 预约咨询师
  Widget _body() {
    return SingleChildScrollView(
        child: Container(
      width: double.infinity,
      decoration: BoxDecoration(color: StyleUtils.bgColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_time(), _consultInfor()],
      ),
    ));
  }

  ///咨询时间
  Widget _time() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(32.sp, 23.sp, 32.sp, 28.sp),
              child: Text(
                '咨询时间',
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(20.sp, 10.sp, 20.sp, 10.sp),
            child: CrossDateTime(
              dateList: times,
              onClickFun: _onClickTime,
              selected: selectedTime,
            ),
          )
        ],
      ),
    );
  }

  ///咨询信息
  Widget _consultInfor() {
    return Container(
      padding: EdgeInsets.fromLTRB(32.sp, 60.0.sp, 32.sp, 28.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '咨询信息',
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 28.sp,
              ),
              _formInfo(),
              _remark(),
            ],
          ),
          UIUtils.submitBtn('确认预约', logic.applyAnAppointment)
        ],
      ),
    );
  }

  ///咨询信息form表单
  Widget _formInfo() {
    return Container(
        decoration: new BoxDecoration(
          //背景
          color: Colors.white,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Form(
          child: Column(
            children: [_age(), _sex(), _phone(), Divider(), _problem()],
          ),
        ));
  }

  ///年龄
  Widget _age() {
    return InkWell(
        onTap: () {
          print(11);
          _clickSpec(context);
        },
        child: Padding(
            padding: EdgeInsets.fromLTRB(20.sp, 20.sp, 30.sp, 10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Padding(
                    padding: EdgeInsets.zero,
                    child: _formTitle('年        龄'),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 70.sp),
                      child: Obx(() => (Text(
                            '${state.age.value}',
                            style: TextStyle(
                                color: Color(0xFF666666), fontSize: 13),
                          )))),
                ]),
                UIUtils.lableIcon(
                    ' ', Icons.chevron_right_outlined, _clickSpec, this.context)
              ],
            )));
  }

  ///性别
  Widget _sex() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20.sp, 20.sp, 30.sp, 0.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.zero,
              child: _formTitle('性        别'),
            ),
            Padding(
                padding: EdgeInsets.only(left: 50.sp),
                child: Obx(() => Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: state.sex.value,
                          onChanged: (v) {
                            state.sex.value = v;
                          },
                        ),
                        Text("男"),
                      ],
                    ))),
            Padding(
                padding: EdgeInsets.only(left: 60.sp),
                child: Obx(() => Row(
                      children: [
                        Radio(
                            value: 2,
                            groupValue: state.sex.value,
                            onChanged: (v) {
                              state.sex.value = v;
                            }),
                        Text("女"),
                      ],
                    )))
          ],
        ));
  }

  ///联系电话
  Widget _phone() {
    return Container(
        padding: EdgeInsets.fromLTRB(20.sp, 20.sp, 30.sp, 0.sp),
        child: Row(
          children: [
            _formTitle('联系方式'),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 70.sp),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: logic.phoneController,
                decoration: InputDecoration(
                    hintText: "请填写咨询人电话",
                    border: InputBorder.none,
                    hintStyle:
                        TextStyle(color: Color(0xFF666666), fontSize: 13)),
              ),
            ))
          ],
        ));
  }

  ///咨询问题
  Widget _problem() {
    return InkWell(
        onTap: () async {
          DataStatistics.instance.event("consult_question_page", {"key": ""});
         var data =await Get.toNamed(RouteConfig.consultQuestionPage);
         if(data == 'ok'){
            state.problemLabel.value = "已填写";
         }
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.sp, 20.sp, 30.sp, 50.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _formTitle('咨询问题'),
              Obx(() => UIUtils.lableIcon(state.problemLabel.value,
                  Icons.chevron_right_outlined, () => {}, null)),
            ],
          ),
        ));
  }

  ///备注信息
  Widget _remark() {
    return Padding(
        padding: EdgeInsets.fromLTRB(30.sp, 10.sp, 30.sp, 10.sp),
        child: Text(
          '填写咨询人信息，便于您更好的咨询沟通。',
          style: TextStyle(color: Color(0xFF999999), fontSize: 10),
        ));
  }

  ///form表单标题样式
  Widget _formTitle(String titleName) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Text(
        titleName,
        style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333)),
      ),
    );
  }

  ///底部呼出年龄选择
  void _clickSpec(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _showAge();
      },
    );
  }

  Widget _showAge() {
    return Container(
        height: 600.sp,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => {Get.back()},
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(40.sp, 20.sp, 0.sp, 10.sp),
                    child: Text('取消',
                        style: TextStyle(
                            fontSize: 30.sp, color: Colors.blue[300])),
                  ),
                ),
                InkWell(
                  onTap: () => {
                    if (state.age.value == '')
                      {Toasts.show('请您选择您的年龄范围')}
                    else
                      {Get.back()}
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.sp, 20.sp, 40.sp, 0.sp),
                    child: Text('确认',
                        style: TextStyle(
                            fontSize: 30.sp, color: Colors.blue[300])),
                  ),
                )
              ],
            ),
            Divider(),
            row('0 ~ 18'),
            row('18 ~ 29'),
            row('30 ~ 49'),
            row('50以上'),
          ],
        ));
  }

  Widget row(value) {
    return InkWell(
        onTap: () => {_onClickAgeSuccess(value)},
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(5.sp),
                child: Text(value, style: TextStyle(fontSize: 36.sp))),
            Divider(),
          ],
        ));
  }

  ///点击选择年龄
  _onClickAgeSuccess(value) {
    DataStatistics.instance.event("selected_age", {"age": value});
    state.age.value = value;
    Get.back();
  }

  _onClickTime(item) {
    state.appointmentTime.value = item['time']['timeDesc'];
  }
}
