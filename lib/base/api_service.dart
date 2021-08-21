import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/http/dio_util.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/Toasts.dart';
import 'package:standard_app/util/dialog.dart';

import 'api.dart';

class ApiService {
  static DioUtil _dio;

  ApiService() {
    _dio = DioUtil();
  }

  /// 发送验证码
  Future<Map<String, dynamic>> loginSendCode(String phone) {
    Map data = {
      "phone": phone,
      "deviceId": Global.getDeviceId(),
      "platform": Global.getPlatform()
    };
    return _dio.post(Api.LOGIN_SEND_CODE_API, data: data);
  }

  void _success() {
    Get.offAllNamed(RouteConfig.main);
  }

  void _fail() {
    Toasts.show("手机号或验证码错误，请重新登录...");
    Get.back();
  }

  /// 登录接口
  login(Map loginData) {
    showLoading2();
    _dio.post(Api.LOGIN_API, data: loginData).then((value) => {
          Global.setPhone(loginData['username']),
          _loginActin(value, _success, _fail)
        });
  }

  /// 微信登录
  weCharlogin(String code) {
    _dio.get(Api.WECHAR_LOGIN_API, pathParams: {"code": code}).then((value) => {
          print(value),
          if (value['code'] == Api.success)
            {_loginActin(value, _success, _fail)}
          else
            {
              if (value['msg'] == "用户信息未注册")
                {
                  Get.toNamed(RouteConfig.phoneBindingPage,
                      arguments: value['data'])
                }
            }
        });
  }

  ///微信绑定手机号码并登录
  void weCharBindingPhoneAndLogin(data) {
    _dio.post(Api.WECHAR_BINDING_PHONE_API, data: data).then((value) => {
          if (value['code'] == Api.success)
            {_loginActin(value, _success, _fail)}
          else
            {Toasts.error("服务异常请您稍后重试")}
        });
  }

  ///匿名用户申请token
  anonynouslogin() {
    _dio.post(Api.ANONYMOUS_API, data: {"deviceId": Global.getDeviceId()}).then(
        (value) => {
              Global.setToken(value['data']['access_token']),
            });
  }

  ///登录成功设置token
  void _loginActin(data, Function success, Function fail) {
    if (data['code'] == 200) {
      String token = data['data']['access_token'];
      String userId = data['data']['user_id'];
      Global.setToken(token);
      Global.setUserId(userId);
      success();
    } else {
      fail();
    }
  }

  ///获取登录用户信息
  Future<Map<String, dynamic>> getUserInfo() {
    String userId = "0";
    if (Global.getUserId() != "null") {
      userId = Global.getUserId();
    }
    return _dio.get(Api.USER_INFO_API, pathParams: {"userId": userId});
  }

  Future<Map<String, dynamic>> counselorList(int pageNum) {
    return _dio.get(Api.COUNSELOR_API,
        data: {'pageNum': pageNum, 'pageSize': '10', 'counselorStatus': '2'});
  }

  ///获取banner列表
  Future<Map<String, dynamic>> getBannerList() {
    return _dio.get(Api.BANNER_LIST_API);
  }

  ///获取退款原因
  Future<Map<String, dynamic>> getRefundTypeList() {
    return _dio.get(Api.GET_REFUND_TYPE_API);
  }

  /// 获取咨询师详细信息
  Future<Map<String, dynamic>> getCounselorInfoService(String counselorId) {
    return _dio
        .get(Api.COUNSELOP_INFO_API, pathParams: {"counselorId": counselorId});
  }

  /// 获取咨询师日期配置
  Future<Map<String, dynamic>> getConsultTiemService(String counselorId) {
    return _dio
        .get(Api.CONSULT_TIME_API, pathParams: {"counselorId": counselorId});
  }

  /// 获取咨询师标签（擅长方式、擅长人群）
  Future<Map<String, dynamic>> getLabelsService() {
    return _dio.get(Api.COUNSELOR_LABELS_API);
  }

  /// 获取咨询师标签（擅长方式、擅长人群）
  Future<Map<String, dynamic>> postCounselorMineInfo(Map info) {
    return _dio.post(Api.COUNSELOR_CONFIG_API, data: info);
  }

  /// 更新用户名
  Future<Map<String, dynamic>> uploadName(String name) {
    return _dio.post(Api.UPLOAD_USERNAME,
        data: {"id": Global.getUserId(), "nickName": name});
  }

  ///更新用户职业
  Future<Map<String, dynamic>> uploadProfessional(String industry) {
    return _dio.post(Api.UPLOAD_PROFESSIONAL,
        data: {"id": Global.getUserId(), "industry": industry});
  }

  /// 更新用户签名
  Future<Map<String, dynamic>> uploadSignature(String signature) {
    return _dio.post(Api.UPLOAD_SIGNATURE,
        data: {"id": Global.getUserId(), "signature": signature});
  }

  /// 更新用户签名
  Future<Map<String, dynamic>> uploadBirthday(String birthdayStr) {
    return _dio.post(Api.UPLOAD_BIRTHDAY,
        data: {"id": Global.getUserId(), "birthdayStr": birthdayStr});
  }

  ///更新用户性别
  Future<Map<String, dynamic>> uploadSex(String sex) {
    return _dio
        .post(Api.UPLOAD_SEX, data: {"id": Global.getUserId(), "sex": sex});
  }

  ///更新用户头像
  Future<Map<String, dynamic>> uploadAvatar(String avatar) {
    return _dio.post(Api.UPLOAD_AVATAR_API,
        data: {"id": Global.getUserId(), "avatar": avatar});
  }

  /// 更新用户地址
  Future<Map<String, dynamic>> uploadLocation(String province, String city) {
    return _dio.post(Api.UPLOAD_ADDRESS,
        data: {"id": Global.getUserId(), "province": province, "city": city});
  }

  ///申请声网token
  Future<Map<String, dynamic>> applyAgToken(String channelName) {
    return _dio
        .get(Api.APPLY_AG_TOKEN, pathParams: {'channelName': channelName});
  }

  ///查询用户订单
  Future<Map<String, dynamic>> getOrderList(int pageNum, String orderStatus) {
    return _dio.get(Api.GET_ORDER_LIST_API, data: {
      'orderStatus': orderStatus,
      'pageNum': pageNum,
      'pageSize': '10',
      'membersId': Global.getUserId()
    });
  }

  ///查询用户订单
  Future<Map<String, dynamic>> getOrderListAll(int pageNum) {
    return _dio.get(Api.GET_ORDER_LIST_API, data: {
      'pageNum': pageNum,
      'pageSize': '10',
      'membersId': Global.getUserId()
    });
  }

  ///代付款订单付款接口
  Future<Map<String, dynamic>> payOrderPayment(data) {
    return _dio.post(Api.PAY_ORDER_PAY_MENT_API, data: data);
  }

  ///获取意见反馈类型
  Future<Map<String, dynamic>> getFeedbackList() {
    return _dio.get(Api.FEEDBACK_LIST_API);
  }

  ///获取意见反馈类型
  Future<Map<String, dynamic>> addFeedback(data) {
    return _dio.post(Api.FEEDBACK_ADD_API, data: data);
  }

  ///获取评价标签接口
  Future<Map<String, dynamic>> getEvaluateLabels() {
    return _dio.get(Api.EVALUATE_LABEL_API);
  }

  ///提交用户评价接口
  Future<Map<String, dynamic>> pushEvaluate(data) {
    return _dio.post(Api.PUSH_EVALUATE_API, data: data);
  }

  ///提交用户评价接口
  Future<Map<String, dynamic>> signIn(crId) {
    return _dio.get(Api.SIGN_IN_API, pathParams: {"crId": crId});
  }

  ///获取咨询列表-咨询师端
  Future<Map<String, dynamic>> getConsultCounselor(pageNum) {
    return _dio.get(Api.CONSULT_COUNSELOR_API,
        pathParams: {"counselorId": Global.getCounselorId()},
        data: {'pageNum': pageNum, 'pageSize': '10'});
  }

  //咨询师端待咨询列表
  Future<Map<String, dynamic>> getConsultCounselorStay(pageNum) {
    return _dio.get(Api.CONSULT_COUNSELOR_STAY_API,
        pathParams: {"counselorId": Global.getCounselorId()},
        data: {'pageNum': pageNum, 'pageSize': '10'});
  }

  /// 咨询师管理/咨询记录
  Future<Map<String, dynamic>> getConsultingRecords(pageNum) {
    return _dio.get(Api.GET_CONSULTING_RECORDS, data: {
      'pageNum': pageNum,
      'pageSize': '10',
      'counselorId': Global.getCounselorId(),
      'status': 3
    });
  }

  ///获取咨询详细信息
  Future<Map<String, dynamic>> getConsultDetail(crId) {
    return _dio.get(Api.GET_ONSULT_DIES, pathParams: {"crId": crId});
  }

  ///获取咨询详细信息
  Future<Map<String, dynamic>> fileUpload(data) {
    return _dio.post(Api.FILE_UPLOAD_API, data: data);
  }

  ///取消预约
  Future<Map<String, dynamic>> appointmentTimeCancel(data) {
    return _dio.post(Api.COUNSELOR_APPOINTMENT_CANCEL_API, data: data);
  }

  ///咨询师关注
  Future<Map<String, dynamic>> focusOn(data) {
    return _dio.post(Api.FOCUS_ON_API, data: data);
  }

  ///咨询师关注
  Future<Map<String, dynamic>> focusList() {
    return _dio.get(Api.FOCUS_LIST_API,
        pathParams: {"attentionId": Global.getUserId()});
  }

  ///查询关注状态
  Future<Map<String, dynamic>> getIsfocusOn(targetId, attentionId) {
    return _dio.get(Api.GET_ISFOCUS_ON_API,
        pathParams: {"targetId": targetId, "attentionId": attentionId});
  }

  ///加入聊天室监听
  Future<Map<String, dynamic>> joinChannelSuccess(data) {
    return _dio.post(Api.JOIN_CHANNEL_SUCCESS, data: data);
  }

  ///加入聊天室监听
  Future<Map<String, dynamic>> userJoined(data) {
    return _dio.post(Api.USER_JOINED_API, data: data);
  }

  ///离开聊天室监听
  Future<Map<String, dynamic>> userOffline(data) {
    return _dio.post(Api.USER_OFFLINE_API, data: data);
  }

  ///关闭聊天室监听
  Future<Map<String, dynamic>> leaveChannel(data) {
    return _dio.post(Api.LEAVE_CHANNEL_API, data: data);
  }

  ///获取当前登录用户钱包信息
  Future<Map<String, dynamic>> getWalletInfo() {
    return _dio.get(Api.GET_WALLET_INFO,
        pathParams: {"membersId": Global.getUserId()});
  }

  ///获取收支明细
  Future<Map<String, dynamic>> getPaymentsRecords(int walletNo, int pageNum) {
    return _dio.get(Api.GET_PAY_PAYMENTS_RECORDS_API, data: {
      'walletNo': walletNo,
      'pageNum': pageNum,
      'pageSize': '10',
    });
  }

  ///咨询师提现申请
  Future<Map<String, dynamic>> payWithdrawalApply(data) {
    return _dio.post(Api.PAY_WITHDRAWAL_APPLY_API, data: data);
  }

  ///咨询师申请
  Future<Map<String, dynamic>> payRefundApply(data) {
    return _dio.post(Api.PAY_REFUND_APPLY_API, data: data);
  }

  ///获取提现方式
  Future<Map<String, dynamic>> getPayWithdrawalWayByWalletNo(walletNo) {
    return _dio
        .get(Api.GET_PAY_WITHDRAWAL_WAY, pathParams: {"walletNo": walletNo});
  }

  ///发送消息
  Future sendMessage(data) {
    Dio dio = new Dio();
    return dio.post(Api.SNED_MESSAGE_API, data: data);
  }
}
