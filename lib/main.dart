import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/component/common/data_statistics.dart';
import 'package:standard_app/routes/routes.dart';
import 'base/global.dart';
import 'package:package_info/package_info.dart';

import 'component/common/j_push_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //设置屏幕禁止旋转
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //全局配置文件初始化
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  Global.init().then((value) => {runApp(MyApp())});
}

class MyApp extends StatelessWidget {
  String page = Global.getPage();

//自动升级初始化
  MyApp() {
    FlutterXUpdate.init(debug: true);
    FlutterXUpdate.setErrorHandler(
        onUpdateError: (Map<String, dynamic> message) async {
      //下载失败
      if (message['code'] == 4000) {
        FlutterXUpdate.showRetryUpdateTipDialog(
            retryUrl: "www.baidu.com", retryContent: "app下载失败是否切换线路下载");
      }
    });
    FlutterXUpdate.checkUpdate(url: Api.checkUpdate);
    version();
    JPushUtils.instance;
  }

  Future<void> version() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(750, 1334),
        builder: () => GetMaterialApp(
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations
                      .delegate, //一定要配置,否则iphone手机长按编辑框有白屏卡着的bug出现
                ],
                supportedLocales: [
                  const Locale('zh', 'CN'), //设置语言为中文
                ],
                debugShowCheckedModeBanner: false,
                initialRoute: RouteConfig.main,
                routingCallback: (routing) {
                  if (page != null) {
                    DataStatistics.instance.onPageEnd(page);
                  }
                  page = routing.current;
                  Global.setPage(page);
                  DataStatistics.instance.onPageStart(routing.current);
                },
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                builder: (context, child) => Scaffold(
                      body: GestureDetector(
                        onTap: () {
                          hideKeyboard(context);
                        },
                        child: child,
                      ),
                    ),
                getPages: RouteConfig.routes));
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }
}
