import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/component/default/no_data_page.dart';
import 'package:standard_app/component/page/mine/coupon/coupon_controller.dart';
import 'package:standard_app/component/page/mine/coupon/coupon_state.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:standard_app/util/style.dart';

///优惠卷视图
class CouponPage extends StatelessWidget {
  final CouponController logic = Get.put(CouponController());
  final CouponState state = Get.find<CouponController>().state;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "优惠券",
                style: TextStyle(color: Colors.black, fontSize: 36.sp),
              ),
              elevation: 0,
              leading: Builder(builder: (context) {
                return IconButton(
                    icon: Icon(Icons.close, color: Colors.black), //自定义图标
                    iconSize: 20,
                    onPressed: () {
                      // 打开抽屉菜单
                      Navigator.pop(context);
                    });
              }),
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(48),
                  child: Material(
                    color: StyleUtils.bgColor,
                    child: new TabBar(
                        tabs: [
                          Text('未使用'),
                          Text('已使用'),
                          Text('已失效'),
                        ],
                        labelColor: Colors.black87,
                        labelStyle: TextStyle(
                          fontSize: 32.sp,
                        ),
                        labelPadding: EdgeInsets.all(10.sp),
                        indicatorColor: Color(0xFF3A8DFF),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 6.sp,
                        unselectedLabelColor: StyleUtils.fontColor_9,
                        onTap: (int index) {
                          print(index);
                        }),
                  ))),
          body: NoDataDefaultPage(),
        ));
  }

  ///优惠卷内容
  Widget _body() {
    return Container(
      color: StyleUtils.bgColor,
      padding: EdgeInsets.only(top: 20.sp),
      width: 750.sp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_item(), _item()],
      ),
    );
  }

  ///单个优惠券内容
  Widget _item() {
    return Container(
      padding: EdgeInsets.only(top: 20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20.sp, 40.sp, 30.sp, 10.sp),
            width: 720.sp,
            height: 240.sp,
            //设置背景图片
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(
                  ImageUtils.getImgPath('yhjbg'),
                ),
                fit: BoxFit.cover,
                //这里是从assets静态文件中获取的，也可以new NetworkImage(）从网络上获取
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _source(),
                Column(
                  children: [
                    Text(
                      "新人专享",
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: StyleUtils.fontColor_3,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Text(
                      "2021.03.04—2021.03.31",
                      style:
                          TextStyle(fontSize: 14.sp, color: Color(0xFF6E788A)),
                    )
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "立即领取",
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                      style: ButtonStyle(
                        //设置边框
                        side: MaterialStateProperty.all(
                            BorderSide(color: Colors.white, width: 1)),
                        //设置按钮内边距
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(6.sp)),
                        //设置按钮的大小
                        minimumSize:
                            MaterialStateProperty.all(Size(128.sp, 40.sp)),
                        //外边框装饰 会覆盖 side 配置的样式
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      ),
                    ),
                    InkWell(
                      child: Icon(
                        Icons.download_outlined,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          _explain()
        ],
      ),
    );
  }

  ///金额
  Container _source() {
    return Container(
        padding: EdgeInsets.only(left: 16.sp),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "¥ ",
                  style: TextStyle(fontSize: 42.sp, color: Colors.black),
                ),
                Text(
                  "20",
                  style: TextStyle(
                      fontSize: 42 * 2.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
            Text(
              "无门槛",
              style: TextStyle(fontSize: 18.sp, color: StyleUtils.fontColor_6),
            )
          ],
        ));
  }

  ///优惠券发放说明
  Widget _explain() {
    return Offstage(
        offstage: true,
        child: Container(
          width: 720.sp,
          decoration: new BoxDecoration(
            //背景
            color: Colors.grey[300],
            //设置四周圆角 角度
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.sp, 10.sp, 0.sp, 10.sp),
                    child: Text("使用范围："),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.sp, 10.sp, 0.sp, 10.sp),
                    child: Text("全平台咨询师"),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.sp, 0.sp, 0.sp, 10.sp),
                    child: Text("券的来源："),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.sp, 0.sp, 0.sp, 10.sp),
                    child: Text("平台发放"),
                  )
                ],
              )
            ],
          ),
        ));
  }

  ///优惠卷使用条件和时间
  Widget _time() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 50.sp),
          child: Text(
            "无门槛",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Text(
          "2021.03.04—2021.03.31",
          style: TextStyle(color: Colors.white),
        ),
        InkWell(
          onTap: () {
            print("");
          },
          child: Icon(
            Icons.expand_more,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
