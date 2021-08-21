import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/component/common/avatar.dart';
import 'package:standard_app/util/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///咨询师端咨询详情
class ConsultCounselorDetailsPage extends StatefulWidget {
  ConsultCounselorDetailsPage({Key key}) : super(key: key);

  @override
  _ConsultCounselorDetailsPageState createState() =>
      _ConsultCounselorDetailsPageState();
}

class _ConsultCounselorDetailsPageState
    extends State<ConsultCounselorDetailsPage> {
  Map item = Get.arguments;
  Map consult = {"sex": 2, "age": "", "plCounselorLabels": []};
  @override
  void initState() {
    super.initState();

    ApiService().getConsultDetail(item['crId']).then((value) => setState(() {
          consult = value['data'];
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("预约详情"),
      body: _body(),
    );
  }

  ///咨询师端咨询详情
  Widget _body() {
    return Container(
        decoration: BoxDecoration(color: StyleUtils.bgColor),
        height: double.infinity,
        child: SingleChildScrollView(
            child: Container(child: Column(children: [_title(), _content()]))));
  }

  ///内容部分
  Widget _content() {
    return Container(
      width: double.infinity,
      height: 0.5.sh,
      padding: EdgeInsets.fromLTRB(20.sp, 10.sp, 20.sp, 10.sp),
      margin: EdgeInsets.fromLTRB(32.sp, 34.sp, 32.sp, 10.sp),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            _avatar(),
            SizedBox(
              width: 0.01.sw,
            ),
            _name()
          ]),
          SizedBox(
            height: 40.sp,
          ),
          Row(children: [
            _contentTitle("时间"),
            SizedBox(
              width: 0.1.sw,
            ),
            Text(
              item['appointmentTime'] != null ? item['appointmentTime'] : "未预约",
              style: TextStyle(fontSize: 24.sp, color: StyleUtils.fontColor_3),
            )
          ]),
          SizedBox(
            height: 40.sp,
          ),
          Row(children: [
            _contentTitle("课程"),
            SizedBox(
              width: 0.1.sw,
            ),
            Text(
              item['comboName'],
              style: TextStyle(fontSize: 24.sp, color: StyleUtils.fontColor_3),
            )
          ]),
          SizedBox(
            height: 40.sp,
          ),
          Row(children: [
            _contentTitle("性别"),
            SizedBox(
              width: 0.1.sw,
            ),
            Text(
              AppConstant.sexStr(consult['sex']),
              style: TextStyle(fontSize: 24.sp, color: StyleUtils.fontColor_3),
            )
          ]),
          SizedBox(
            height: 40.sp,
          ),
          Row(children: [
            _contentTitle("年龄"),
            SizedBox(
              width: 0.1.sw,
            ),
            Text(
              consult['age'] != null ? consult['age'] : "未知",
              style: TextStyle(fontSize: 24.sp, color: StyleUtils.fontColor_3),
            )
          ]),
          SizedBox(
            height: 40.sp,
          ),
          Row(children: _lables()),
          SizedBox(
            height: 40.sp,
          ),
          _contentTitle("问题描述"),
          Padding(
            padding: EdgeInsets.only(left: 20.sp, top: 20.sp),
            child: Text(
              consult['problemDesc'] != null ? consult['problemDesc'] : "",
              style: TextStyle(fontSize: 22.sp, color: StyleUtils.fontColor_6),
            ),
          )
        ],
      ),
    );
  }

  ///咨询标签
  List<Widget> _lables() {
    List<Widget> lablesWidget = [];
    List lables = consult['plCounselorLabels'] != null
        ? consult['plCounselorLabels'].toList()
        : [];
    lablesWidget.add(_contentTitle("咨询"));
    lablesWidget.add(SizedBox(
      width: 0.1.sw,
    ));
    lables.forEach((element) {
      lablesWidget.add(Container(
        alignment: Alignment.center,
        height: 32.sp,
        width: 104.sp,
        decoration: BoxDecoration(
          color: Color(0xFFE3E3E3),
          borderRadius: BorderRadius.all(Radius.circular(20.sp)),
        ),
        child: Text(
          element['counselorLabelName'],
          style: TextStyle(color: StyleUtils.fontColor_6, fontSize: 16.sp),
        ),
      ));
      lablesWidget.add(SizedBox(
        width: 0.01.sw,
      ));
    });
    return lablesWidget;
  }

  Widget _contentTitle(value) {
    return Padding(
      padding: EdgeInsets.only(left: 20.sp),
      child: Text(
        value,
        style: TextStyle(color: StyleUtils.fontColor_6, fontSize: 24.sp),
      ),
    );
  }

  ///用户姓名
  Widget _name() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Text(
        "${item['membersName']} (${item['nickName']})",
        style: TextStyle(fontSize: 28.sp, color: StyleUtils.fontColor_3),
      ),
    );
  }

  ///头像
  Widget _avatar() {
    return Avatar(
      url: item['avatar'],
      width: 48,
      height: 48,
    );
  }

  ///标题部分
  Widget _title() {
    return Padding(
      padding: EdgeInsets.fromLTRB(32.sp, 0.02.sh, 32.sp, 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "咨询信息",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: StyleUtils.fontColor_3,
                fontSize: 32.sp),
          ),
          Text(
            AppConstant.statusMap(item['status']),
            style: TextStyle(
                color: StyleUtils.fontColor_3,
                fontSize: 26.sp,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
