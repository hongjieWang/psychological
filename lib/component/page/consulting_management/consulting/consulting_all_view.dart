import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/service/consult_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/util/Toasts.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:standard_app/util/style.dart';
import 'package:standard_app/util/time_utils.dart';

///咨询管理
class ConsultingAllPage extends StatefulWidget {
  @override
  _ConsultingAllPageState createState() => _ConsultingAllPageState();
}

class _ConsultingAllPageState extends State<ConsultingAllPage> {
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
      // print(_controller.offset); //打印滚动位置
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
    ApiService().getConsultCounselor(_pageNum).then((value) => {
          setState(() {
            _consultList.clear();
            _consultList.addAll(value['rows']);
            _total = value['total'];
          })
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("咨询"),
      body: RefreshIndicator(
          onRefresh: () => _handlerRefresh(),
          child: Container(
            color: Colors.white,
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
          )),
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

  ///单个咨询框
  Widget _consultItem(item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_time(item), _item(item)],
          ),
          onTap: () {
            _onClickConsultantDetails(item);
          },
        ),
        _appointmentBtn(item)
      ],
    );
  }

  ///预约按钮
  Widget _appointmentBtn(item) {
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      child: TextButton(
        onPressed: null,
        child: Text(
          AppConstant.btnConsultNameMap(item['status']),
          style: TextStyle(color: Colors.white, fontSize: 22.sp),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              //默认不使用背景颜色
              return Colors.black26;
            }),
            minimumSize: MaterialStateProperty.all(Size(130.sp, 44.sp)),
            padding: MaterialStateProperty.all(EdgeInsets.all(6.sp)),
            shape: MaterialStateProperty.all(StadiumBorder())),
      ),
    );
  }

  ///预约管理
  Widget _time(item) {
    return Row(children: [
      Container(
          child: Image.asset(
            _onBtnStatus(item)
                ? ImageUtils.getImgPath("time3x")
                : ImageUtils.getImgPath("time3x_h"),
            width: 32.sp,
            height: 32.sp,
          ),
          padding: EdgeInsets.only(left: 10.0, top: 10.0)),
      Container(
          child: Text(
            _showTime(item),
            style: TextStyle(fontSize: 30.sp, color: StyleUtils.fontColor_3),
          ),
          padding: EdgeInsets.only(left: 10.0, top: 10.0))
    ]);
  }

  ///预约时间显示内容
  _showTime(item) {
    if (item['status'] == AppConstant.APPOINTMENT_NO) {
      return AppConstant.statusMap(AppConstant.APPOINTMENT_NO);
    }
    return timeFormatChineseHM(
        DateTime.parse(item['appointmentTime']).toLocal());
  }

  ///咨询师内容展示
  Widget _item(item) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          child: InkWell(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(10)),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  item['avatar'],
                  width: 88.r,
                  height: 88.r,
                )),
            onTap: () {
              _onClickAvatar(item);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_counselorName(item), _consultingType(item)],
          ),
        )
      ],
    );
  }

  ///用户姓名
  Widget _counselorName(item) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              _onClickAvatar(item);
            },
            child: Text(item['membersName'],
                style:
                    TextStyle(fontSize: 28.sp, color: StyleUtils.fontColor_3)),
          )
        ],
      ),
    );
  }

  ///咨询类型
  Widget _consultingType(item) {
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
                style:
                    TextStyle(fontSize: 22.sp, color: StyleUtils.fontColor_6)),
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

  ///头像点击事件
  _onClickAvatar(item) {
    print("点击了头像 :" + item);
  }

  ///判断按钮状态是否禁止点击
  bool _onBtnStatus(item) {
    return item['status'] == AppConstant.APPOINTMENT_SUCCESS ||
        item['status'] == AppConstant.SIGN_IN;
  }

  ///点击立即预约按钮
  _onClickAppointment(item) {
    Get.toNamed(RouteConfig.appointmentPage, arguments: item);
  }

  ///开始咨询按钮
  _onClickStart(item) {
    print(item);
    ApiService().applyAgToken(item['channelName']).then((res) => {
          if (res['code'] == Api.success)
            {
              Get.toNamed(RouteConfig.videoPage, arguments: {
                "token": res['msg'],
                "channelName": item['channelName'],
                "uid": item['cui']
              })
            }
          else
            {Toasts.error("服务异常，请稍后重试，或请联系客服人员")}
        });
  }

  ///点击了整个区域进入咨询师详情
  _onClickConsultantDetails(item) {
    Get.toNamed(RouteConfig.consultCounselorDetailsPage, arguments: item);
  }
}
