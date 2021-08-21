import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/common/data_statistics.dart';
import 'package:standard_app/component/common/go_login_page.dart';
import 'package:standard_app/component/default/no_data_page.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/service/consult_service.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:standard_app/util/style.dart';
import 'package:standard_app/util/time_utils.dart';

import 'consult_controller.dart';
import 'consult_state.dart';

///咨询管理页面
class ConsultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConsultPageState();
  }
}

class _ConsultPageState extends State<ConsultPage> {
  final ConsultController logic = Get.put(ConsultController());
  final ConsultState state = Get.find<ConsultController>().state;
  bool loading = true; //表尾标记
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮
  ScrollController _controller = new ScrollController();
  List _consultList = [];
  int _pageNum = 1;
  int _total = 0;

  @override
  void initState() {
    super.initState();
    _handlerRefresh();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _retrieveData();
      }
    });
  }

  ///下拉刷新
  Future<void> _handlerRefresh() async {
    _pageNum = 1;
    loading = true;
    consultList(_pageNum).then((value) => {
          setState(() {
            _consultList.clear();
            if (value['rows'] != null) {
              _consultList.addAll(value['rows']);
            }
            _total = value['total'];
          })
        });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = Global.getUserId() == '0' || Global.getUserId() == "null";
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "我的咨询",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: _onClickAll,
                child: Text(
                  "全部",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                style: ButtonStyle(
                  textStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 32.sp)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                )),
          ]),
      body: RefreshIndicator(
          onRefresh: () => _handlerRefresh(),
          child: getBody(isLogin, _consultList.length == 0)),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                //返回到顶部时执行动画
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 1),
                    curve: Curves.easeInToLinear);
              }),
    );
  }

  Widget getBody(isLogin, isHasData) {
    if (isLogin) {
      return GoLoginPage(false);
    } else if (isHasData) {
      return NoDataDefaultPage();
    } else {
      return hasData();
    }
  }

  ///有数据
  Container hasData() {
    return Container(
      color: StyleUtils.bgColor,
      padding: EdgeInsets.only(top: 10.0),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        itemCount: _consultList.length,
        controller: _controller,
        itemBuilder: (BuildContext context, int index) {
          if (this._total > _consultList.length &&
              _consultList.length - 1 == index) {
            //加载时显示loading
            return Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(strokeWidth: 2.0)),
            );
          } else if (this._total == _consultList.length &&
              _consultList.length == index) {
            this.loading = false;
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ));
          }
          //显示单词列表项
          return _consultItem(_consultList[index]);
        },
        separatorBuilder: (context, index) => Divider(height: .0),
      ),
    );
  }

  ///单个咨询框
  Widget _consultItem(item) {
    return InkWell(
      onTap: () {
        _onClickConsultantDetails(item);
      },
      child: Container(
        width: 1.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_time(item), _item(item)],
        ),
      ),
    );
  }

  ///预约按钮
  Widget _appointmentBtn(item) {
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      child: TextButton(
        onPressed: () {
          logic.onFunction(item);
        },
        child: Text(
          AppConstant.btnNameMap(item['status']),
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              //设置按下时的背景颜色
              if (states.contains(MaterialState.pressed)) {
                return Colors.blue[900];
              }
              //默认不使用背景颜色
              return logic.onBtnStatus(item)
                  ? Color(0xFF5191E8)
                  : Colors.black26;
            }),
            minimumSize: MaterialStateProperty.all(Size(140.sp, 50.sp)),
            padding: MaterialStateProperty.all(EdgeInsets.all(6.sp)),
            shape: MaterialStateProperty.all(StadiumBorder())),
      ),
    );
  }

  ///预约管理
  Widget _time(item) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Image.asset(
                  ImageUtils.getImgPath("time3x"),
                  width: 32.sp,
                  height: 32.sp,
                ),
                padding: EdgeInsets.only(left: 32.0.sp, top: 32.0.sp)),
            Container(
                child: Text(
                  _showTime(item),
                  style:
                      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
                ),
                padding: EdgeInsets.only(left: 10.0, top: 32.0.sp))
          ]),
    );
  }

  ///预约时间显示内容
  _showTime(item) {
    if (item['status'] == AppConstant.APPOINTMENT_NO) {
      return AppConstant.statusMap(AppConstant.APPOINTMENT_NO);
    }
    print(item['appointmentTime']);
    return timeFormatChineseHM(
        DateTime.parse(item['appointmentTime']).toLocal());
  }

  ///咨询师内容展示
  Widget _item(item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(10)),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    item['avatar'],
                    width: 88.r,
                    height: 88.r,
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _counselorName(item),
                SizedBox(
                  height: 8.sp,
                ),
                _consultingType(item)
              ],
            ),
          ],
        ),
        _appointmentBtn(item)
      ],
    );
  }

  ///咨询师姓名
  Widget _counselorName(item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          item['counselorName'],
          style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 10.sp,
        ),
        Text(
          "心理咨询师",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 10.sp,
        ),
        Icon(
          Icons.check_circle,
          size: 30.sp,
          color: Colors.orange,
        )
      ],
    );
  }

  ///咨询类型
  Widget _consultingType(item) {
    return _video(item);
  }

  ///视频咨询展示内容
  Widget _video(item) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10)),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                item['comboImg'],
                width: 32.r,
                height: 32.r,
              )),
          SizedBox(
            width: 0.3.sw,
            child: Text(item['wayDescribe'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 22.sp, color: Color(0xFF666666))),
          ),
        ],
      ),
    );
  }

  ///上拉加载数据
  void _retrieveData() {
    if (loading) {
      _pageNum = _pageNum + 1;
      consultList(_pageNum).then((value) => {
            setState(() {
              _consultList.addAll(value['rows']);
            })
          });
    }
  }

  ///导航页全部按钮
  _onClickAll() {
    DataStatistics.instance.event('all_type', {'name': 'jack'});
    Get.toNamed(RouteConfig.consultALlPage);
  }

  ///头像点击事件
  _onClickAvatar(item) {
    print("点击了头像 :$item");
  }

  ///点击了整个区域进入咨询师详情
  _onClickConsultantDetails(item) async {
    var data = await Get.toNamed(RouteConfig.consultDetails, arguments: item);
    if (data == "_cancel") {
      _handlerRefresh();
    }
  }
}
