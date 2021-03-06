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
  ///?????????
  static final String main = "/";

  ///????????????
  ///?????????
  static final String noWifiPage = "no_wifi_page";

  ///??????????????????
  static final String loginPage = "login_page";

  ///??????????????????
  static final String consultDetails = "consult_details";

  ///??????????????????
  static final String consultPage = "consult_page";

  ///??????????????????
  static final String feedbackPage = "feedback_page";

  ///??????????????????
  static final String feedbackDetailPage = "feedback_detail_page";

  ///????????????
  static final String consultEvaluatePage = "consult_evaluate_page";

  ///????????????
  static final String appointmentPage = "appointment_page";

  ///??????????????????
  static final String appointmentPayPage = "appointment_pay_page";

  /// ??????????????????
  static final String paySuccessPage = "pay_success_page";

  ///??????????????????
  static final String payFailPage = "pay_fail_page";

  ///????????????????????????
  static final String consultQuestionPage = "consult_question_page";

  ///????????????
  static final String order = "order_page";

  ///????????????
  static final String orderDetailsPage = "order_details_page";

  ///????????????
  static final String drawbackPage = "drawback_page";

  ///??????????????????????????????
  static final String platformFeedbackPage = "platform_feedback_page";

  ///???????????????
  static final String couponPage = "coupon_page";

  ///????????????
  static final String attentionPage = "attention_page";

  ///??????????????????
  static final String setupPage = "setup_page";

  ///??????????????????
  static final String setupNamePage = "setup_name_page";

  ///??????????????????
  static final String setupIntroductionPage = "setup_introduction_page";

  ///????????????
  static final String customerPage = "customer_page";

  ///???????????????
  static final String homeCounselorInfo = "home_counselor_info";

  ///????????????
  static final String videoPage = "video_page";

  ///????????????
  static final String consultingHomePage = "consulting_home_page";

  /// ????????????
  static final String consultingSetPage = "consulting_set_page";

  /// ????????????-????????????
  static final String settlementCenterPage = "settlement_center_page";

  /// ????????????
  static final String withdrawPage = "withdraw_page";

  /// ?????????????????????
  static final String personalInfoPage = "personal_info_page";

  ///??????????????????????????????
  static final String consultCounselorDetailsPage =
      "consult_counselor_details_page";

  ///????????????
  static final String paymentRecordsPage = "payment_records_page";

  //????????????
  static final String paymentDatailsPage = "payment_datails_page";

  //????????????
  static final String userAgreementPage = "user_agreement_page";

  //????????????
  static final String privacyPolicyPage = "privacy_policy_page";

  //?????????sdk??????
  static final String sdkAgreementPage = "sdk_agreement_page";

  ///???????????????
  static final String phoneBindingPage = "phone_binding_page";

  //???????????????
  static final String joinUsPage = "join_us_page";
  static final String goLoginPage = "goLoginPage";

  ///?????????????????????
  static final String orderDefaultPage = "order_default_page";

  ///????????????
  static final String myFansPage = "my_fans_page";

  ///????????????
  static final String orderAllPage = "order_all_page";

  ///????????????
  static final String consultALlPage = "consult_aLl_page";

  ///??????????????????
  static final String evaluateShowListPage = "evaluate_show_list_page";

  //????????????????????????
  static final String consultingAllPage = "consultingAllPage";

  ///????????????-????????????
  static final String consultingRecordsPage = "consulting_records_page";

  static final List<GetPage> routes = [
    GetPage(name: main, page: () => IndexPage(currentIndex: 0)), //??????
    GetPage(name: noWifiPage, page: () => NoWifiPage()),
    GetPage(name: consultDetails, page: () => ConsultDetails()), //????????????
    GetPage(name: consultPage, page: () => ConsultPage()), //??????
    GetPage(name: feedbackPage, page: () => FeedBackPage()), //????????????
    GetPage(
        name: feedbackDetailPage, page: () => FeedBackDetailPage()), //??????????????????
    GetPage(
        name: consultEvaluatePage, page: () => ConsultEvaluatePage()), //????????????
    GetPage(name: appointmentPage, page: () => AppointmentPage()), //????????????
    GetPage(
        name: appointmentPayPage, page: () => AppointmentPayPage()), //??????????????????
    GetPage(name: paySuccessPage, page: () => PaySuccessPage()), //??????????????????
    GetPage(name: payFailPage, page: () => PayFailPage()), //??????????????????
    GetPage(
        name: consultQuestionPage,
        page: () => ConsultQuestionView()), //????????????????????????
    GetPage(name: order, page: () => OrderPage()), //??????
    GetPage(name: orderDetailsPage, page: () => OrderDetailsPage()), //????????????
    GetPage(name: drawbackPage, page: () => DrawbackPage()), //????????????
    GetPage(
        name: platformFeedbackPage,
        page: () => PlatformFeedbackPage()), //?????????????????????
    GetPage(name: couponPage, page: () => CouponPage()),
    GetPage(name: attentionPage, page: () => AttentionPage()), //????????????
    GetPage(name: setupPage, page: () => SetupPage()), //??????????????????
    GetPage(
      name: setupNamePage,
      page: () => SetupNamePage(),
    ), //????????????????????????
    GetPage(
        name: setupIntroductionPage,
        page: () => SetupIntroductionPage()), //??????????????????
    GetPage(name: customerPage, page: () => CustomerPage()), //????????????
    ///???????????????
    GetPage(name: homeCounselorInfo, page: () => HomeCounselorInfo()),
    GetPage(name: videoPage, page: () => VideoPage()), //??????????????????
    GetPage(name: consultingHomePage, page: () => ConsultingHomePage()), //????????????
    GetPage(name: consultingSetPage, page: () => ConsultingSetPage()), //????????????
    GetPage(
        name: settlementCenterPage,
        page: () => SettlementCenterPage()), //????????????-????????????
    GetPage(name: withdrawPage, page: () => WithdrawPage()), //??????
    GetPage(name: personalInfoPage, page: () => CounselorInfoPage()), //??????????????????
    GetPage(name: loginPage, page: () => LoginPage()), //??????????????????
    GetPage(name: goLoginPage, page: () => GoLoginPage(true)), //??????????????????
    GetPage(
        name: consultCounselorDetailsPage,
        page: () => ConsultCounselorDetailsPage()), //??????????????????????????????
    GetPage(name: paymentRecordsPage, page: () => PaymentRecordsPage()), //????????????
    GetPage(name: paymentDatailsPage, page: () => PaymentDatailsPage()), //????????????
    GetPage(name: userAgreementPage, page: () => UserAgreementPage()), //????????????
    GetPage(name: privacyPolicyPage, page: () => PrivacyPolicyPage()), //????????????
    GetPage(name: sdkAgreementPage, page: () => SdkAgreementPage()), //?????????SDK??????
    GetPage(name: phoneBindingPage, page: () => PhoneBindingPage()), //?????????SDK??????
    GetPage(name: joinUsPage, page: () => JoinUsPage()), //?????????????????????
    GetPage(name: orderDefaultPage, page: () => OrderDefaultPage()), //?????????????????????
    GetPage(name: myFansPage, page: () => MyFansPage()), //????????????
    GetPage(name: orderAllPage, page: () => OrderAllPage()), //????????????
    GetPage(name: consultALlPage, page: () => ConsultALlPage()), //????????????
    GetPage(
        name: consultingRecordsPage,
        page: () => ConsultingRecordsPage()), //????????????-????????????
    GetPage(
        name: consultingAllPage, page: () => ConsultingAllPage()), //????????????????????????
    GetPage(
        name: evaluateShowListPage,
        page: () => EvaluateShowListPage()), //??????????????????
  ];
}
