import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/util/adapt.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/util/image_util.dart';

// 用户反馈
class HomeFeedbackView extends StatelessWidget {
  List homeFeedbackData;
  double _width = 293 * 2.sp;
  double _height = 156 * 2.sp;

  HomeFeedbackView({Key key, @required this.homeFeedbackData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        SizedBox(
          height: Adapt.px(16),
        ),
        Obx(() => getListView()),
      ]),
    );
  }

  /**
   * 外层横向可滑动的ListView
   */
  getListView() {
    return new SizedBox(
        height: _height,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: homeFeedbackData.length,
            itemBuilder: (BuildContext context, int position) {
              return getAdapter(context, homeFeedbackData, position);
            }));
  }

  getAdapter(BuildContext context, List dataList, int position) {
    return Container(
      width: _width,
      height: _height,
      margin: EdgeInsets.only(
          left: position == 0 ? 10 : 5,
          right: position == dataList.length - 1 ? 15 : 0),
      child: _getItem(context, dataList[position]),
    );
  }

  Widget _getItem(BuildContext context, Map data) {
    return Card(
        // color: Color(0xFFF1F1F1),
        //设置shape，这里设置成了R角
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        //对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿
        clipBehavior: Clip.antiAlias,
        semanticContainer: false,
        child: InkWell(
            onTap: () {
              // Get.toNamed(RouteConfig.evaluateShowListPage);
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(10.sp, 10.sp, 10.sp, 10.sp),
              child: getVerticalListView(data),
            )));
  }
}

/**
 * 内层横向不可滑动ListView
 */
Widget getVerticalListView(Map data) {
  return new Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
              child: Row(
                children: [
                  Image.asset(
                    ImageUtils.getImgPath("seelp_icon3x"),
                    width: 48.r,
                    height: 48.r,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    data['evaluateName'],
                    style: TextStyle(color: Color(0xFF666666), fontSize: 13),
                  ),
                ],
              ),
            ),
            _timeAnsType(data),
            _content(data),
          ],
        ),
        _lable(data)
      ],
    ),
  );
}

///标签
Widget _lable(Map data) {
  return Container(
    padding: EdgeInsets.only(left: 10.sp, top: 10.sp, bottom: 26.sp),
    child: Wrap(
      spacing: 8.0.sp, // 主轴(水平)方向间距
      runSpacing: 4.0.sp, // 纵轴（垂直）方向间距
      alignment: WrapAlignment.start,
      children: _lables(data),
    ),
  );
}

///咨询师标签展示内容
List<Widget> _lables(Map data) {
  List<Widget> lables = [];
  List la = data['evaluateLabelList'];
  la.forEach((element) {
    lables.add(Container(
      padding: EdgeInsets.only(bottom: 2),
      decoration: new BoxDecoration(
          border: Border.all(
            color: Color(0xFF3A8DFF),
            width: 0.8,
          ),
          borderRadius: new BorderRadius.circular((20.sp))),
      height: 40.0.sp,
      width: 120.sp,
      alignment: Alignment.center,
      child: Text(
        element['evaluateLabelName'],
        style: TextStyle(
          color: Color(0xFF666666),
          fontSize: 10,
        ),
      ),
    ));
  });

  return lables;
}

///评论内容
Widget _content(Map data) {
  return Container(
    padding: EdgeInsets.fromLTRB(10.sp, 10.sp, 10.sp, 5.sp),
    child: Text(
      data['evaluateContent'],
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 12, letterSpacing: 2),
    ),
  );
}

///时间咨询类型咨询师展示
Widget _timeAnsType(Map time) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
        child: Text(
          time['time'],
          style: TextStyle(color: Color(0xFF999999), fontSize: 10),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 10.sp),
        child: Text(
          "语音咨询",
          style: TextStyle(color: Colors.black45, fontSize: 10),
        ),
      )
    ],
  );
}

Widget getFeedbackItem(List<String> data, int position) {
  return Container(
    child: Text(data[position]),
  );
}
