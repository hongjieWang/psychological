import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/component/page/home/home_controller.dart';
import 'package:standard_app/component/page/home/home_counselor_view.dart';
import 'package:standard_app/component/page/home/home_screen_page.dart';
import 'package:standard_app/component/page/home/home_feedback_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/component/page/home/home_state.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:standard_app/util/style.dart';
import 'home_banner_view.dart';
import 'home_top_type.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController logic = Get.put(HomeController());
  final HomeState state = Get.find<HomeController>().state;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: StyleUtils.bgColor,
        body: Container(
          decoration: BoxDecoration(color: StyleUtils.bgColor),
          margin: EdgeInsets.only(top: 30),
          child: getMainView(),
        ),
        floatingActionButton: _showToTopBtn()));
  }

  ///返回顶部按钮
  Widget _showToTopBtn() {
    return state.showToTopBtn.isFalse
        ? null
        : FloatingActionButton(
            child: Icon(Icons.arrow_upward),
            onPressed: () {
              //返回到顶部时执行动画
              logic.controller.animateTo(.0,
                  duration: Duration(milliseconds: 1),
                  curve: Curves.easeInToLinear);
            },
          );
  }

  Widget getMainView() {
    return getScrollView();
  }

  getScrollView() {
    return RefreshIndicator(
      child: CustomScrollView(
          shrinkWrap: true,
          // 反弹效果
          physics: logic.onScreen(),
          controller: logic.controller,
          slivers: <Widget>[
            new SliverPadding(
                padding: const EdgeInsets.only(top: 0, bottom: 20),
                // 延迟初始化
                sliver: new SliverList(
                    delegate: new SliverChildListDelegate(<Widget>[
                  _search(),
                  SizedBox(
                    height: 40.sp,
                  ),
                  // 轮播图
                  HomeBanner(),
                  SizedBox(
                    height: 40.sp,
                  ),
                  // 金刚区分类
                  Offstage(
                    // true:隐藏  false:不隐藏
                    offstage: true,
                    child: TopTypeGridView(mTypeData: state.mTypeData),
                  ),
                  // 用户返回，横向列表
                  Offstage(
                    offstage: state.homeFeedback.isEmpty,
                    child: _title(),
                  ),
                  Offstage(
                    offstage: state.homeFeedback.isEmpty,
                    child:
                        HomeFeedbackView(homeFeedbackData: state.homeFeedback),
                  )
                ]))),
            stickyView(),
            new SliverPadding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                sliver: new SliverList(
                    delegate: new SliverChildListDelegate(
                        <Widget>[HomeCounselorPage()]))),
          ]),
      onRefresh: () async {
        logic.onRefresh();
      },
    );
  }

  // 吸顶效果
  stickyView() {
    return Obx(() => SliverAppBar(
          pinned: true,
          floating: true,
          snap: true,
          toolbarHeight: 80.sp,
          expandedHeight: state.toolbarHeight.value.sp,
          backgroundColor: StyleUtils.bgColor,
          flexibleSpace: Container(
            alignment: Alignment.center,
            child: HomeScreenPage(),
          ),
        ));
  }

  ///搜索框
  Widget _search() {
    return Container(
      padding: EdgeInsets.fromLTRB(32.sp, 30.sp, 32.sp, 0.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 610.sp,
            height: 60.sp,
            decoration: new BoxDecoration(
              color: Color(0xFFF3F6F8),
              borderRadius: BorderRadius.all(Radius.circular(30.0.sp)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Image.asset(
                    ImageUtils.getImgPath("seash3x"),
                    width: 34.r,
                    height: 34.r,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.sp),
                  child: Text(
                    "搜索",
                    style: TextStyle(color: Color(0xFFA3AAB0), fontSize: 13),
                  ),
                )
              ],
            ),
          ),
          Image.asset(
            ImageUtils.getImgPath("message3x"),
            width: 42.r,
            height: 42.r,
          )
        ],
      ),
    );
  }

  ///客户反馈标题页
  Widget _title() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: 32.sp),
        child: Text(
          "客户反馈",
          style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333)),
        ),
      )
    ]);
  }
}

class DrawLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: Text('drawer'));
  }
}
