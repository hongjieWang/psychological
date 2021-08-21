import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/style.dart';

///隐私政策
class PrivacyPolicyPage extends StatefulWidget {
  PrivacyPolicyPage({Key key}) : super(key: key);

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("隐私政策"),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      child: FutureBuilder(
        future: rootBundle.loadString('assets/files/隐私政策.md'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Markdown(
              data: snapshot.data,
              styleSheet: MarkdownStyleSheet(
                // 支持修改样式
                h1: TextStyle(fontSize: 14),
              ),
              onTapLink: (test, href, title) {
                Get.toNamed(RouteConfig.sdkAgreementPage);
              },
            );
          } else {
            return Center(
              child: Text("加载中..."),
            );
          }
        },
      ),
    );
  }
}
