class Api {
  static int success = 200;

  // static String baseUrl = 'http://121.5.223.16:9204/v1/';
  // static String baseUrl = 'http://192.168.2.134:8080/';
  static String baseUrl = 'https://julywhj.cn/gateway/';

  // static String baseUrl = 'https://706xinli.com/gateway/';
  static const String checkUpdate = "https://706xinli.com/apkUpload";

  ///WebSocket 服务地址
  static String ws = "ws://121.5.223.16:34567";

  ///发送验证码接口-鉴权平台
  static const String LOGIN_SEND_CODE_API = "/auth/sendCode";

  /// 获取banner 列表
  static const String BANNER_LIST_API = "/standard/banner/list";

  /// 短信登录接口
  static const String LOGIN_API = "/auth/login";

  ///微信登录接口
  static const String WECHAR_LOGIN_API = "/auth/weChar/userInfo/:code";

  /// 微信登录绑定手机号码
  static const String WECHAR_BINDING_PHONE_API = "/auth/weCharBindingPhone";

  ///匿名接口获取token
  static const String ANONYMOUS_API = "/auth/anonymous";

  ///首页评价接口
  static const String HOME_EVALUATE = "mobile/v1/evaluate/home";

  ///提交评价接口
  static const String PUSH_EVALUATE_API =
      "/mobile/v1/evaluate/pushEvaluateContent";

  ///咨询列表
  static const String CONSULT_API = "mobile/v1/consult/stay/:userId";

  ///查询全部咨询列表
  static const String CONSULT_ALL_API = "mobile/v1/consult/:userId";

  ///咨询列表，咨询师端
  static const String CONSULT_COUNSELOR_API =
      "mobile/v1/consult/counselor/:counselorId";

  ///咨询师端咨询列表
  static const String CONSULT_COUNSELOR_STAY_API =
      "mobile/v1/consult/counselor/stay/:counselorId";

  ///获取咨询师时间
  static const String CONSULT_TIME_API =
      "mobile/v1/counselor/getCounselorTime/:counselorId";

  ///提交咨询师配置
  static const String CONSULT_CONFIG_API =
      "mobile/v1/counselor/counselorConfig";

  ///获取咨询师列表
  static const String COUNSELOR_API = "mobile/v1/counselor/list";

  ///咨询师预约接口
  static const String COUNSELOR_APPOINTMENT_API = "mobile/v1/consult/apply";

  ///取消预约接口
  static const String COUNSELOR_APPOINTMENT_CANCEL_API =
      "mobile/v1/consult/cancel";

  ///根据咨询师ID获取咨询师详细信息
  static const String COUNSELOP_INFO_API =
      "mobile/v1/counselor/info/:counselorId";

  /// 根据用户ID获取用户信息
  static const String USER_INFO_API = "mobile/v1/members/info/:userId";

  /// 获取退款原因
  static const String GET_REFUND_TYPE_API = "mobile/v1/order/getRefundType";

  /// 咨询师首页关注/取消关注
  static const String FOCUS_ON_API = "standard/fans/focusOn";

  ///我的关注列表
  static const String FOCUS_LIST_API = "standard/fans/attentionId/:attentionId";

  ///查询是否已关注
  static const String GET_ISFOCUS_ON_API =
      "standard/fans/getIsFocusOn/:targetId/:attentionId";

  /// 提交订单
  static const String ORDER_API = "standard/v1/order";

  ///查询订单列表
  static const String GET_ORDER_LIST_API = "standard/v1/order/listByStatus";

  ///待付款订单付款操作
  static const String PAY_ORDER_PAY_MENT_API = "standard/v1/order/orderPayment";

  /// 咨询师管理-咨询师标签管理-擅长人群，擅长方式
  static const String COUNSELOR_LABELS_API =
      "mobile/v1/counselor/counselorGoodLabels";

  /// 咨询师管理-咨询师提交个人信息
  static const String COUNSELOR_CONFIG_API = "mobile/v1/counselor/mineInfo";

  ///更新用户名称
  static const String UPLOAD_USERNAME = "mobile/v1/members/uploadName";

  ///更新用户简介
  static const String UPLOAD_SIGNATURE = "mobile/v1/members/uploadSignature";

  ///更新用户职业
  static const String UPLOAD_PROFESSIONAL =
      "mobile/v1/members/uploadProfessional";

  /// 更新用户生日
  static const String UPLOAD_BIRTHDAY = "mobile/v1/members/uploadBirthday";

  /// 更新用户性别
  static const String UPLOAD_SEX = "mobile/v1/members/uploadSex";

  /// 更新用户头像
  static const String UPLOAD_AVATAR_API = "mobile/v1/members/uploadAvatar";

  ///更新用户地址
  static const String UPLOAD_ADDRESS = "mobile/v1/members/uploadLocation";

  ///意见反馈类型列表
  static const String FEEDBACK_LIST_API = "mobile/v1/feedback/list";

  ///提交意见反馈
  static const String FEEDBACK_ADD_API = "mobile/v1/feedback/add";

  ///获取评价评价标签
  static const String EVALUATE_LABEL_API = "/mobile/v1/evaluate/evaluateLabels";

  ///咨询师签到接口
  static const String SIGN_IN_API = "/mobile/v1/signIn/:crId";

  ///获取咨询详细预约信息
  static const String GET_ONSULT_DIES = "/mobile/v1/consult/consultById/:crId";

  ///文件上传API
  static const String FILE_UPLOAD_API = "/file/upload";

  ///***********************************咨询师管理端*******************/

  ///获取咨询师账户信息
  static const String GET_WALLET_INFO = "/pay/v1/wallet/info/:membersId";

  ///根据咨询师ID查询咨询师收支记录
  static const String GET_PAY_PAYMENTS_RECORDS_API = "/pay/payments/list";

  ///咨询师提现申请
  static const String PAY_WITHDRAWAL_APPLY_API = "/pay/withdrawalApply";

  ///咨询师退款申请
  static const String PAY_REFUND_APPLY_API =
      "/mobile/v1/order/createRefundApply";

  ///根据钱包查询支付方式
  static const String GET_PAY_WITHDRAWAL_WAY =
      "/pay/withdrawalWay/wayList/:walletNo";

  ///咨询管理/咨询记录
  static const String GET_CONSULTING_RECORDS =
      "mobile/v1/consult/getConsultingRecords";

  ///***********************************声网相关***********************/
  /// 调用平台申请通话token
  static const String APPLY_AG_TOKEN = "standard/ag/token/:channelName";

  ///聊天室开通时间
  static const String JOIN_CHANNEL_SUCCESS =
      "mobile/v1/agora/joinChannelSuccess";

  ///监听用户加入声网时间
  static const String USER_JOINED_API = "mobile/v1/agora/userJoined";

  ///用户离开时间
  static const String USER_OFFLINE_API = "mobile/v1/agora/userOffline";

  ///聊天室关闭时间
  static const String LEAVE_CHANNEL_API = "mobile/v1/agora/leaveChannel";

  ///*****************************消息管理*****************************/
  ///发送消息API
  static const String SNED_MESSAGE_API =
      "http://192.168.3.13:9400/api/message/sendApi";
}
