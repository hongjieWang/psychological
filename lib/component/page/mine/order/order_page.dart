import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/component/default/order_default_page.dart';
import 'package:standard_app/component/page/mine/order/order_controller.dart';
import 'package:standard_app/component/page/mine/order/order_state.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/style.dart';

//我的订单
class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int pageNum = 1;
  int count = 0;

  /// 根据订单状态显示按钮名称

  ///订单状态 0 待付款 1 支付完成
  int orderStatus = 1;

  ///订单数据
  List orderList = [];

  ///是否显示更多
  bool isShowMove = false;
  bool isLoading = false;

  final OrderController logic = Get.put(OrderController());
  final OrderState state = Get.find<OrderController>().state;

  /// 滚动监听器
  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                '我的订单',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              leading: Builder(builder: (context) {
                return IconButton(
                  icon: Icon(Icons.chevron_left_outlined,
                      color: Colors.black), //自定义图标
                  onPressed: () {
                    Get.back();
                  },
                );
              }),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.toNamed(RouteConfig.orderAllPage);
                    },
                    child: Text(
                      "全部",
                      style: TextStyle(color: Colors.black, fontSize: 24.sp),
                    ))
              ],
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0.05.sh),
                  child: Material(
                    color: StyleUtils.bgColor,
                    child: new TabBar(
                        tabs: [
                          Tab(text: "已支付"),
                          Tab(text: "待付款"),
                        ],
                        labelColor: Color(0xFF333333),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                        labelPadding: EdgeInsets.zero,
                        indicatorColor: Color(0xFF3A8DFF),
                        indicatorWeight: 2.0,
                        indicatorSize: TabBarIndicatorSize.label,
                        onTap: (int index) {
                          setState(() {
                            if (index == 1) {
                              orderStatus = 0; //待支付
                            } else {
                              orderStatus = 1; //已支付
                            }
                            onRefresh();
                          });
                        }),
                  ))),
          backgroundColor: StyleUtils.bgColor,
          body: _body(),
        ));
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
    super.dispose();
  }

  void _orderList() {
    ApiService().getOrderList(pageNum, "$orderStatus").then((res) => {
          setState(() {
            if (res['code'] == Api.success) {
              orderList.addAll(res['rows'].toList());
              count = res['total'];
            }
          })
        });
  }

  ///订单列表
  Widget _body() {
    return orderList.isEmpty
        ? OrderDefaultPage()
        : Container(
            decoration: BoxDecoration(color: StyleUtils.bgColor),
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

  Future<void> onRefresh() async {
    //下拉刷新
    pageNum = 1;
    this.isLoading = false;
    orderList.clear();
    this._orderList();
  }

  ///单个列表
  Widget _item(item) {
    isShowOneBtn(item);
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
        ),
        padding: EdgeInsets.fromLTRB(46.sp, 10.sp, 42.sp, 10.sp),
        margin: EdgeInsets.fromLTRB(32.sp, 46.sp, 32.sp, 10.sp),
        child: InkWell(
          onTap: () {
            logic.onClickItme(item);
          },
          child: Column(
            children: [
              SizedBox(
                height: 0.005.sh,
              ),
              _title(
                  item['orderName'], state.orderStatusMap[item['orderStatus']]),
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
              _btnPayOk(
                  item,
                  item['payPrice'],
                  isShowOneBtn(item)
                      ? state.btnNameByStatus[item['orderStatus']]
                      : "",
                  '再次购买',
                  logic.getFuncByStatus,
                  logic.onFuncOnceAgainToBuy)
            ],
          ),
        ));
  }

  ///只有未预约才显示退款按钮
  bool isShowOneBtn(item) {
    if (item['customerRelationships'] != null) {
      return item['customerRelationships'][0]['status'] ==
              AppConstant.APPOINTMENT_NO ||
          item['customerRelationships'][0]['status'] == AppConstant.CANCEL;
    } else if (item['orderStatus'] == 0) {
      return true;
    }
    return false;
  }

  ///再次预约按钮
  Widget _btnPayOk(Map item, double num, String status, String btn2,
      Function funcOne, Function funcTwo) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "实付：",
                style:
                    TextStyle(fontSize: 20.sp, color: StyleUtils.fontColor_3)),
            TextSpan(
                text: "$num",
                style: TextStyle(
                    color: StyleUtils.fontColor_3,
                    fontWeight: FontWeight.w500,
                    fontSize: 34.sp)),
            TextSpan(
                text: "元",
                style:
                    TextStyle(fontSize: 20.sp, color: StyleUtils.fontColor_3))
          ])),
          Row(
            children: [
              new Offstage(
                  offstage: status.isBlank, //组件是否显示
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.sp),
                      child: TextButton(
                        onPressed: () async {
                          var res = await funcOne(item);
                          if (res == "ok") {
                            onRefresh();
                          }
                        },
                        child: Text(
                          status,
                          style:
                              TextStyle(color: Colors.white, fontSize: 22.sp),
                        ),
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.grey, width: 1)),
                          shape: MaterialStateProperty.all(StadiumBorder()),
                          minimumSize:
                              MaterialStateProperty.all(Size(148.sp, 44.sp)),
                          //背景颜色
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            //设置按下时的背景颜色
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.blue[200];
                            }
                            //默认不使用背景颜色
                            return item['orderStatus'] ==
                                    AppConstant.APPOINTMENT_NO
                                ? Color(0xFF5191E8)
                                : StyleUtils.fontColor_9;
                          }),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(6.sp)),
                        ),
                      ))),
              Offstage(
                  offstage: item['orderStatus'] == AppConstant.APPOINTMENT_NO,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.sp),
                      child: TextButton(
                        onPressed: () {
                          funcTwo(item);
                        },
                        child: Text(
                          btn2,
                          style:
                              TextStyle(color: Colors.white, fontSize: 22.sp),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(StadiumBorder()),
                          minimumSize:
                              MaterialStateProperty.all(Size(148.sp, 44.sp)),
                          //背景颜色
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            //设置按下时的背景颜色
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.blue[200];
                            }
                            //默认不使用背景颜色
                            return Color(0xFF5191E8);
                          }),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(6.sp)),
                        ),
                      )))
            ],
          )
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
}
