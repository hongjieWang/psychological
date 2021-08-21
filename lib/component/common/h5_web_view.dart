import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:standard_app/util/style.dart';

///h5框架展示页
class H5WebViewPage extends StatefulWidget {
  H5WebViewPage({Key key, this.title, this.url}) : super(key: key);
  String title;
  String url;
  @override
  _H5WebViewPageState createState() =>
      _H5WebViewPageState(title: title, url: url);
}

class _H5WebViewPageState extends State<H5WebViewPage> {
  String url;
  String title;
  _H5WebViewPageState({this.url, this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: WebviewScaffold(
        url: url,
        withZoom: true,
        clearCache: true,
        useWideViewPort: true,
        withOverviewMode: true,
        appBar: StyleUtils.buildAppBar(title),
        //当WebView没加载出来前显示
        initialChild: Container(
          color: Colors.white,
          child: Center(
            child: Text("正在加载中...."),
          ),
        ),
      ),
    ));
  }
}
