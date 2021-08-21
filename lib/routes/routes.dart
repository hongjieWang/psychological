import 'package:get/get.dart';
import 'package:standard_app/component/common/go_login_page.dart';
import 'package:standard_app/component/common/login_page.dart';
import 'package:standard_app/component/common/no_wifi.dart';
import 'package:standard_app/component/common/phone_binding.dart';
import 'package:standard_app/component/common/privacy_policy_page.dart';
import 'package:standard_app/component/common/sdk_agreement_page.dart';
import 'package:standard_app/component/common/user_agreement_page.dart';
import 'package:standard_app/component/default/order_default_page.dart';
import 'package:standard_app/component/page/consult/appointment/appointment_pay_view.dart';
import 'package:standard_app/component/page/consult/appointment/appointment_view.dart';
import 'package:standard_app/component/page/consult/appointment/pay_fail_view.dart';
import 'package:standard_app/component/page/consult/appointment/pay_success_view.dart';
import 'package:standard_app/component/page/consult/consult_all_page.dart';
import 'package:standard_app/component/page/consult/consult_details.dart';
import 'package:standard_app/component/page/consult/consult_evaluate_page.dart';
import 'package:standard_app/component/page/consult/consult_evaluate_show_list_page.dart';
import 'package:standard_app/component/page/consult/consult_page.dart';
import 'package:standard_app/component/page/consult/feedback/feedback_detail.dart';
import 'package:standard_app/component/page/consult/feedback/feedback_page.dart';
import 'package:standard_app/component/page/consult/question/consult_question_view.dart';
import 'package:standard_app/component/page/consult/video/video_page.dart';
import 'package:standard_app/component/page/consulting_management/consulting/consulting_all_view.dart';
import 'package:standard_app/component/page/consulting_management/consulting/consulting_details_view.dart';
import 'package:standard_app/component/page/consulting_management/consulting_index.dart';
import 'package:standard_app/component/page/consulting_management/mine/consulting_records.dart';
import 'package:standard_app/component/page/consulting_management/mine/consulting_set_page.dart';
import 'package:standard_app/component/page/consulting_management/mine/counselor_info_page.dart';
import 'package:standard_app/component/page/consulting_management/mine/payment_datails_page.dart';
import 'package:standard_app/component/page/consulting_management/mine/payment_records_page.dart';
import 'package:standard_app/component/page/consulting_management/mine/settlement_center_page.dart';
import 'package:standard_app/component/page/consulting_management/mine/withdraw_page.dart';
import 'package:standard_app/component/page/home/home_counselor_info_view.dart';
import 'package:standard_app/component/page/index_page.dart';
import 'package:standard_app/component/page/mine/attention/attention_page.dart';
import 'package:standard_app/component/page/mine/coupon/coupon_page.dart';
import 'package:standard_app/component/page/mine/customer/customer_page.dart';
import 'package:standard_app/component/page/mine/fans/fans_page.dart';
import 'package:standard_app/component/page/mine/feedback/platform_feedback_page.dart';
import 'package:standard_app/component/page/mine/join_us/join_us_page.dart';
import 'package:standard_app/component/page/mine/order/drawback/drawback_page.dart';
import 'package:standard_app/component/page/mine/order/order_all_page.dart';
import 'package:standard_app/component/page/mine/order/order_details_page.dart';
import 'package:standard_app/component/page/mine/order/order_page.dart';
import 'package:standard_app/component/page/mine/setup/setuo_name_page.dart';
import 'package:standard_app/component/page/mine/setup/setup_%20introduction_page.dart';
import 'package:standard_app/component/page/mine/setup/setup_page.dart';

class RouteConfig {
  ///主页面
  static final String main = "/";

  ///缺省页面
  ///无网络
  static final String noWifiPage = "no_wifi_page";

  ///登录注册页面
  static final String loginPage = "login_page";

  ///咨询详情页面
  static final String consultDetails = "consult_details";

  ///咨询列表页面
  static final String consultPage = "consult_page";

  ///意见反馈页面
  static final String feedbackPage = "feedback_page";

  ///意见反馈明细
  static final String feedbackDetailPage = "feedback_detail_page";

  ///评价页面
  static final String consultEvaluatePage = "consult_evaluate_page";

  ///预约页面
  static final String appointmentPage = "appointment_page";

  ///预约支付页面
  static final String appointmentPayPage = "appointment_pay_page";

  /// 支付成功页面
  static final String paySuccessPage = "pay_success_page";

  ///支付失败页面
  static final String payFailPage = "pay_fail_page";

  ///预约页面咨询问题
  static final String consultQuestionPage = "consult_question_page";

  ///我的订单
  static final String order = "order_page";

  ///订单详情
  static final String orderDetailsPage = "order_details_page";

  ///退款页面
  static final String drawbackPage = "drawback_page";

  ///个人中心用户投诉页面
  static final String platformFeedbackPage = "platform_feedback_page";

  ///优惠卷页面
  static final String couponPage = "coupon_page";

  ///我的关注
  static final String attentionPage = "attention_page";

  ///个人中心设置
  static final String setupPage = "setup_page";

  ///设置用户名称
  static final String setupNamePage = "setup_name_page";

  ///个人中心简介
  static final String setupIntroductionPage = "setup_introduction_page";

  ///客服管理
  static final String customerPage = "customer_page";

  ///咨询师详情
  static final String homeCounselorInfo = "home_counselor_info";

  ///视频通话
  static final String videoPage = "video_page";

  ///咨询管理
  static final String consultingHomePage = "consulting_home_page";

  /// 咨询设置
  static final String consultingSetPage = "consulting_set_page";

  /// 咨询管理-结算中心
  static final String settlementCenterPage = "settlement_center_page";

  /// 余额提现
  static final String withdrawPage = "withdraw_page";

  /// 咨询师个人信息
  static final String personalInfoPage = "personal_info_page";

  ///咨询师端用户详情页面
  static final String consultCounselorDetailsPage =
      "consult_counselor_details_page";

  ///收支明细
  static final String paymentRecordsPage = "payment_records_page";

  //收支详情
  static final String paymentDatailsPage = "payment_datails_page";

  //用户协议
  static final String userAgreementPage = "user_agreement_page";

  //隐私政策
  static final String privacyPolicyPage = "privacy_policy_page";

  //第三方sdk协议
  static final String sdkAgreementPage = "sdk_agreement_page";

  ///手机号绑定
  static final String phoneBindingPage = "phone_binding_page";

  //咨询师入驻
  static final String joinUsPage = "join_us_page";
  static final String goLoginPage = "goLoginPage";

  ///暂无订单缺省页
  static final String orderDefaultPage = "order_default_page";

  ///我的关注
  static final String myFansPage = "my_fans_page";

  ///全部订单
  static final String orderAllPage = "order_all_page";

  ///全部咨询
  static final String consultALlPage = "consult_aLl_page";

  ///用户评价列表
  static final String evaluateShowListPage = "evaluate_show_list_page";

  //咨询管理全部咨询
  static final String consultingAllPage = "consultingAllPage";

  ///咨询师端-咨询记录
  static final String consultingRecordsPage = "consulting_records_page";

  static final List<GetPage> routes = [
    GetPage(name: main, page: () => IndexPage(currentIndex: 0)), //首页
    GetPage(name: noWifiPage, page: () => NoWifiPage()),
    GetPage(name: consultDetails, page: () => ConsultDetails()), //咨询明细
    GetPage(name: consultPage, page: () => ConsultPage()), //咨询
    GetPage(name: feedbackPage, page: () => FeedBackPage()), //意见反馈
    GetPage(
        name: feedbackDetailPage, page: () => FeedBackDetailPage()), //意见反馈明细
    GetPage(
        name: consultEvaluatePage, page: () => ConsultEvaluatePage()), //评价列表
    GetPage(name: appointmentPage, page: () => AppointmentPage()), //预约页面
    GetPage(
        name: appointmentPayPage, page: () => AppointmentPayPage()), //预约支付页面
    GetPage(name: paySuccessPage, page: () => PaySuccessPage()), //支付成功页面
    GetPage(name: payFailPage, page: () => PayFailPage()), //支付失败页面
    GetPage(
        name: consultQuestionPage,
        page: () => ConsultQuestionView()), //预约页面咨询问题
    GetPage(name: order, page: () => OrderPage()), //订单
    GetPage(name: orderDetailsPage, page: () => OrderDetailsPage()), //订单详情
    GetPage(name: drawbackPage, page: () => DrawbackPage()), //退款页面
    GetPage(
        name: platformFeedbackPage,
        page: () => PlatformFeedbackPage()), //个人中心投诉页
    GetPage(name: couponPage, page: () => CouponPage()),
    GetPage(name: attentionPage, page: () => AttentionPage()), //我的关注
    GetPage(name: setupPage, page: () => SetupPage()), //个人中心设置
    GetPage(
      name: setupNamePage,
      page: () => SetupNamePage(),
    ), //设置用户名称页面
    GetPage(
        name: setupIntroductionPage,
        page: () => SetupIntroductionPage()), //个人中心简介
    GetPage(name: customerPage, page: () => CustomerPage()), //客服管理
    ///咨询师详情
    GetPage(name: homeCounselorInfo, page: () => HomeCounselorInfo()),
    GetPage(name: videoPage, page: () => VideoPage()), //视频通话组建
    GetPage(name: consultingHomePage, page: () => ConsultingHomePage()), //咨询管理
    GetPage(name: consultingSetPage, page: () => ConsultingSetPage()), //咨询设置
    GetPage(
        name: settlementCenterPage,
        page: () => SettlementCenterPage()), //咨询管理-结算中心
    GetPage(name: withdrawPage, page: () => WithdrawPage()), //提现
    GetPage(name: personalInfoPage, page: () => CounselorInfoPage()), //个人信息页面
    GetPage(name: loginPage, page: () => LoginPage()), //登录注册页面
    GetPage(name: goLoginPage, page: () => GoLoginPage(true)), //登录注册页面
    GetPage(
        name: consultCounselorDetailsPage,
        page: () => ConsultCounselorDetailsPage()), //咨询师端用户详情页面
    GetPage(name: paymentRecordsPage, page: () => PaymentRecordsPage()), //收支明细
    GetPage(name: paymentDatailsPage, page: () => PaymentDatailsPage()), //收支明细
    GetPage(name: userAgreementPage, page: () => UserAgreementPage()), //用户协议
    GetPage(name: privacyPolicyPage, page: () => PrivacyPolicyPage()), //隐私政策
    GetPage(name: sdkAgreementPage, page: () => SdkAgreementPage()), //第三方SDK协议
    GetPage(name: phoneBindingPage, page: () => PhoneBindingPage()), //第三方SDK协议
    GetPage(name: joinUsPage, page: () => JoinUsPage()), //咨询师入驻流程
    GetPage(name: orderDefaultPage, page: () => OrderDefaultPage()), //咨询师入驻流程
    GetPage(name: myFansPage, page: () => MyFansPage()), //我的关注
    GetPage(name: orderAllPage, page: () => OrderAllPage()), //全部订单
    GetPage(name: consultALlPage, page: () => ConsultALlPage()), //全部订单
    GetPage(
        name: consultingRecordsPage,
        page: () => ConsultingRecordsPage()), //咨询师端-咨询记录
    GetPage(
        name: consultingAllPage, page: () => ConsultingAllPage()), //咨询管理全部咨询
    GetPage(
        name: evaluateShowListPage,
        page: () => EvaluateShowListPage()), //用户评价列表
  ];
}
