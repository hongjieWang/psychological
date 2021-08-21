import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///语音咨询
class VoiceConsultPage extends StatefulWidget {
  final int timeCountdown;
  VoiceConsultPage({Key key, this.timeCountdown = 60 * 50}) : super(key: key);

  @override
  _VoiceConsultPageState createState() => _VoiceConsultPageState();
}

class _VoiceConsultPageState extends State<VoiceConsultPage> {
  Timer _timer;
  int _timeCountdown;
  String _play;
  Color bgCorlor;
  bool isMute;
  bool isUp;
  int count;
  @override
  void initState() {
    super.initState();
    _timeCountdownStart();
  }

  @override
  Widget build(BuildContext context) {
    this._timeCountdown = widget.timeCountdown;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      decoration: new BoxDecoration(
        //背景
        color: Colors.black38,
      ),
      padding: EdgeInsets.fromLTRB(30.0.sp, 40.0.sp, 30.0.sp, 0.0.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_top(), _buttom()],
      ),
    );
  }

  Widget _top() {
    return Column(
      children: [_head(), _avatar(), _name()],
    );
  }

  ///语音通话全屏和电话部分
  Widget _head() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.close_fullscreen,
          color: Colors.white70,
          size: 60.sp,
        ),
        _onCall()
      ]),
    );
  }

  ///电话组件
  Widget _onCall() {
    return Container(
      padding: EdgeInsets.only(right: 10.0.sp),
      child: TextButton(
          onPressed: () {},
          child: Column(
            children: [
              Icon(
                Icons.phone,
                color: Colors.white70,
              ),
              Text(
                '50:00',
                style: TextStyle(color: Colors.white70),
              )
            ],
          ),
          style: ButtonStyle()),
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
                'https://julywhj-1258527903.cos.ap-beijing.myqcloud.com/2021/avg.jpeg',
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
        '咨询师姓名',
        style: TextStyle(
            fontSize: 35.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white70),
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
            style: TextStyle(color: Colors.white70, fontSize: 30.sp),
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
      child: Text(count == null ? '50:00' : "${count ~/ 60}:${count % 60}",
          style: TextStyle(color: Colors.white70, fontSize: 30.sp)),
    );
  }

  ///点击按钮事件
  _onClickBtn(name) {
    setState(() {
      bgCorlor = Colors.white60;
      if (name == '静音') {
        if (this.isMute != null) {
          this.isMute = !this.isMute;
        } else {
          this.isMute = true;
        }
      }
      if (name == '免提') {
        if (this.isUp != null) {
          this.isUp = !this.isUp;
        } else {
          this.isUp = true;
        }
      }
    });
  }

  ///倒计时触发器
  void _timeCountdownStart() {
    const oneSec = const Duration(seconds: 1);
    var callback = (timer) => {
          setState(() {
            if (count == null) {
              count = this._timeCountdown;
            }
            this.count = this.count - 1;
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
              '静音',
              Icons.mic_off_outlined,
              Colors.black38,
              bgCorlor != null && isMute != null && isMute
                  ? bgCorlor
                  : Colors.black12,
              _onClickBtn),
          _muteBtn('挂断', Icons.call_end_outlined, Colors.white, Colors.red,
              _onClickBtn),
          _muteBtn(
              '免提',
              Icons.volume_up_outlined,
              Colors.black38,
              bgCorlor != null && isUp != null && isUp
                  ? bgCorlor
                  : Colors.black12,
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
