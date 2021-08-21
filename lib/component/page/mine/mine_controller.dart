import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/common/data_statistics.dart';
import 'package:standard_app/component/common/go_login_page.dart';
import 'package:standard_app/component/common/share_opt_page.dart';
import 'package:standard_app/component/common/wechat_utils.dart';
import 'package:standard_app/component/page/consult/appointment/pay_fail_view.dart';
import 'package:standard_app/component/page/mine/mine_state.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/Toasts.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

///我的控制器
class MineController extends GetxController {
  MineStats state = MineStats();

  ///点击我的订单
  onClickMyOrder() {
    print('点击了我的订单');
    DataStatistics.instance.event("onclick_my_order", {"order": ""});
    Get.toNamed(RouteConfig.order);
  }

  ///我的关注
  onClickMyAttention() {
    print("点击了我的关注");
    DataStatistics.instance.event("onclick_my_attention", {"attention": ""});
    Get.toNamed(RouteConfig.myFansPage);
  }

  ///优惠券
  onClickMyCoupons() {
    DataStatistics.instance.event("onclick_my_coupons", {"coupons": ""});
    Get.toNamed(RouteConfig.couponPage);
  }

  ///专家入驻
  onClickExpert() {
    DataStatistics.instance.event("onclick_expert", {"key": ""});
    print("点击了专家入驻");
    Get.toNamed(RouteConfig.joinUsPage);
  }

  ///点击了分析
  onClickFenxiang() {
    print("点击了分析");
    final List<ShareOpt> list = [
      ShareOpt(
          title: '微信',
          img: ImageUtils.getImgPath("icon_wechat"),
          shareType: ShareType.SESSION,
          doAction: (shareType, shareInfo) async {
            var model = _getShareModel(shareType, shareInfo);
            WeChatUtils().shareToWeChat(model);
          }),
      ShareOpt(
          title: '朋友圈',
          img: ImageUtils.getImgPath("icon_wechat_moments"),
          shareType: ShareType.TIMELINE,
          doAction: (shareType, shareInfo) {
            var model = _getShareModel(shareType, shareInfo);
            WeChatUtils().shareToWeChat(model);
          }),
      ShareOpt(
          title: '复制链接',
          img: ImageUtils.getImgPath("icon_copylink"),
          shareType: ShareType.COPY_LINK,
          doAction: (shareType, shareInfo) {
            if (shareType == ShareType.COPY_LINK) {
              ClipboardData data = new ClipboardData(text: shareInfo.url);
              Clipboard.setData(data);
              Toasts.show("链接复制成功");
            }
          }),
    ];
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: Get.context,
        builder: (BuildContext context) {
          return ShareWidget(
            ShareInfo('706在线心理平台', "https://706xinli.com",
                img:
                    "https://julywhj-1258527903.cos.ap-beijing.myqcloud.com/706/logo/logo.png"),
            list: list,
          );
        });
  }

  ///点击了咨询管理
  onClickCounsel() {
    DataStatistics.instance.event("onclick_counsel", {"counsel": ""});
    ApiService()
        .getCounselorInfoService(Global.getCounselorId())
        .then((value) => {
              print(value),
              Get.offAllNamed(RouteConfig.consultingHomePage,
                  arguments: value['data'])
            });
  }

  ///点击意见反馈
  onClickFeedback() {
    print("点击了意见反馈");
    DataStatistics.instance.event("onclick_feedback", {"feedback": ""});
    Get.toNamed(RouteConfig.platformFeedbackPage);
  }

  ///点击了客服
  onClickCustomerService() {
    DataStatistics.instance.event("onclick_customer_service", {"key": ""});
    Get.toNamed(RouteConfig.customerPage);
  }

  ///点击了了解更多
  onClickMore() {
    DataStatistics.instance.event("onclick_more", {"key": ""});
    Get.to(PayFailPage());
    print("点击了了解更多");
  }

  ///点击了设置
  onClickSettings() {
    if (Global.getUserId() == "null" || Global.getUserId() == "0") {
      Get.offAllNamed(RouteConfig.loginPage);
      return;
    }
    DataStatistics.instance.event("onclick_settings", {"key": ""});
    Get.toNamed(RouteConfig.setupPage);
  }

  static dynamic _getShareModel(ShareType shareType, ShareInfo shareInfo) {
    var scene = fluwx.WeChatScene.SESSION;
    switch (shareType) {
      case ShareType.SESSION:
        scene = fluwx.WeChatScene.SESSION;
        break;
      case ShareType.TIMELINE:
        scene = fluwx.WeChatScene.TIMELINE;
        break;
      case ShareType.COPY_LINK:
        break;
      case ShareType.DOWNLOAD:
        break;
    }

    if (shareInfo.img != null) {
      return fluwx.WeChatShareWebPageModel(
        shareInfo.url,
        title: shareInfo.title,
        thumbnail: fluwx.WeChatImage.network(shareInfo.img),
        scene: scene,
      );
    } else {
      return fluwx.WeChatShareWebPageModel(
        shareInfo.url,
        title: shareInfo.title,
        scene: scene,
      );
    }
  }
}
