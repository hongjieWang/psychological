import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/component/page/mine/attention/attention_controller.dart';
import 'package:standard_app/component/page/mine/attention/attention_state.dart';

///我的关注页面
class AttentionPage extends StatelessWidget {
  final AttentionController logic = Get.put(AttentionController());
  final AttentionState state = Get.find<AttentionController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的关注'),
      ),
      body: _body(),
    );
  }

  ///我的关注列表页面
  Widget _body() {
    return Container(
      child: Text("我的关注"),
    );
  }
}
