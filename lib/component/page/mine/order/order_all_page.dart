import 'package:flutter/material.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/util/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///全部订单列表
class OrderAllPage extends StatefulWidget {
  OrderAllPage({Key key}) : super(key: key);

  @override
  _OrderAllPageState createState() => _OrderAllPageState();
}

class _OrderAllPageState extends State<OrderAllPage> {
  int pageNum = 1;
  int count = 0;

  ///订单状态 0 待付款 1 支付完成
  int orderStauts = 1;

  ///订单数据
  List orderList = [];

  ///是否显示更多
  bool isShowMove = false;
  bool isLoading = false;

  /// 滚动监听器
  ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("全部订单"),
      body: _body(),
    );
  }

  @override
  void initState() {
    super.initState();
    this._orderList();
    // 给列表滚动添加监听
    this.scrollController.addListener(() {
      // 滑动到底部的判断
      if (!this.isLoading &&
          this.scrollController.position.pixels >=
              this.scrollController.position.maxScrollExtent) {
        // 开始加载数据
        setState(() {
          pageNum = pageNum + 1;
          this._orderList(); //加载数据
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _orderList() {
    ApiService()
        .getOrderListAll(
          pageNum,
        )
        .then((res) => {
              print(res),
              setState(() {
                if (res['code'] == Api.success) {
                  orderList.addAll(res['rows'].toList());
                  count = res['total'];
                }
              })
            });
  }

  Future<void> onRefresh() async {
    //下拉刷新
    pageNum = 1;
    this.isLoading = false;
    orderList.clear();
    this._orderList();
  }

  ///我的订单主体
  Widget _body() {
    return Container(
      color: StyleUtils.bgColor,
      child: RefreshIndicator(
          onRefresh: this.onRefresh,
          child: ListView.builder(
            itemCount: orderList.length + 1,
            controller: scrollController, //监听滑动
            //列表项构造器
            itemBuilder: (BuildContext context, int index) {
              if (count > orderList.length && orderList.length == index) {
                //加载时显示loading
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: CircularProgressIndicator(strokeWidth: 2.0)),
                );
              } else if (count == orderList.length &&
                  orderList.length == index) {
                this.isLoading = true;
                return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "我也是有底线的～～～",
                      style: TextStyle(color: Colors.grey),
                    ));
              }
              return _item(orderList[index]);
            },
          )),
    );
  }

  ///单个列表
  Widget _item(item) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
        ),
        padding: EdgeInsets.fromLTRB(46.sp, 10.sp, 42.sp, 10.sp),
        margin: EdgeInsets.fromLTRB(32.sp, 46.sp, 32.sp, 10.sp),
        child: InkWell(
          onTap: () {},
          child: Column(
            children: [
              SizedBox(
                height: 0.005.sh,
              ),
              _title(item['orderName'],
                  AppConstant.orderStatus(item['orderStatus'])),
              SizedBox(
                height: 50.sp,
              ),
              _text('咨询课程', item['combo']['comboName']),
              SizedBox(
                height: 50.sp,
              ),
              _text('咨询次数', 'x1'),
              SizedBox(
                height: 50.sp,
              ),
              _text(
                  '${item['combo']['comboName']}(${item['combo']['courseDuration']}分钟)',
                  '¥ ${item['unitPrice']} 元/次'),
              SizedBox(
                height: 50.sp,
              ),
            ],
          ),
        ));
  }

  ///咨询标题
  Widget _title(String name, String status) {
    return Padding(
      padding: EdgeInsets.only(top: 10.sp, bottom: 5.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Text(
              name,
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
            ),
            Icon(
              Icons.check_circle,
              size: 34.sp,
              color: Colors.orange,
            )
          ]),
          Row(
            children: [
              Text(
                status,
                style: TextStyle(color: Colors.orange[800]),
              ),
              new Offstage(
                offstage: true, //组件是否显示
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.delete,
                    size: 36.sp,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///咨询内容主体
  Widget _text(String name, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name,
            style: TextStyle(color: StyleUtils.fontColor_3, fontSize: 24.sp)),
        Text(
          value,
          style: TextStyle(color: StyleUtils.fontColor_6, fontSize: 24.sp),
        )
      ],
    );
  }
}
