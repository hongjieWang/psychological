import 'package:flutter/material.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/component/default/no_data_page.dart';
import 'package:standard_app/service/consult_service.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/util/style.dart';
import 'package:standard_app/util/time_utils.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:get/get.dart';

///全部咨询
class ConsultALlPage extends StatefulWidget {
  ConsultALlPage({Key key}) : super(key: key);

  @override
  _ConsultALlPageState createState() => _ConsultALlPageState();
}

class _ConsultALlPageState extends State<ConsultALlPage> {
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
    consultListAll(_pageNum).then((value) => {
          setState(() {
            _consultList.clear();
            _consultList.addAll(value['rows']);
            _total = value['total'];
          })
        });
  }

  ///上拉加载数据
  void _retrieveData() {
    if (loading) {
      _pageNum = _pageNum + 1;
      consultListAll(_pageNum).then((value) => {
            setState(() {
              _consultList.addAll(value['rows']);
            })
          });
    }
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("全部咨询"),
      body: RefreshIndicator(
          onRefresh: () => _handlerRefresh(),
          child: _consultList.length > 0 ? hasData() : NoDataDefaultPage()),
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

  ///有数据
  Container hasData() {
    return Container(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            _onClickConsultantDetails(item);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _time(item),
              _item(item),
            ],
          ),
        ),
        // _appointmentBtn(item)
      ],
    );
  }

  ///预约管理
  Widget _time(item) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
        Text(AppConstant.statusMap(item['status']))
      ],
    );
  }

  ///咨询师姓名
  Widget _counselorName(item) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            _onClickAvatar(item);
          },
          child: Text(item['counselorName'],
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500)),
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

  ///预约时间显示内容
  _showTime(item) {
    if (item['status'] == AppConstant.APPOINTMENT_NO) {
      return AppConstant.statusMap(AppConstant.APPOINTMENT_NO);
    }
    if (item['appointmentTime'] != null) {
      return timeFormatChineseHM(DateTime.parse(item['appointmentTime']));
    }
    return "";
  }

  ///头像点击事件
  _onClickAvatar(item) {
    print("点击了头像 :" + item);
  }

  ///点击了整个区域进入咨询师详情
  _onClickConsultantDetails(item) async {
    var data = await Get.toNamed(RouteConfig.consultDetails, arguments: item);
    if (data == "_cancel") {
      _handlerRefresh();
    }
  }
}
