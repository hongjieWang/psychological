import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/common/data_statistics.dart';
import 'package:standard_app/component/common/go_login_page.dart';
import 'package:standard_app/component/page/home/home_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/http/dio_util.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/service/home_service.dart';

///首页逻辑信息
class HomeController extends GetxController {
  final HomeState state = HomeState();
  final ScrollController controller = ScrollController();
  DioUtil _dio = DioUtil();

  HomeController() {
    _initCounselor();
    _dio.get(Api.HOME_EVALUATE).then((value) => {
          if (value['code'] == Api.success)
            {state.homeFeedback.value = value['data']}
        });
    //监听滚动事件，打印滚动位置
    controller.addListener(() {
      if (controller.offset < 700 && state.showToTopBtn.isTrue) {
        state.showToTopBtn.value = false;
      } else if (controller.offset >= 700 && state.showToTopBtn.isFalse) {
        state.showToTopBtn.value = true;
      }
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        state.pageNum.value = state.pageNum.value + 1;
        _initCounselor();
      }
    });
  }

  ScrollPhysics onScreen() {
    return state.isShowScreen.isTrue
        ? NeverScrollableScrollPhysics()
        : AlwaysScrollableScrollPhysics();
  }

  ///咨询师初始化
  ///
  void _initCounselor() {
    ///延时加载
    Future.delayed(Duration(milliseconds: 1000), () {
      ApiService().counselorList(state.pageNum.value).then((results) => {
            if (results['code'] == Api.success)
              {
                state.total.value = results["total"],
                state.counselorData.addAll(results["rows"])
              }
          });
    });
  }

  Future<void> onRefresh() async {
    state.total.value = 0;
    state.counselorData.clear();
    state.pageNum.value = 1;
    this._initCounselor();
  }

  ///点击主题
  onClickTheme() {
    if (state.screen.value && state.index.value == 1) {
      state.toolbarHeight.value = 70.sp;
      state.index.value = 0;
      state.screen.value = false;
      state.isShowScreen.value = false;
    } else {
      state.toolbarHeight.value = 630.sp;
      state.index.value = 1;
      state.screen.value = true;
      state.isShowScreen.value = true;
    }
  }

  ///点击咨询师列表跳转咨询师详情
  onClickItem(item) {
    DataStatistics.instance.event(
        "onClick_counselor", {"counselor": item['members']['membersName']});
    DioUtil().get(Api.CONSULT_TIME_API, pathParams: {
      "counselorId": item['counselorId']
    }).then((value) => {
          item.addAll(value),
          Get.toNamed(RouteConfig.homeCounselorInfo, arguments: item)
        });
  }

  ///关注事件
  focusOn() {
    Map data = {
      "targetId": state.counselorInfo['membersId'],
      "attentionId": Global.getUserId(),
      "attentionStatus": state.isFocusOn.value ? 1 : 0,
      "platform": Global.getPlatform(),
      "deviceId": Global.getDeviceId()
    };
    ApiService().focusOn(data);
  }

  ///点击排序
  onClickSort() {
    if (state.screen.value && state.index.value == 2) {
      state.toolbarHeight.value = 70.sp;
      state.index.value = 0;
      state.screen.value = false;
      state.isShowScreen.value = false;
    } else {
      state.toolbarHeight.value = 680.sp;
      state.index.value = 2;
      state.screen.value = true;
      state.isShowScreen.value = true;
    }
  }

  ///排序选择数据
  selectedSort(sort) {
    state.selectedSortData.value = sort;
    onClickSort();
  }

  ///选择主题标签事件
  selectedThemeLables(lable) {
    if (state.selectedThemeLablesData.contains(lable)) {
      state.selectedThemeLablesData.remove(lable);
    } else {
      state.selectedThemeLablesData.add(lable);
    }
  }

  ///显示或隐藏咨询师详细信息
  showCounselorInfo() {
    state.showCounselorInfo.value = !state.showCounselorInfo.value;
    // if (state.showCounselorInfo.value) {
    //   state.expandedHeight.value = 0.4;
    // } else {
    //   state.expandedHeight.value = 1;
    // }
  }

  /// 预约须知展示收起事件
  showText() {
    state.isShowText.value = !state.isShowText.value;
  }

  /// 跳转预约支付页面
  onClickAppointmentPayPage(item) {
    if (isUserLogin()) {
      Get.toNamed(RouteConfig.appointmentPayPage, arguments: item);
    } else {
      Get.toNamed(RouteConfig.goLoginPage);
    }
  }

  ///判断用户是否登录
  bool isUserLogin() {
    return Global.getUserId() != "0" && Global.getUserId() != "null";
  }
}
