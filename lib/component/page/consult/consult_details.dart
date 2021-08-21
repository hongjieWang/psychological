import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/component/common/alert_dialog_706.dart';
import 'package:standard_app/component/page/consult/appointment/appointment_controller.dart';
import 'package:standard_app/component/page/consult/consult_controller.dart';
import 'package:standard_app/component/page/consult/feedback/feedback_controller.dart';
import 'package:standard_app/component/page/consult/feedback/feedback_state.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/Toasts.dart';
import 'package:standard_app/util/dialog.dart';
import 'package:standard_app/util/style.dart';
import 'package:standard_app/util/time_utils.dart';

///咨询详情
class ConsultDetails extends StatefulWidget {
  ConsultDetails({Key key}) : super(key: key);

  @override
  _ConsultDetailsState createState() => _ConsultDetailsState();
}

///咨询详情
class _ConsultDetailsState extends State<ConsultDetails> {
  final FeedBackController logic = Get.put(FeedBackController());
  final FeedBackState state = Get.find<FeedBackController>().state;
  final AppointmentController appointment = Get.put(AppointmentController());
  final ConsultController consultLogic = Get.put(ConsultController());
  Map _item = Get.arguments;
  List timeDatas = [];
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '咨询详情',
          style: TextStyle(fontSize: 36.sp, color: Colors.black),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black), //自定义图标
            onPressed: () {
              Get.back();
            },
          );
        }),
      ),
      body: _body(),
    );
  }

  @override
  void initState() {
    super.initState();
    _countdown();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  ///咨询详情body页面
  Widget _body() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Color(0xFFF5FAFD)),
        margin: EdgeInsets.only(left: 30.sp, right: 30.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //标题展示
            _title(),
            //咨询信息展示
            _consultInfo(),
            //咨询进度展示
            _consultProgress(),
          ],
        ),
      ),
    );
  }

  ///咨询信息文字展示
  Widget _title() {
    return Container(
      margin: EdgeInsets.only(top: 32.sp),
      child: Text(
        '咨询信息',
        style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500),
      ),
    );
  }

  ///咨询信息展示
  Widget _consultInfo() {
    return Container(
      padding: EdgeInsets.only(top: 34.sp),
      child: Container(
          decoration: new BoxDecoration(
            //背景
            color: Colors.white,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _counselorInfo(),
              Divider(
                indent: 20.sp,
                endIndent: 20.sp,
              ),
              _consultTimeInfo(),
              SizedBox(
                height: 60.sp,
              ),
              _consultButtom()
            ],
          )),
    );
  }

  /// 咨询师信息展示
  Widget _counselorInfo() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _counselorName(),
          Container(
            padding: EdgeInsets.only(right: 40.0.sp, top: 44.sp),
            child: Text(
              AppConstant.statusMap(_item['status']),
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            ),
          )
        ],
      ),
    );
  }

  ///咨询师头像和姓名
  Widget _counselorName() {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0.sp, 40.0.sp, 0.0, 0.0),
      child: Row(
        children: [
          InkWell(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(20.sp)),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  this._item['avatar'],
                  width: 48.r,
                  height: 48.r,
                )),
            onTap: () {},
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0.sp),
            child: Text(
              _item['counselorName'],
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  /// 开始咨询按钮
  Widget _consultButtom() {
    return Padding(
        padding: EdgeInsets.only(bottom: 46.0.sp),
        child: TextButton(
            onPressed: () {
              consultLogic.onFunction(_item);
            },
            child: Obx(() => Text(
                  state.btnName.value,
                  style: TextStyle(color: Colors.white, fontSize: 30.sp),
                )),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                //设置按下时的背景颜色
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue[200];
                }
                //默认不使用背景颜色
                return Color(0xFF3A8DFF);
              }),
              minimumSize: MaterialStateProperty.all(Size(686.sp, 68.sp)),
              shape: MaterialStateProperty.all(StadiumBorder()),
            )));
  }

  ///咨询时间信息展示
  Widget _consultTimeInfo() {
    return Container(
        child: Column(children: [
      _timeInfo(
          "时间",
          this._item['appointmentTime'] == null
              ? "未预约"
              : this._item['appointmentTime']),
      _timeInfo('课程', this._item['comboName']),
      _timeInfo('时长', _item['courseDuration'])
    ]));
  }

  ///时间标签内容统一展示
  Widget _timeInfo(key, value) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(40.0.sp, 44.0.sp, 0.0, 0.0),
          child: Text(
            key,
            style: TextStyle(fontSize: 24.sp, color: Color(0xFF666666)),
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(60.0.sp, 44.0.sp, 0.0, 0.0),
            child: Text(
              value,
              style: TextStyle(fontSize: 24.sp, color: Color(0xFF333333)),
            ))
      ],
    );
  }

  ///咨询进度
  Widget _consultProgress() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(0.0, 40.0.sp, 0.0, 0.0),
      child: Container(
          width: double.infinity,
          decoration: new BoxDecoration(
            //背景
            color: Colors.white,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(20.0.sp)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _titleProgress(),
              Obx(() => _getItem('咨询时间', '咨询开始前6小时无法取消预约', '取消预约', _cancel,
                  state.showCancelBtn.value)),
              Obx(() => _getItem(
                  '签到',
                  '咨询前15分钟可以签到，便于开始咨询',
                  state.signBtnName.value,
                  _onClickSignIn,
                  state.showSignIn.value)),
              _getItem('进行咨询', '咨询过程中，如有任何问题，3日内均可进行反馈', '意见反馈',
                  _onClickFeedBack, true),
              Obx(() => _getItem('评价', '完成咨询后，可对本次咨询进行评价', '评价',
                  _onClickEvaluate, state.showEvaluateBtn.value))
            ],
          )),
    );
  }

  ///咨询进度标题-爽约
  Widget _titleProgress() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0.sp, 24.0.sp, 20.0.sp, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '咨询进度',
            style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ),
          InkWell(
            onTap: () {
              _onClickGiveUp();
            },
            child: Row(
              children: [
                Text('爽约说明',
                    style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333))),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///时光轴实现
  Widget _getItem(title, describe, btnName, onPressed, isShow) {
    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: rightItem(title, describe, btnName, onPressed, isShow),
          ),
        ],
      ),
    );
  }

  Widget rightItem(title, describe, btnName, onPressed, isShowBtn) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 0.85.sw,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333333)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.sp),
                  child: TextButton(
                    onPressed: isShowBtn ? onPressed : null,
                    child: Text(btnName,
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        //设置按下时的背景颜色
                        if (states.contains(MaterialState.pressed)) {
                          return Color(0xFF3A8DFF);
                        }
                        //默认不使用背景颜色
                        return isShowBtn ? Color(0xFF3A8DFF) : Colors.grey;
                      }),
                      //设置按钮内边距
                      padding: MaterialStateProperty.all(EdgeInsets.all(8.sp)),
                      //设置按钮的大小
                      minimumSize:
                          MaterialStateProperty.all(Size(166.sp, 44.sp)),
                      //外边框装饰 会覆盖 side 配置的样式
                      shape: MaterialStateProperty.all(StadiumBorder()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.sp),
            child: Text(describe,
                style: TextStyle(color: Colors.black54, fontSize: 24.sp)),
          )
        ],
      ),
    );
  }

  ///点击爽约声明事件
  _onClickGiveUp() {
    showGiveUpDialog();
  }

// 弹出对话框
  Future<bool> showGiveUpDialog() {
    return showCustomDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "爽约说明",
            style: TextStyle(fontSize: 15),
          ),
          content: Container(
            height: 280 * 2.sp,
            width: 269 * 2.sp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  children: [
                    Text(
                      "   如果因个人原因，无法按时进行咨询，请务必提前6小时联系客服，以免影响您的咨询体验。\n\n     我们会在咨询开始前，通过短信或电话进行提醒。若未参与咨询且未取消预约，将视为爽约。咨询事件根据预约流程正常进行，因用户未到达而爽约不进行退费。",
                      style: TextStyle(
                        fontSize: 26.sp,
                        color: StyleUtils.fontColor_6,
                        height: 1.3,
                      ),
                    ),
                  ],
                ))),
                SizedBox(
                  height: 22.sp,
                ),
                TextButton(
                  child: Text(
                    "我知道了",
                    style: TextStyle(fontSize: 28.sp, color: Colors.black),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  bool time() {
    if (this._item['appointmentTime'] != null) {
      return timeMinGreater(DateTime.parse(this._item['appointmentTime']), 0);
    }
    return false;
  }

  _countdown() {
    if (_item['status'] == 1) {
      state.btnName.value = AppConstant.btnNameMap(_item['status']) +
          "${timeDifference(DateTime.parse(_item['appointmentTime']))}";
      _timer = Timer.periodic(Duration(minutes: 1), _callback);
    } else {
      state.btnName.value = AppConstant.btnNameMap(_item['status']);
    }

    //签到按钮显示控制：未预约 或 已签到 或  已完成 咨询时间已经开始 不可点击签到按钮
    if (_item['status'] == 0 ||
        _item['status'] == 5 ||
        _item['status'] == 3 ||
        time()) {
      state.showSignIn.value = false;
    } else {
      if (this._item['appointmentTime'] == null) {
        state.showSignIn.value = false;
        return;
      }
      state.showSignIn.value = timeLessAbs(
          DateTime.parse(this._item['appointmentTime']),
          AppConstant.SIGNIN_STARTTIME);
    }
    state.showCancelBtn.value =
        consultLogic.onCancelBtnStatus(_item); //true 可取消
    state.showEvaluateBtn.value = (_item['status'] == AppConstant.FINISHED);
    state.signBtnName.value =
        _item['status'] != AppConstant.SIGN_IN ? "签到" : "已签到";
  }

  _callback(timer) => {
        state.btnName.value = AppConstant.btnNameMap(_item['status']) +
            "(${timeDifference(DateTime.parse(_item['appointmentTime']))})",
        //签到按钮显示控制
        state.showCancelBtn.value =
            consultLogic.onCancelBtnStatus(_item), //true 可取消
        state.showCancelBtn.value =
            consultLogic.onCancelBtnStatus(_item), //true 可取消
        state.showEvaluateBtn.value = (_item['status'] == AppConstant.FINISHED)
      };

  ///时间组件点击事件
  _onClickFun(time) {
    print(time);
  }

  /// 意见反馈
  _onClickFeedBack() {
    state.feedObj.value = _item;
    Get.toNamed(RouteConfig.feedbackPage);
  }

  _cancel() {
    if (consultLogic.onCancelBtnStatus(_item)) {
      popDialog(
          context,
          ShowAlertDialog706(
            items: ['取消', '确认'],
            title: "取消预约",
            content: '确认要取消预约嘛？',
            onTap: (index) {
              if (index == 1) {
                ApiService()
                    .appointmentTimeCancel(_item)
                    .then((value) => Get.back(result: '_cancel'));
              }
            },
          ));
    } else {
      popDialog(
          context,
          ShowAlertDialog706(
            items: ['取消', '确认'],
            title: "警告",
            content: '预约时间距现在小于6小时，无法取消预约',
            onTap: (index) {
              if (index == 1) {
                ApiService()
                    .appointmentTimeCancel(_item)
                    .then((value) => Get.back());
              }
            },
          ));
    }
  }

  ///签到点击按钮
  _onClickSignIn() {
    if (!timeLess(DateTime.parse(this._item['appointmentTime']),
        AppConstant.SIGNIN_STARTTIME)) {
      Toasts.show("请在${AppConstant.SIGNIN_STARTTIME}min内进行签到");
      return null;
    } else if (timeMinGreater(
        DateTime.parse(this._item['appointmentTime']), 0)) {
      Toasts.show("咨询时间已经开始，无法进行签到");
      return null;
    } else {
      ApiService().signIn(_item['crId']).then((value) => setState(() {
            Toasts.show("签到成功");
            state.signBtnName.value = "已签到";
          }));
    }
  }

  ///评价
  _onClickEvaluate() {
    Get.toNamed(RouteConfig.consultEvaluatePage, arguments: _item['crId']);
  }
}
