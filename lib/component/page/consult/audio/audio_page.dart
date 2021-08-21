import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AudioPage extends StatefulWidget {
  final int timeCountdown;
  final Map map;
  final Function leaveChannel;
  final Function videoTovoice;

  AudioPage(
      {Key key,
      this.timeCountdown,
      this.map,
      this.leaveChannel,
      this.videoTovoice})
      : super(key: key);

  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  Timer _timer;
  int _timeCountdown;
  String _play;
  Color bgCorlor;
  bool isMute;
  bool isUp;
  int count;
  Map map;
  Function leaveChannel;
  Function videoTovoice;

  @override
  void initState() {
    super.initState();
    map = widget.map;
    _timeCountdown = widget.timeCountdown;
    leaveChannel = widget.leaveChannel;
    videoTovoice = widget.videoTovoice;
    count = _timeCountdown;
    _timeCountdownStart();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      decoration: new BoxDecoration(
        //背景
        color: Colors.white,
      ),
      padding:
          EdgeInsets.fromLTRB(30.0.sp, Get.statusBarHeight.sp, 30.0.sp, 0.0.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_top(), _buttom()],
      ),
    );
  }

  Widget _top() {
    return Column(
      children: [_avatar(), _name()],
    );
  }

  ///语音通话全屏和电话部分
  Widget _head() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.close_fullscreen,
          color: Colors.black,
          size: 60.sp,
        ),
      ]),
    );
  }

  //咨询师头像
  Widget _avatar() {
    return Padding(
      padding: EdgeInsets.only(top: 100.0.sp),
      child: InkWell(
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10)),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                map['avatar'],
                width: 250.r,
                height: 250.r,
              )),
          onTap: () {}),
    );
  }

  ///姓名组件显示
  Widget _name() {
    return Padding(
      padding: EdgeInsets.only(top: 30.sp),
      child: Text(
        map['name'],
        style: TextStyle(
            fontSize: 35.sp, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  ///底部组件显示
  Widget _buttom() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Text(
            _play == null ? '开启扬声器' : _play,
            style: TextStyle(color: Colors.black, fontSize: 30.sp),
          ),
          _timeCountdownWiget(),
          _voideBtn()
        ],
      ),
    );
  }

  /// 倒计时显示组件
  Widget _timeCountdownWiget() {
    return Padding(
      padding: EdgeInsets.only(bottom: 40.sp, top: 20.sp),
      child: Text(
          _timeCountdown == null ? '50:00' : "${count ~/ 60}:${count % 60}",
          style: TextStyle(color: Colors.black, fontSize: 30.sp)),
    );
  }

  ///点击按钮事件
  _onClickBtn(name) {
    if (name == "挂断") {
      leaveChannel();
    } else if (name == "转视频") {
      videoTovoice();
    }
  }

  ///倒计时触发器
  void _timeCountdownStart() {
    const oneSec = const Duration(seconds: 1);
    var callback = (timer) => {
          setState(() {
            count = count - 1;
          })
        };
    _timer = Timer.periodic(oneSec, callback);
  }

  ///通话操作按钮
  Widget _voideBtn() {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0.sp, 0.0.sp, 40.0.sp, 40.0.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _muteBtn(
              '转视频',
              Icons.videocam,
              Colors.black38,
              bgCorlor != null && isMute != null && isMute
                  ? bgCorlor
                  : Colors.black12,
              _onClickBtn),
          _muteBtn('挂断', Icons.call_end_outlined, Colors.black, Colors.red,
              _onClickBtn),
        ],
      ),
    );
  }

  /// 底部按钮组件
  Widget _muteBtn(name, icon, color, backgroundColor, onClickFun) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(children: [
        InkWell(
          onTap: () {
            onClickFun(name);
          },
          child: Container(
            width: 140.r,
            height: 140.r,
            decoration: new BoxDecoration(
              //背景
              color: backgroundColor,
              //设置四周圆角 角度
              borderRadius: BorderRadius.all(Radius.circular(70.sp)),
              border: new Border.all(width: 3.0.sp, color: Colors.white38),
            ),
            child: Icon(
              icon,
              size: 70.sp,
              color: color,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.sp),
          child: Text(
            name,
            style: TextStyle(
                fontSize: 30.sp, fontWeight: FontWeight.bold, color: color),
          ),
        )
      ]),
    );
  }
}
