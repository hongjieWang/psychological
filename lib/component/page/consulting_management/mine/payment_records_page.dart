import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/style.dart';

///收支明细
class PaymentRecordsPage extends StatefulWidget {
  @override
  _PaymentRecordsPageState createState() => _PaymentRecordsPageState();
}

class _PaymentRecordsPageState extends State<PaymentRecordsPage> {
  Map wallet = Get.arguments;
  List data = [];
  bool loading = true; //表尾标记
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮
  ScrollController _controller = new ScrollController();
  int _pageNum = 1;
  int _total = 0;

  @override
  void initState() {
    super.initState();
    ApiService()
        .getPaymentsRecords(wallet['walletNo'], _pageNum)
        .then((value) => setState(() {
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
      ApiService()
          .getPaymentsRecords(wallet['walletNo'], _pageNum)
          .then((value) => setState(() {
                data.addAll(value['rows']);
              }));
    }
  }

  ///下拉刷新
  Future<void> _handlerRefresh() async {
    _pageNum = 1;
    loading = true;
    ApiService()
        .getPaymentsRecords(wallet['walletNo'], _pageNum)
        .then((value) => setState(() {
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
      appBar: StyleUtils.buildAppBar("交易记录"),
      body: RefreshIndicator(
          onRefresh: () => _handlerRefresh(),
          child: Container(
            padding: EdgeInsets.only(top: 10.0),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              itemCount: data.length,
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                if (this._total > data.length && data.length - 1 == index) {
                  //加载时显示loading
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0)),
                  );
                } else if (this._total == data.length && data.length == index) {
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
                return _item(data[index]);
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

  ///单行列表
  Widget _item(item) {
    return InkWell(
        onTap: () => {_showDetails(item)},
        child: renderItem(item['paymentsType'] == "1" ? item['remark'] : "提现支出",
            item['createTime'],
            child: Text(
              item['paymentsType'] == "1"
                  ? "+ ${item['paymentsNumber']}"
                  : "- ${item['paymentsNumber']}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: item['paymentsType'] == "1"
                      ? Colors.orange[400]
                      : Colors.black),
            )));
  }

  ///显示详情
  _showDetails(item) {
    Get.toNamed(RouteConfig.paymentDatailsPage, arguments: item);
  }

  Widget renderItem(String title, String date, {Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 72,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 0.7.sw,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Color(0xff333333), fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                )
              ],
            ),
            child != null ? child : Container()
          ]),
    );
  }
}
