import 'package:flutter/material.dart';
import 'package:standard_app/component/common/h5_web_view.dart';
import 'package:standard_app/util/style.dart';

///咨询师入驻
class JoinUsPage extends StatefulWidget {
  JoinUsPage({Key key}) : super(key: key);

  @override
  _JoinUsPageState createState() => _JoinUsPageState();
}

class _JoinUsPageState extends State<JoinUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: H5WebViewPage(title: "咨询师入驻",url: "https://julywhj-1258527903.cos.ap-beijing.myqcloud.com/706/banner/h5-1.jpg",),
    );
  }
}
