import 'package:flutter/material.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/util/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///咨询记录
class ConsultingRecordsPage extends StatefulWidget {
  ConsultingRecordsPage({Key key}) : super(key: key);

  @override
  _ConsultingRecordsPageState createState() => _ConsultingRecordsPageState();
}

class _ConsultingRecordsPageState extends State<ConsultingRecordsPage> {
  List data = [];
  bool loading = true; //表尾标记
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮
  ScrollController _controller = new ScrollController();
  int _pageNum = 1;
  int _total = 0;

  @override
  void initState() {
    super.initState();
    ApiService().getConsultingRecords(_pageNum).then((value) => setState(() {
          data.addAll(value['rows']);
        }));
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

  ///上拉加载数据
  void _retrieveData() {
    if (loading) {
      _pageNum = _pageNum + 1;
      ApiService().getConsultingRecords(_pageNum).then((value) => setState(() {
            data.addAll(value['rows']);
          }));
    }
  }

  ///下拉刷新
  Future<void> _handlerRefresh() async {
    _pageNum = 1;
    loading = true;
    ApiService().getConsultingRecords(_pageNum).then((value) => setState(() {
          data.clear();
          data.addAll(value['rows']);
          _total = value['total'];
        }));
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
      appBar: StyleUtils.buildAppBar("咨询记录"),
      body: RefreshIndicator(
          onRefresh: () => _handlerRefresh(),
          child: Container(
              padding: EdgeInsets.only(left: 32.sp, top: 30.sp),
              decoration: BoxDecoration(color: StyleUtils.bgColor),
              child: Column(children: [
                _tabs(),
                SizedBox(height: 20.sp),
                Expanded(
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    itemCount: data.length,
                    controller: _controller,
                    itemBuilder: (BuildContext context, int index) {
                      if (this._total > data.length &&
                          data.length - 1 == index) {
                        //加载时显示loading
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2.0)),
                        );
                      } else if (this._total == data.length &&
                          data.length == index) {
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
                      return _listItem(index);
                    },
                    separatorBuilder: (context, index) => Divider(height: .0),
                  ),
                )
              ]))),
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

  Container _listItem(int index) {
    return Container(
      height: 400.sp,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(0.sp, 30.sp, 32.sp, 10.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 40.sp, top: 44.sp),
            child: Row(children: [
              Text(
                data[index]['members']['membersName'],
                style: TextStyle(
                    color: StyleUtils.fontColor_3,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                " (${data[index]['members']['nickName']})",
                style:
                    TextStyle(color: StyleUtils.fontColor_9, fontSize: 24.sp),
              )
            ]),
          ),
          _itemlabel("时间", data[index]['nextTime']),
          _itemlabel("方式", data[index]['combo']['comboName']),
          _itemlabel("咨询", "${data[index]['combo']['originalPrice']} 元/次"),
          Divider(),
          Container(
            padding: EdgeInsets.only(left: 40.sp, top: 10.sp, right: 40.sp),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "收益",
                    style: TextStyle(
                        color: StyleUtils.fontColor_3,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp),
                  ),
                  Text(
                      "¥ ${data[index]['paymentsNumber'] != null ? data[index]['paymentsNumber'] : '未计算收益'}"),
                ]),
          )
        ],
      ),
    );
  }

  Container _itemlabel(String label, String value) {
    return Container(
      padding: EdgeInsets.only(left: 40.sp, top: 36.sp),
      child: Row(children: [
        Text(
          label,
          style: TextStyle(color: StyleUtils.fontColor_6, fontSize: 24.sp),
        ),
        SizedBox(
          width: 60.sp,
        ),
        Text(value,
            style: TextStyle(color: StyleUtils.fontColor_3, fontSize: 24.sp)),
      ]),
    );
  }

  /// tab
  Row _tabs() {
    return Row(children: [
      Column(children: [
        Text("全部",
            style: TextStyle(
                color: Color(0xFF5694E9),
                fontSize: 32.sp,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: 1,
        ),
        Container(height: 2, width: 60.sp, color: Colors.blue)
      ]),
      SizedBox(
        width: 60.sp,
      ),
      Column(children: [
        Text(
          "待结算",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: StyleUtils.fontColor_9,
              fontSize: 32.sp),
        ),
        SizedBox(
          height: 1,
        ),
        Container(height: 2, width: 90.sp, color: StyleUtils.bgColor)
      ])
    ]);
  }
}
