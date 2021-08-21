class AppConstant {
  ///待预约
  static const int APPOINTMENT_NO = 0;

  ///预约成功
  static const int APPOINTMENT_SUCCESS = 1;

  ///进行中
  static const int UNDERWAY = 2;

  ///已完成
  static const int FINISHED = 3;

  ///已取消
  static const int CANCEL = 4;

  ///已签到
  static const int SIGN_IN = 5;

  ///爽约
  static const int APOINTMENT_BREAK = 6;

  ///开始前5min可以点击开始咨询按钮
  static const int STARTTIME = 5;

  ///开始15min可以点击签到按钮
  static const int SIGNIN_STARTTIME = 15;

  ///权限缓存前缀
  static const String TOKEN_PREFIX = "Bearer ";

  ///咨询师角色标识
  static const String COUNSELOR_ROLE = "2";

  ///声网APPID
  static const String AG_APPID = "e0347e956a9d4e3897790ed67d5e8a8b";

  static const sex = ['男', '女', '保密'];
  static const education = ["高中以下", "高中", "大专", "本科", "硕士", "博士", "博士后", '其它'];
  static const professional = ['上班族', '宝妈', '在校生', '其他'];

  ///数据翻译
  static String statusMap(int status) {
    return _statusMap[status];
  }

  ///按钮名称显示
  static String btnNameMap(int status) {
    return _btnNameMap[status];
  }

  ///咨询师端按钮名称显示
  static String btnConsultNameMap(int status) {
    return _btnConsultNameMap[status];
  }

  ///咨询方式集合
  static String wayMap(int way) {
    return _wayMap[way];
  }

  /// 性别转化方法
  static String sexStr(int sex) {
    if (sex == null) return "保密";
    return _sexMap[sex];
  }

  ///订单状态
  static String orderStatus(int status) {
    return _orderStatusMap[status];
  }

  static const Map<int, String> _sexMap = {0: "男", 1: "女", 2: "保密"};
  static const Map<int, String> _btnNameMap = {
    0: "立即预约",
    1: "开始咨询",
    2: "咨询中",
    3: "已完成",
    5: "开始咨询",
    4: "已取消"
  };

  ///咨询师端咨询管理按钮显示名称
  static const Map<int, String> _btnConsultNameMap = {
    0: "未预约",
    1: "开始咨询",
    2: "咨询中",
    3: "已完成",
    5: "开始咨询",
    4: "已取消"
  };

  static const Map<int, String> _statusMap = {
    0: "未预约",
    1: "预约成功",
    2: "咨询中",
    3: "已完成",
    4: "已取消",
    5: "已签到",
    6: "爽约"
  };

  ///订单状态
  static const Map<int, String> _orderStatusMap = {
    0: "待付款",
    1: "已支付",
    2: "已取消",
    3: "申请退款",
    4: "已完成",
    5: "退款成功"
  };

  /// 手机号脱敏显示
  static String phoneDesensitization(String phoneNumber) {
    if (phoneNumber.isNotEmpty) {
      return phoneNumber.replaceFirst(new RegExp(r'\d{4}'), '****', 3);
    }
    return "";
  }

  ///微信支付方式
  static final int weChatPay = 1;

  ///支付宝支付
  static final int alipay = 2;

  ///视频咨询
  static final int videoWay = 1;

  ///语音咨询
  static final int voiceWay = 2;

  /// 语音+视频
  static final int wayAll = 9;

  static final Map<int, String> _payMap = {weChatPay: "微信支付", alipay: "支付宝"};
  static final Map<int, String> _wayMap = {
    0: "请选择",
    videoWay: "视频咨询",
    voiceWay: "语音咨询",
    9: "all"
  };

  ///获取咨询方式中文说明
  static String getWay(int way) {
    return _wayMap[way];
  }

  ///获取支付方式中文说明
  static String getPay(int pay) {
    return _payMap[pay];
  }
}
