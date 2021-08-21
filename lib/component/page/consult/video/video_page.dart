import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/app_constant.dart';
import 'package:standard_app/component/common/alert_dialog_706.dart';
import 'package:standard_app/component/page/consult/audio/audio_page.dart';
import 'package:standard_app/component/page/consult/consult_controller.dart';
import 'package:standard_app/component/page/consult/consult_state.dart';
import 'package:standard_app/component/page/index_page.dart';
import 'package:standard_app/util/dialog.dart';
import 'package:wakelock/wakelock.dart';

///视频咨询
class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final ConsultController logic = Get.put(ConsultController());
  final ConsultState state = Get.find<ConsultController>().state;

  RtcEngine _engine;
  Timer _timer;
  bool isJoined = false, switchCamera = true, switchRender = true;
  int remoteUid = 999;
  String channelName = Get.arguments['channelName'];
  String token = Get.arguments['token'];
  var uid = Get.arguments['uid'];

  ///展示用户信息
  Map userInfo = Get.arguments['userInfo'];

  ///房间是否有用户加入
  bool isHasUser = false;

  ///是否是视频咨询
  bool isVideo = true;

  @override
  void initState() {
    state.consult.value = Get.arguments['consult'];
    isVideo = state.consult.value['way'] == AppConstant.videoWay;
    super.initState();
    state.countdown.value = logic.getTimeLength(state.consult.value);
    _timeCountdownStart();
    this._initEngine();
  }

  ///倒计时触发器
  void _timeCountdownStart() {
    const oneSec = const Duration(seconds: 1);
    var callback = (timer) => {
          state.countdown.value = state.countdown.value - 1,
          if (state.countdown.value == 300)
            {
              alert("时间提示", "剩余时间不足5分钟,是否增加时间？\n建议:先于咨询师确认在续时",
                  logic.onFuncOnceAgainToBuy, ['残忍离开', '续时(支付)'])
            },
          if (state.countdown.value == 0)
            {
              alert("结束提示", "您的本次咨询已结束。 \n\n 您可对本次服务进行评价",
                  logic.onClickEvaluate, ['取消', '去评价'])
            },
          if (state.countdown.value == -60) {_leaveChannel(), _timer.cancel()}
        };
    _timer = Timer.periodic(oneSec, callback);
  }

  @override
  void dispose() {
    // Wakelock.disable();
    if (_engine != null) {
      _engine.destroy();
    }
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  ///到期提醒
  void alert(String title, String content, Function func, items) {
    popDialog(
        Get.context,
        ShowAlertDialog706(
          items: items,
          title: title,
          content: content,
          onTap: (index) {
            if (index == 1) {
              func(state.consult.value);
            }
          },
        ));
  }

  _initEngine() async {
    requestPermission();
    _engine =
        await RtcEngine.createWithConfig(RtcEngineConfig(AppConstant.AG_APPID));
    this._addListeners();
    VideoEncoderConfiguration config = VideoEncoderConfiguration();
    _engine.setVideoEncoderConfiguration(config);
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
    _joinChannel();
  }

  ///添加监听
  _addListeners() {
    _engine.setEventHandler(
        RtcEngineEventHandler(joinChannelSuccess: (channel, uid, elapsed) {
      print('joinChannelSuccess ${channel} ${uid} ${elapsed}');
      setState(() {
        isJoined = true;
      });
      ApiService().joinChannelSuccess({
        "channel": channel,
        "uid": uid,
        "elapsed": elapsed
      }).then((value) => print(value));
    }, userJoined: (uid, elapsed) {
      print('userJoined  ${uid} ${elapsed}');
      ApiService().userJoined({
        "channel": channelName,
        "uid": uid,
        "elapsed": "$elapsed"
      }).then((value) => print(value));
      setState(() {
        isHasUser = true;
        remoteUid = uid;
      });
    }, userOffline: (uid, reason) {
      print('userOffline  ${uid} ${reason}');
      ApiService().userOffline({
        "channel": channelName,
        "uid": uid,
        "elapsed": "$reason"
      }).then((value) => print(value));
      setState(() {
        remoteUid = 999;
      });
    }, leaveChannel: (stats) {
      print('leaveChannel is ${stats.toJson()}');
      setState(() {
        isJoined = false;
        remoteUid = 999;
      });
    }, remoteVideoStateChanged: (uid, state, reason, elapsed) {
      print("远端视频已改变：$uid, $state, $reason,$elapsed");
    }));
  }

  ///加入频道
  _joinChannel() async {
    Wakelock.enable();
    print('token [$token] , channelName [$channelName]');
    print("uid is $uid");
    await _engine.joinChannel(token, channelName, null, int.parse(uid));
  }

  ///离开频道
  _leaveChannel() async {
    Wakelock.disable();
    if (_engine != null) {
      await _engine.leaveChannel();
    }
    ApiService().leaveChannel({
      "channel": channelName,
    }).then((value) => print(value));
    Get.offAll(IndexPage(currentIndex: 1));
  }

  ///切换摄像头
  _switchCamera() {
    _engine.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      log('switchCamera $err');
    });
  }

  ///视频语音互相转化
  _videoTovoice() {
    setState(() {
      if (isVideo) {
        ///关闭摄像头
        _engine.disableVideo();
      } else {
        ///打开摄像头
        _engine.enableVideo();
      }
      isVideo = !isVideo;
    });
  }

  _switchRender() {
    setState(() {
      switchRender = !switchRender;
    });
  }

  Future requestPermission() async {
    print("申请权限");
    await [Permission.camera].request();
    await [Permission.microphone].request();
    var status = await Permission.camera.status;
    var microphone = await Permission.microphone.status;
    print(microphone.isGranted);
    print(status.isGranted);
  }

  @override
  Widget build(BuildContext context) {
    return isVideo
        ? videoWidget()
        : AudioPage(
            timeCountdown: logic.getTimeLength(state.consult.value),
            map: userInfo,
            leaveChannel: _leaveChannel,
            videoTovoice: _videoTovoice,
          );
  }

  ///视频咨询画布
  Stack videoWidget() {
    return Stack(
      children: [
        Column(
          children: [
            _renderVideo(),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 140),
            child: Obx(() => Text(
                  "${state.countdown.value < 0 ? "已结束" : buildShowTime()}",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 150.sp),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 110.sp,
                  height: 110.sp,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(60.sp),
                      ),
                      border: new Border.all(width: 4.sp, color: Colors.white)),
                  child: IconButton(
                    onPressed: this._videoTovoice,
                    icon: Icon(
                      Icons.mic,
                      size: 60.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.sp,
                ),
                Container(
                  width: 100.sp,
                  height: 100.sp,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(60.sp)),
                  ),
                  child: IconButton(
                    onPressed: this._leaveChannel,
                    icon: Icon(
                      Icons.call_end,
                      size: 60.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.sp,
                ),
                Container(
                    width: 110.sp,
                    height: 110.sp,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(60.sp),
                        ),
                        border:
                            new Border.all(width: 4.sp, color: Colors.white)),
                    child: IconButton(
                      onPressed: this._switchCamera,
                      icon: Icon(
                        Icons.party_mode,
                        size: 60.sp,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }

  ///本地视频
  _renderVideo() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.black),
            child: RtcRemoteView.SurfaceView(
              uid: remoteUid,
            ),
          ),
          Offstage(
            offstage: remoteUid != 999,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "对方接入中,请稍后...",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
                onTap: this._switchRender,
                child: Padding(
                  padding: EdgeInsets.only(top: 100.sp),
                  child: Container(
                      width: 240.sp,
                      height: 360.sp,
                      child: RtcLocalView.SurfaceView()),
                )),
          ),
        ],
      ),
    );
  }

  ///倒计时显示
  String buildShowTime() {
    var min = state.countdown.value ~/ 60;
    var sen = state.countdown.value % 60;
    return "$min:$sen";
  }
}
