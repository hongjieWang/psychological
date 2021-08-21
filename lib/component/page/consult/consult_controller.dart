import 'dart:async';

import 'package:get/get.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/component/page/consult/consult_state.dart';
import 'package:standard_app/http/dio_util.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/Toasts.dart';
import 'package:standard_app/util/time_utils.dart';

///咨询管理控制器
class ConsultController extends GetxController {
  ConsultState state = ConsultState();

  /// 未预约
  static final int NOT_MAKE_APPOINTMENT = AppConstant.APPOINTMENT_NO;

  /// 预约成功
  static final int APPOINTMENT_SUCCESS = AppConstant.APPOINTMENT_SUCCESS;

  /// 进行中/已开始
  static final int ONGOING = 2;

  /// 已结束
  static final int FINISH = 3;

  /// 已取消
  static final int CANCEL = 4;

  /// 已签到
  static final int SIGN_IN = AppConstant.SIGN_IN;

  ///对应状态
  Map statusMap = {
    NOT_MAKE_APPOINTMENT: "未预约",
    APPOINTMENT_SUCCESS: "预约成功",
    ONGOING: "咨询中",
    FINISH: "已结束",
    CANCEL: "已取消",
    SIGN_IN: "已签到"
  };

  ///判断按钮状态是否禁止点击
  ///1、为预约情况下可以点击
  ///2、签到完成后可进行咨询
  ///3、在开始时间5min可以点击
  ///4、在结束咨询时间前 可以点击
  bool onBtnStatus(item) {
    if (item['appointmentTime'] == null) {
      return false;
    }
    return item['status'] == NOT_MAKE_APPOINTMENT ||
        item['status'] == SIGN_IN ||
        timeLessAbs(
            DateTime.parse(item['appointmentTime']), AppConstant.STARTTIME) ||
        isTimeRange(item);
  }

  /// 当前时间大于预约时间
  /// 当前时间小于结束时间
  static bool isTimeRange(item) {
    return timeIsAfter(DateTime.parse(item['appointmentTime'])) &&
        timeIsBefore(DateTime.parse(item['endTime']));
  }

  ///取消预约按钮状态
  bool onCancelBtnStatus(item) {
    if (item['appointmentTime'] == null) {
      return false;
    }
    return timeLessNum(DateTime.parse(item['appointmentTime'])) > 6 * 60 &&
        item['status'] == APPOINTMENT_SUCCESS;
  }

  ///咨询按钮出发
  onFunction(item) {
    if (onBtnStatus(item)) {
      _onFuncStatus(item);
    } else {
      if (item['status'] == AppConstant.CANCEL ||
          item['status'] == AppConstant.FINISHED) {
      } else {
        Toasts.show("咨询开始前${AppConstant.STARTTIME}分钟点击按钮进入房间");
      }
    }
  }

  /// 根据状态返回相应操作
  void _onFuncStatus(item) {
    if (item['status'] == AppConstant.APPOINTMENT_NO) {
      _onClickAppointment(item);
    } else if (timeIsBefore(DateTime.parse(item['endTime']))) {
      _onClickStart(item);
    } else {}
  }

  ///开始咨询按钮
  _onClickStart(item) {
    ApiService().applyAgToken(item['channelName']).then((res) => {
          if (res['code'] == Api.success)
            {
              Get.toNamed(RouteConfig.videoPage, arguments: {
                "token": res['msg'],
                "channelName": item['channelName'],
                "uid": item['mui'],
                "userInfo": {
                  "name": item['counselorName'],
                  "avatar": item['avatar']
                },
                "consult": item
              })
            }
          else
            {Toasts.error("服务异常，请稍后重试，或请联系客服人员")}
        });
  }

  ///点击立即预约按钮
  static _onClickAppointment(Map item) {
    DioUtil().get(Api.CONSULT_TIME_API, pathParams: {
      "counselorId": item['counselorId']
    }).then((value) => {
          item.addAll(value),
          Get.toNamed(RouteConfig.appointmentPage, arguments: item)
        });
  }

  ///叙时点击事件
  onFuncOnceAgainToBuy(item) {
    ApiService().getCounselorInfoService("${item['counselorId']}").then(
        (value) => Get.toNamed(RouteConfig.appointmentPayPage, arguments: {
              "order": {},
              "combo": {
                "comboId": item['comboId'],
                "comboName": item['comboName'],
                "originalPrice": item['originalPrice']
              },
              "item": value['data']
            }));
  }

  ///评价
  onClickEvaluate(item) {
    Get.toNamed(RouteConfig.consultEvaluatePage, arguments: item['crId']);
  }

  ///获取咨询时间长度:当前时间-结束时间
  getTimeLength(item) {
    int length =
        timeLessNumAbs(DateTime.now(), DateTime.parse(item['endTime']));
    if (length < 0) {
      length = 50 * 60;
    }
    return length;
  }
}
