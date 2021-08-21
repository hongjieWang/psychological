import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:standard_app/component/common/alert_dialog_706.dart';
import 'package:standard_app/component/page/mine/customer/customer_controller.dart';
import 'package:standard_app/component/page/mine/customer/customer_state.dart';
import 'package:standard_app/util/Toasts.dart';
import 'package:standard_app/util/dialog.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:standard_app/util/style.dart';

///客服管理UI
class CustomerPage extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  final CustomerController logic = Get.put(CustomerController());
  final CustomerState state = Get.find<CustomerController>().state;
  final ScrollController _myController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("客服中心"),
      body: _body(),
    );
  }

  ///聊天内容详情
  Widget _body() {
    return Container(
      child: Column(children: [
        Obx(() => new Flexible(
              child: ListView.builder(
                controller: _myController,
                padding: new EdgeInsets.all(16.0.sp),
                itemBuilder: (context, int index) => EntryItem(
                    state.messages[state.messages.length - index - 1]),
                itemCount: state.messages.length,
              ),
            )),
        new Divider(height: 1.0),
        new Container(
          child: _buildTextComposer(),
        )
      ]),
    );
  }

  //构造输入框
  Widget _buildTextComposer() {
    return new Container(
        padding: EdgeInsets.fromLTRB(20.sp, 0.sp, 20.sp, 30.sp),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(children: <Widget>[
          new Flexible(
              child: new TextField(
            controller: _textController,
            decoration: new InputDecoration.collapsed(hintText: '发送消息'),
          )),
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 4.0.sp),
            child: new IconButton(
                icon: new Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
                onPressed: () => _handleSubmitted(_textController.text)),
          ),
        ]));
  }

  ///发送信息
  void _handleSubmitted(String text) {
    _myController.jumpTo(_myController.position.maxScrollExtent + 80);
    _textController.clear(); //清空文本框
    logic.sendMessage(text);
  }
}

///构造发送的信息
class EntryItem extends StatelessWidget {
  final Message message;

  const EntryItem(this.message);

  Widget row() {
    ///由自己发送，在右边显示
    if (message.isSender) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _showTime(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: textBubble(message.text, Colors.green[100],
                      Colors.black, 10.sp, 30.sp),
                ),
                Container(
                  margin: EdgeInsets.only(left: 12.0.sp, right: 12.0.sp),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(message.avatar),
                    radius: 40.0.sp,
                  ),
                ),
              ],
            )
          ]);
    } else {
      ///对方发送，左边显示
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _showTime(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 12.0.sp, right: 12.0.sp),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(message.avatar),
                    radius: 40.0.sp,
                  ),
                ),
                Flexible(
                  child: message.type == "text"
                      ? textBubble(message.text, Colors.blue[100], Colors.black,
                          10.sp, 30.sp)
                      : InkWell(
                          onTap: () {
                            print("点击图片");
                            popDialog(
                                Get.context,
                                ShowAlertDialog706(
                                  items: ['取消', '确定'],
                                  title: "保存图片",
                                  content: "是否保存图片到手机相册",
                                  onTap: (index) {
                                    if (index == 1) {
                                      ImageUtils.saveImage(message.text);
                                      Toasts.show("图片保存成功");
                                    }
                                  },
                                ));
                          },
                          child: Image.network(
                            message.text,
                            width: 300.r,
                            height: 300.r,
                          )),
                ),
              ],
            )
          ]);
    }
  }

  Widget _showTime() {
    // timeLess(DateTime.parse(message.time), 2);
    return Padding(
        padding: EdgeInsets.only(top: 20.sp),
        child: Text(
          message.time,
          style: TextStyle(color: Colors.grey),
        ));
  }

  Widget textBubble(String content, Color colors, Color txtColor,
      double bottomleft, double bottomRight) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500.w),
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        padding: EdgeInsets.symmetric(
          horizontal: 34.w,
          vertical: 18.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomleft),
              bottomRight: Radius.circular(bottomRight),
              topRight: Radius.circular(0.0),
              topLeft: Radius.circular(5.0)),
          color: colors,
        ),
        child: SelectableText(
          content,
          style: TextStyle(color: txtColor, fontSize: 28.sp),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: row(),
    );
  }
}
