import 'package:get/get.dart';

///首页数据驱动
class HomeState {
  RxDouble toolbarHeight;
  RxInt index;
  RxList mBannerData;
  RxList mTypeData;
  RxBool screen;

  ///首页评价内容反馈数据
  RxList homeFeedback;

  RxList selectedThemeLablesData;
  RxString selectedSortData;

  ///咨询师总条数
  RxInt total;
  RxBool loading; //表尾标记
  RxBool showToTopBtn; //返回首页

  ///咨询师数据
  RxList counselorData;

  ///咨询师数据
  RxMap counselorInfo;
  RxInt pageNum;

  RxBool isShowScreen;

  ///显示或隐藏咨询师详细信息
  RxBool showCounselorInfo;

  /// 咨询师详情默认展开高度
  RxDouble expandedHeight;

  ///预约须知展开收起
  RxBool isShowText;

  ///是否关注
  RxBool isFocusOn;

  RxString selectText;
  HomeState() {
    toolbarHeight = 40.0.obs;
    index = 0.obs;
    mBannerData = [].obs;
    mTypeData = [].obs;
    homeFeedback = [].obs;
    selectedThemeLablesData = [].obs;
    screen = false.obs;
    selectedSortData = "".obs;
    total = 0.obs;
    counselorData = [].obs;
    pageNum = 1.obs;
    loading = true.obs;
    showToTopBtn = false.obs;
    isShowScreen = false.obs;
    showCounselorInfo = true.obs;
    expandedHeight = 0.4.obs;
    isShowText = false.obs;
    counselorInfo = {}.obs;
    isFocusOn = false.obs;
    selectText = "今日可预约".obs;
  }

  final List lables = [
    {"id": "00", "value": "全部"},
    {"id": "01", "value": "恋爱情感"},
    {"id": "02", "value": "恋爱情感"},
    {"id": "03", "value": "恋爱情感"},
    {"id": "04", "value": "恋爱情感"},
    {"id": "05", "value": "恋爱情感"},
    {"id": "06", "value": "恋爱情感"},
    {"id": "07", "value": "恋爱情感"},
    {"id": "07", "value": "恋爱情感"},
    {"id": "07", "value": "恋爱情感"},
    {"id": "07", "value": "恋爱情感"},
    {"id": "07", "value": "恋爱情感"}
  ];
}
