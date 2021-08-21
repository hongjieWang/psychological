import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:standard_app/component/page/consult/feedback/feedback_controller.dart';
import 'package:standard_app/component/page/consult/feedback/feedback_state.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/style.dart';

///意见反馈列表
class FeedBackPage extends StatelessWidget {
  final FeedBackController logic = Get.put(FeedBackController());
  final FeedBackState state = Get.find<FeedBackController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("投诉举报", icon: Icons.arrow_back_ios),
      body: _body(),
    );
  }

  ///意见反馈列表
  Widget _body() {
    return Obx(() => Container(
          color: Colors.white,
          child: ListView.separated(
            itemCount: state.feeds.length,
            itemBuilder: (BuildContext context, int index) {
              return _feedItem(state.feeds[index], context);
            },
            separatorBuilder: (context, index) => Divider(height: .0),
          ),
        ));
  }

  ///单个列表数据
  Widget _feedItem(item, context) {
    return Padding(
        padding: EdgeInsets.only(top: 20.sp),
        child: InkWell(
          onTap: () {
            _onClickItem(item, context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _feed(item),
              Padding(
                padding: EdgeInsets.only(right: 30.0.sp),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF999999),
                  size: 30.sp,
                ),
              )
            ],
          ),
        ));
  }

  Widget _feed(item) {
    return Container(
      width: 600.w,
      padding: EdgeInsets.fromLTRB(30.sp, 10.sp, .0.sp, 30.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['feedbackTypeName'],
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 34.sp,
                color: Color(0xFF666666)),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Text(
            item['feedbackTypeDescribe'],
            maxLines: 3,
            style: TextStyle(color: Color(0xFF999999), fontSize: 12),
          ),
        ],
      ),
    );
  }

  _onClickItem(item, context) {
    Get.toNamed(RouteConfig.feedbackDetailPage, arguments: item);
  }
}
