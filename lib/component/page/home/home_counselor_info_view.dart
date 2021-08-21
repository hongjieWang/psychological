import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/common/cross_datetime.dart';
import 'package:standard_app/component/common/data_statistics.dart';
import 'package:standard_app/component/page/home/home_controller.dart';
import 'package:standard_app/component/page/home/home_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/style.dart';
import 'home_feedback_view.dart';

class HomeCounselorInfo extends StatefulWidget {
  @override
  _HomeCounselorInfoState createState() => _HomeCounselorInfoState();
}

class _HomeCounselorInfoState extends State<HomeCounselorInfo> {
  final HomeController logic = Get.put(HomeController());
  final HomeState state = Get.find<HomeController>().state;
  final List times = [];
  final dataKey = new GlobalKey();

  //是否点击评价
  bool isSelectedKey = false;
  final ScrollController _myController = ScrollController();

  @override
  void initState() {
    super.initState();
    state.counselorInfo.value = Get.arguments;
    times.addAll(Get.arguments['data']);
    ApiService()
        .getIsfocusOn(state.counselorInfo['membersId'], Global.getUserId())
        .then((value) => {
              if (value['code'] == Api.success)
                {state.isFocusOn.value = value['data'] == 1}
            });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  /// 咨询师详情
  Widget _body() {
    return Scaffold(
      backgroundColor: Color(0xFFF5FAFD), //把scaffold的背景色改成透明
      body: NestedScrollView(
          controller: _myController,
          headerSliverBuilder: _sliverBuilder,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_rollingList(), _bottomBtn()],
          )),
    );
  }

  Widget _rollingList() {
    return Expanded(
      // 这个页面是要滑动的，所以用Expanded
      child: SingleChildScrollView(
        child: Column(children: [
          Offstage(
            offstage: state.homeFeedback.isEmpty,
            child: getTabs(),
          ),
          SizedBox(
            height: 1,
          ),
          _consultingWay(),
          _appointment(),
          Offstage(
            offstage: state.homeFeedback.isEmpty,
            child: _userFeedbackView(),
          ),
          _appointmentInstructions(),
        ]),
      ),
    );
  }

  ///咨询评价列表
  Widget getTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 1.0), //阴影y轴偏移量
              blurRadius: 0, //阴影模糊程度
              spreadRadius: 0 //阴影扩散程度
              )
        ],
      ),
      width: double.infinity,
      height: 52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {
                setState(() {
                  isSelectedKey = !isSelectedKey;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "咨询",
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  isSelectedKey
                      ? Container()
                      : Container(
                          color: Colors.blue,
                          height: 2,
                          width: 80.sp,
                        )
                ],
              )),
          InkWell(
              onTap: () {
                setState(() {
                  // Scrollable.ensureVisible(dataKey.currentContext);
                  _myController
                      .jumpTo(_myController.position.maxScrollExtent + 500);
                  isSelectedKey = !isSelectedKey;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "评价",
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  isSelectedKey
                      ? Container(
                          color: Colors.blue,
                          height: 2,
                          width: 80.sp,
                        )
                      : Container()
                ],
              ))
        ],
      ),
    );
  }

  /// 用户评价
  Widget _userFeedbackView() {
    return Column(
      key: dataKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(40.sp, 10.sp, 30.sp, 0.sp),
          child: Text(
            "用户评价",
            style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
          ),
        ),
        HomeFeedbackView(homeFeedbackData: state.homeFeedback),
        SizedBox(height: 20.sp)
      ],
    );
  }

  /// 预约须知
  Widget _appointmentInstructions() {
    return Container(
        width: 750.sp,
        height: 550.sp,
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.sp))),
            margin: EdgeInsets.fromLTRB(20.sp, 10.sp, 20.sp, 10.sp),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20.sp, 10.sp, 20.sp, 10.sp),
                      child: Text("预约须知",
                          style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: StyleUtils.fontColor_3))),
                  Padding(
                    padding: EdgeInsets.only(left: 20.sp),
                    child: Text(
                      "回应时长",
                      style: TextStyle(
                          fontSize: 28.sp, color: StyleUtils.fontColor_3),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.sp, top: 10.sp),
                    child: Text(
                      "我们将在收到订单后，2小时内进行回应（APP/短信/电话 反馈预约结果）。",
                      style: TextStyle(
                          fontSize: 22.sp, color: StyleUtils.fontColor_6),
                    ),
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.sp),
                    child: Text(
                      "变更预约",
                      style: TextStyle(
                          fontSize: 28.sp, color: StyleUtils.fontColor_3),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.sp, top: 10.sp),
                    child: Text(
                      "在不可抗力需要变更/取消的咨询预约，请务必提前12小时联系咨询师或平台客服，否则咨询将如期开始。",
                      style: TextStyle(
                          fontSize: 22.sp, color: StyleUtils.fontColor_6),
                    ),
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.sp),
                    child: Text(
                      "爽约/迟到",
                      style: TextStyle(
                          fontSize: 28.sp, color: StyleUtils.fontColor_3),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.sp, top: 10.sp),
                    child: Text(
                      "若未提前12小时告知，爽约/迟到都视为咨询如期进行，费用正常收取。其他情况需与平台客服协商处理。",
                      style: TextStyle(
                          fontSize: 22.sp, color: StyleUtils.fontColor_6),
                    ),
                  ),
                ],
              ),
            )));
  }

  /// 预约时间显示
  Widget _appointment() {
    return Container(
        width: 750.sp,
        height: 500.sp,
        child: Container(
            decoration: new BoxDecoration(
                //背景
                border: Border.all(
                  color: Colors.grey[300],
                  width: 1.0.sp,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.sp))),
            margin: EdgeInsets.fromLTRB(20.sp, 10.sp, 20.sp, 10.sp),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20.sp, 10.sp, 20.sp, 10.sp),
                      child: Text("预约时段",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500))),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20.sp, 10.sp, 20.sp, 10.sp),
                      child: CrossDateTime(
                        title: '申请调整时间',
                        dateList: times,
                        selected: [],
                        onClickFun: print,
                      ))
                ],
              ),
            )));
  }

  ///咨询方式
  Widget _consultingWay() {
    return Container(
      decoration: new BoxDecoration(
        //背景
        color: Colors.white,
      ),
      padding: EdgeInsets.fromLTRB(30.sp, 10.sp, 30.sp, 10.sp),
      child: Column(children: _consultingWayItems()),
    );
  }

  ///咨询方式列表
  List<Widget> _consultingWayItems() {
    List combos = state.counselorInfo['combos'].toList();
    List<Widget> list = [];
    if (combos.length != 0) {
      combos.forEach((element) {
        list.add(_videoView(element));
      });
    }
    return list;
  }

  ///视频咨询
  Widget _videoView(element) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              child: Container(
                padding: EdgeInsets.all(10.0.sp),
                child: InkWell(
                    child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(10)),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    element['coverImg'],
                    width: 39 * 2.sp,
                    height: 39 * 2.sp,
                    fit: BoxFit.cover,
                  ),
                )),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        element['comboName'],
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 30.sp,
                      ),
                      Text("${element['originalPrice']}",
                          style: TextStyle(
                              fontSize: 15, color: Color(0xFFFFA217))),
                      Text(
                        "元/次",
                        style: TextStyle(fontSize: 9, color: Color(0xFF454545)),
                      )
                    ]),
                SizedBox(height: 10.sp),
                Text(
                  "与咨询师进行${element['courseDuration']}分钟${element['comboName']}",
                  style: TextStyle(color: Color(0xFF666666), fontSize: 11),
                )
              ],
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            DataStatistics.instance.event("counselor_info_appointment",
                {"comboName": element['comboName']});
            logic.onClickAppointmentPayPage(
                {"combo": element, "item": state.counselorInfo});
          },
          child:
              Text("可预约", style: TextStyle(color: Colors.white, fontSize: 11)),
          style: ButtonStyle(
            side: MaterialStateProperty.all(
                BorderSide(color: Color(0xFFFFA217), width: 1)),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return Color(0xFFFFA217);
            }),
            shape: MaterialStateProperty.all(StadiumBorder()),
            padding: MaterialStateProperty.all(EdgeInsets.all(3)),
            minimumSize: MaterialStateProperty.all(Size(65, 22)),
          ),
        ),
      ],
    );
  }

  ///咨询师详细信息-背景及其评价分数等
  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return [
      Obx(
        () => SliverAppBar(
            title: Text(""),
            elevation: 0,
            backgroundColor: Colors.white,
            leading: new IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Get.back();
              },
            ),
            centerTitle: true,
            //标题居中
            expandedHeight: state.expandedHeight.value.sh,
            //展开高度200
            floating: true,
            //不随着滑动隐藏标题
            pinned: false,
            //不固定在顶部
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: _counselorInfo(),
            )),
      ),
    ];
  }

  ///咨询师详细信息
  Widget _counselorInfo() {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(state.counselorInfo['members']['avatar']),
          fit: BoxFit.cover,
        )),
        width: double.infinity,
        child: Obx(() => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 170 * 2.sp,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.3)),
                    child: Column(
                      children: [
                        _counselorName(),
                        SizedBox(
                          height: 32.sp,
                        ),
                        _infoBtn(),
                        _numberOfEvaluationConsultantsView(),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    decoration: BoxDecoration(color: Color(0xFFF5FAFD)),
                  )
                ],
              ),
            )));
  }

  /// 咨询师姓名标签展示
  Widget _counselorName() {
    return Container(
      padding: EdgeInsets.fromLTRB(30.sp, 0.sp, 0.sp, 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("${state.counselorInfo['members']['membersName']}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.check_circle,
                color: Colors.orangeAccent,
                size: 15.59,
              )
            ],
          ),
          SizedBox(height: 5),
          Text(
            "${state.counselorInfo['aptitudes']}",
            style: TextStyle(color: Colors.white, fontSize: 13),
          ), //咨询师资质
          SizedBox(
            height: 5,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: _labels(),
            ),
            // Padding(
            //   padding: EdgeInsets.only(right: 30.sp),
            //   child: Text(
            //       "粉丝 ${state.counselorInfo['members']['fans']} | 访客 ${state.counselorInfo['members']['visitorNum']}",
            //       style: TextStyle(color: Colors.white, fontSize: 8)),
            // )
          ])
        ],
      ),
    );
  }

  ///咨询师标签集合
  List<Widget> _labels() {
    print(state.counselorInfo['goodFieldEntities']);
    List<Widget> lables = [];
    if (state.counselorInfo['goodFieldEntities'] == null) {
      lables.add(Container());
      return lables;
    } else {
      List aa = state.counselorInfo['goodFieldEntities'];
      aa.forEach((element) {
        lables.add(Container(
          decoration: BoxDecoration(
            color: Color(0xFF999999),
            borderRadius: new BorderRadius.all(new Radius.circular(20.0.sp)),
          ),
          width: 100.sp,
          height: 34.sp,
          child: Center(
              child: Text(
            "${element['counselorLabelName']}",
            style: TextStyle(color: Colors.white, fontSize: 8),
          )),
        ));
        lables.add(SizedBox(width: 10));
      });
    }
    return lables;
  }

  ///详细信息按钮
  Widget _infoBtn() {
    return Center(
        child: Padding(
            padding: EdgeInsets.only(bottom: 20.sp),
            child: InkWell(
                onTap: () {
                  DataStatistics.instance
                      .event("showCounselorInfo", {"name": "点击详细信息"});
                  showModalBottomSheet(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              height: 30.0,
                              width: double.infinity,
                              color: StyleUtils.bgColor,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )),
                            ),
                            Container(child: _showCounselor()),
                          ],
                        );
                      });
                },
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 11, color: Colors.white),
                    children: [
                      TextSpan(
                        text: '详细信息',
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.expand_more,
                          color: Colors.white,
                          size: 30.sp,
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  ///展开咨询师详细内容
  Widget _showCounselor() {
    print(state.counselorInfo.toJson());
    return Container(
      width: 1.sw,
      margin: EdgeInsets.fromLTRB(16.sp, 20.sp, 32.sp, 0.sp),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.sp),
            child: Text(
              "个人介绍",
              style: TextStyle(
                  color: Color(0xFF454545),
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 50.sp,
          ),
          Text(
            "【基本理念】",
            style: TextStyle(color: Color(0xFF80ADEA), fontSize: 26.sp),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sp),
            child: _value(state.counselorInfo['idea']),
          ),
          Text(
            "【咨询技术】",
            style: TextStyle(color: Color(0xFF80ADEA), fontSize: 26.sp),
          ),
          Padding(
              padding: EdgeInsets.only(left: 16.sp),
              child: _value(state.counselorInfo['technical'])),
          Text(
            "【工作领域】",
            style: TextStyle(color: Color(0xFF80ADEA), fontSize: 26.sp),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sp),
            child: _value(state.counselorInfo['workArea']),
          ),
          Text(
            "【从业年限】",
            style: TextStyle(color: Color(0xFF80ADEA), fontSize: 26.sp),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sp),
            child: _value("${state.counselorInfo['businessAge']} 年"),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sp),
            child: Text(
              "专业资质",
              style: TextStyle(
                  color: Color(0xFF454545),
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 24.sp,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sp),
            child: Text(
              "从业资质",
              style: TextStyle(
                  color: Color(0xFF454545),
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sp),
            child: _value(state.counselorInfo['aptitudes']),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sp),
            child: Text(
              "擅长领域",
              style: TextStyle(
                  color: Color(0xFF454545),
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sp),
            child: _value(goodFieldEntities()),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sp),
            child: Text(
              "咨询人群",
              style: TextStyle(
                  color: Color(0xFF454545),
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sp),
            child: _value(crowdEntities()),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sp),
            child: Text(
              "擅长疗法",
              style: TextStyle(
                  color: Color(0xFF454545),
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sp),
            child: _value(state.counselorInfo['goodWay']),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sp, top: 60.sp, right: 32.sp),
            child: Text("咨询师本人承诺以上资料全部属实，接受公众监督，并为此承担相应的法律自认。如发现虚假信息，可联系客服反馈。",
                style: TextStyle(fontSize: 11, color: Color(0xFF999999))),
          ),
          SizedBox(
            height: 20,
          )
        ],
      )),
    );
  }

  ///擅长方式
  String goodFieldEntities() {
    String str = "";
    List goodFieldEntities = state.counselorInfo['goodFieldEntities'];
    if (goodFieldEntities != null) {
      goodFieldEntities.forEach((element) {
        str = str + element['counselorLabelName'] + "、";
      });
    }
    return str.substring(0, str.length - 1);
  }

  ///擅长人群
  String crowdEntities() {
    String str = "";
    List goodFieldEntities = state.counselorInfo['crowdEntities'];
    if (goodFieldEntities != null) {
      goodFieldEntities.forEach((element) {
        str = str + element['counselorLabelName'] + "、";
      });
    }
    return str.substring(0, str.length - 1);
  }

  Widget _value(value) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.sp, 20.sp, 0.sp, 10.sp),
        child: Text(
          value != null ? value : "",
          style: TextStyle(color: Color(0xFF666666), fontSize: 20.sp),
        ));
  }

  /// 咨询师评价分数-咨询人数展示模块
  Widget _numberOfEvaluationConsultantsView() {
    return Container(
        width: double.infinity,
        height: 154.sp,
        decoration: new BoxDecoration(
          //背景
          color: Colors.white,
          //设置四周圆角 角度
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0.sp),
              topRight: Radius.circular(20.0.sp)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(32.sp, 20.sp, 32.sp, 40.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Text(
                      "${state.counselorInfo['evaluationScore']}",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFA217)),
                    ),
                    SizedBox(
                      width: 6.sp,
                    ),
                    _rating(state.counselorInfo['evaluationScore'] == 0
                        ? 5.0
                        : state.counselorInfo['evaluationScore'])
                  ]),
                  Text(
                    "全部评价",
                    style: _minText(),
                  )
                ],
              ),
              SizedBox(
                width: 20.sp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${state.counselorInfo['serviceTime']}",
                      style: _numText()),
                  Text(
                    "服务时长(小时)",
                    style: _minText(),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${state.counselorInfo['helpNumber']}",
                    style: _numText(),
                  ),
                  Text(
                    "帮助人数",
                    style: _minText(),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  ///小字样式
  TextStyle _minText() {
    return TextStyle(fontSize: 10, color: Color(0xFF666666));
  }

  ///数字样式
  TextStyle _numText() {
    return TextStyle(fontSize: 24, fontWeight: FontWeight.w500);
  }

  ///咨询师详情页面底部按钮
  Widget _bottomBtn() {
    return Obx(() => Offstage(
        offstage: !state.showCounselorInfo.value,
        child: Container(
            decoration: new BoxDecoration(
              //背景
              color: Colors.white,
            ),
            child: Column(children: [
              Divider(
                color: Colors.black54,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(40.sp, 0.sp, 40.sp, 30.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        child: InkWell(
                            onTap: () => {
                                  DataStatistics.instance.event("focus_on", {
                                    "name": state.counselorInfo['members']
                                        ['membersName']
                                  })
                                },
                            child: InkWell(
                              onTap: () {
                                print("点击关注");
                                state.isFocusOn.value = !state.isFocusOn.value;
                                logic.focusOn();
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    state.isFocusOn.value
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 50.sp,
                                    color: state.isFocusOn.value
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  Text(
                                    state.isFocusOn.value ? "取消关注" : "关注",
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      TextButton(
                        child: Text(
                          "咨询顾问",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Get.toNamed(RouteConfig.customerPage);
                          DataStatistics.instance.event(
                              "consultant", {"userId": Global.getUserId()});
                        },
                        style: _buttonStyle(Color(0xFFF2C13B)),
                      ),
                      TextButton(
                        child: Text(
                          "立即预约",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          DataStatistics.instance.event(
                              "appointment_immediately", {
                            "counselorName": state.counselorInfo['members']
                                ['membersName']
                          });
                          logic.onClickAppointmentPayPage(
                              {"combo": {}, "item": state.counselorInfo});
                        },
                        style: _buttonStyle(Color(0xFF3A8DFF)),
                      )
                    ],
                  ))
            ]))));
  }

  ///底部按钮样式
  ButtonStyle _buttonStyle(Color color) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        //默认不使用背景颜色
        return color;
      }),
      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
      //设置按钮的大小
      minimumSize: MaterialStateProperty.all(Size(122 * 2.sp, 70.sp)),
      shape: MaterialStateProperty.all(StadiumBorder()),
    );
  }

  ///评分组件
  Widget _rating(_ratingSource) {
    return Padding(
      padding: EdgeInsets.zero,
      child: RatingBarIndicator(
        rating: _ratingSource,
        itemSize: 30.0.sp,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
      ),
    );
  }
}
