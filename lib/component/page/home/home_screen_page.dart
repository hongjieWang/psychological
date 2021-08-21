import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:standard_app/component/page/home/home_controller.dart';
import 'package:standard_app/component/page/home/home_state.dart';
import 'package:standard_app/util/image_util.dart';

///首页筛选区域
class HomeScreenPage extends StatelessWidget {
  final HomeController logic = Get.put(HomeController());
  final HomeState state = Get.find<HomeController>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 32.sp, right: 32.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     _title("主题", () {}),
          //     _title("排序", () {}),
          //     _title("筛选", () {})
          //   ],
          // ),
          seachWidget(),
          Divider(),
          _homeTheme(),
          _sort(),
        ],
      ),
    );
  }

  ///今日可预约筛选
  Container seachWidget() {
    return Container(
      margin: EdgeInsets.only(top: 0),
      height: 24.0,
      child: ListView(
        //设置水平方向排列
        scrollDirection: Axis.horizontal,
        //添加子元素
        children: <Widget>[
          homeLabel("今日可预约"),
          homeLabel("现在有空"),
          homeLabel("男咨询师"),
          homeLabel("女咨询师"),
        ],
      ),
    );
  }

  ///首页咨询师筛选label
  Widget homeLabel(String label) {
    return InkWell(
        onTap: () {
          state.selectText.value = label;
        },
        child: Obx(() => Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 10),
              width: 170.0.sp,
              decoration: BoxDecoration(
                color: label == state.selectText.value
                    ? Color(0xFF3A8DFF)
                    : Color(0xFFE9F4FF),
                borderRadius: BorderRadius.all(Radius.circular(30.0.sp)),
              ),
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 12,
                    color: label == state.selectText.value
                        ? Colors.white
                        : Color(0xFF999999)),
              ),
            )));
  }

  ///筛选内容名称
  Widget _title(name, fun) {
    return InkWell(
        onTap: () {
          fun();
        },
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30.sp, 0.sp, 10.sp, 0.sp),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 15, color: Color(0xFF3A8DFF)),
                  ),
                ),
                SizedBox(width: 10.sp),
                Image.asset(
                  ImageUtils.getImgPath("below3x"),
                  width: 14.sp,
                  height: 6.sp,
                )
              ],
            ),
          ],
        ));
  }

  ///首页主题选项
  Widget _homeTheme() {
    return Offstage(
        offstage: !(state.index.value == 1),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.sp),
                child: Wrap(
                    spacing: 20.0.sp, // 主轴(水平)方向间距
                    runSpacing: 20.0.sp, // 纵轴（垂直）方向间距
                    alignment: WrapAlignment.start, //沿主轴方向居中
                    children: _lables()),
              ),
            ],
          ),
        ));
  }

  ///排序
  Widget _sort() {
    return Offstage(
        offstage: !(state.index.value == 2),
        child: Container(
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    logic.selectedSort("01");
                  },
                  child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Text(
                        "推荐排序",
                        style: TextStyle(fontSize: 28.sp),
                      ))),
              InkWell(
                  onTap: () {
                    logic.selectedSort("02");
                  },
                  child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Text(
                        "销量优先",
                        style: TextStyle(fontSize: 28.sp),
                      ))),
              InkWell(
                  onTap: () {
                    logic.selectedSort("03");
                  },
                  child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Text(
                        "好评优先",
                        style: TextStyle(fontSize: 28.sp),
                      ))),
              InkWell(
                  onTap: () {
                    logic.selectedSort("04");
                  },
                  child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Text(
                        "低价优先",
                        style: TextStyle(fontSize: 28.sp),
                      ))),
            ],
          ),
        ));
  }

  ///主题标签
  List<Widget> _lables() {
    List<Widget> lables = [];
    state.lables.forEach((element) {
      lables.add(InkWell(
        onTap: () {
          logic.selectedThemeLables(element);
        },
        child: Obx(() => Container(
              alignment: Alignment(0, 0),
              width: 140.sp,
              padding: EdgeInsets.only(top: 5.sp, bottom: 5.sp),
              //边框设置
              decoration: new BoxDecoration(
                  //设置四周圆角 角度
                  borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
                  //设置四周边框
                  border: new Border.all(width: 1.sp, color: Colors.black26),
                  color: state.selectedThemeLablesData.contains(element)
                      ? Colors.orange[50]
                      : Colors.grey[50]),
              child: Text(element["value"],
                  style: TextStyle(
                      color: state.selectedThemeLablesData.contains(element)
                          ? Colors.orange[700]
                          : Colors.black)),
            )),
      ));
    });
    return lables;
  }

  _buttom() {
    showModalBottomSheet(
        context: Get.context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _screenTitle("咨询方式"),
                _consultationMode(),
                _screenTitle("服务价格"),
                _priceRange(),
                _screenTitle("资质选择"),
                _qualification(),
                _screenTitle("其他选择"),
                _other(),
                _btn()
              ],
            ),
          );
        });
  }

  ///提交按钮
  Widget _btn() {
    return Container(
      padding: EdgeInsets.fromLTRB(30.sp, 30.sp, 20.sp, 50.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {},
              child: Text("重置"),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(200.sp, 50.sp)),
                //设置边框
                side: MaterialStateProperty.all(
                    BorderSide(color: Colors.grey, width: 1)),
              )),
          SizedBox(
            width: 30.sp,
          ),
          TextButton(
              onPressed: () {},
              child: Text("确定"),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(300.sp, 50.sp)),
                //设置边框
                side: MaterialStateProperty.all(
                    BorderSide(color: Colors.grey, width: 1)),
              ))
        ],
      ),
    );
  }

  ///其他选择
  Widget _other() {
    return Container(
      padding: EdgeInsets.only(left: 20.sp),
      child: Wrap(
        spacing: 8.0, // 主轴(水平)方向间距
        runSpacing: 4.0, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.start, //沿主轴方向居中
        children: <Widget>[
          new Chip(
            avatar: new CircleAvatar(
                backgroundColor: Colors.orange, child: Text('男')),
            label: new Text('男咨询师'),
          ),
          new Chip(
            avatar: new CircleAvatar(
                backgroundColor: Colors.green, child: Text('女')),
            label: new Text('女咨询师'),
          ),
          new Chip(
            avatar: new CircleAvatar(
                backgroundColor: Colors.blue, child: Text('空')),
            label: new Text('现在有空'),
          ),
          new Chip(
            avatar: new CircleAvatar(
                backgroundColor: Colors.pink, child: Text('预')),
            label: new Text('今日可预约'),
          )
        ],
      ),
    );
  }

  ///资质审核
  Widget _qualification() {
    return Container(
      padding: EdgeInsets.only(left: 20.sp),
      child: Wrap(
        spacing: 8.0, // 主轴(水平)方向间距
        runSpacing: 4.0, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.start, //沿主轴方向居中
        children: <Widget>[
          new Chip(
            avatar: new CircleAvatar(
                backgroundColor: Colors.blue, child: Text('一')),
            label: new Text('一级咨询师'),
          ),
          new Chip(
            avatar: new CircleAvatar(
                backgroundColor: Colors.blue, child: Text('二')),
            label: new Text('二级咨询师'),
          ),
          new Chip(
            avatar: new CircleAvatar(
                backgroundColor: Colors.blue, child: Text('三')),
            label: new Text('三级咨询师'),
          ),
        ],
      ),
    );
  }

  ///咨询方式语音/视频
  Widget _consultationMode() {
    return Padding(
      padding: EdgeInsets.all(20.sp),
      child: Row(
        children: [
          TextButton(
              onPressed: () {},
              child: Text(
                "语音",
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                    BorderSide(color: Colors.grey, width: 1)),
                minimumSize: MaterialStateProperty.all(Size(150.sp, 50.sp)),
                padding: MaterialStateProperty.all(EdgeInsets.all(10.sp)),
              )),
          SizedBox(
            width: 20.sp,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "视频",
              style: TextStyle(color: Colors.black),
            ),
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                  BorderSide(color: Colors.grey, width: 1)),
              minimumSize: MaterialStateProperty.all(Size(150.sp, 50.sp)),
              padding: MaterialStateProperty.all(EdgeInsets.all(10.sp)),
            ),
          )
        ],
      ),
    );
  }

  ///价格区间
  Widget _priceRange() {
    return Padding(
      padding: EdgeInsets.only(left: 20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_priceInput(), _priceSelect()],
      ),
    );
  }

  ///价格输入框
  Widget _priceInput() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 160.sp,
            height: 60.sp,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                ///设置边框四个角的弧度
                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                gapPadding: 1.sp,
              )),
            ),
          ),
          Text("--"),
          Container(
            width: 160.sp,
            height: 60.sp,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                ///设置边框四个角的弧度
                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                gapPadding: 1.sp,
              )),
            ),
          )
        ],
      ),
    );
  }

  ///推荐价格选择框
  Widget _priceSelect() {
    return Padding(
      padding: EdgeInsets.only(top: 10.sp),
      child: Wrap(
          spacing: 8.0.sp, // 主轴(水平)方向间距
          runSpacing: 4.0.sp, // 纵轴（垂直）方向间距
          alignment: WrapAlignment.start, //沿主轴方向居中
          children: _priceLables()),
    );
  }

  ///价格标签
  List<Widget> _priceLables() {
    List<Widget> lables = [];
    for (int i = 0; i < 4; i++) {
      lables.add(TextButton(
        onPressed: () {},
        child: Text(
          "50-100",
          style: TextStyle(color: Colors.black),
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all(
              BorderSide(color: Colors.grey, width: 1)),
          padding: MaterialStateProperty.all(EdgeInsets.all(10.sp)),
          //设置按钮的大小
          minimumSize: MaterialStateProperty.all(Size(140.sp, 50.sp)),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            //设置按下时的背景颜色
            if (states.contains(MaterialState.pressed)) {
              return Colors.blue[200];
            }
            //默认不使用背景颜色
            return Colors.black12;
          }),
        ),
      ));
    }
    return lables;
  }

  ///筛选弹框标题样式
  Widget _screenTitle(value) {
    return Padding(
      padding: EdgeInsets.only(left: 20.sp, top: 40.sp, bottom: 20.sp),
      child: Text(
        value,
        style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
