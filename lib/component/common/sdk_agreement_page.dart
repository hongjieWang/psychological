import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:standard_app/util/style.dart';
import 'package:url_launcher/url_launcher.dart';

///第三方sdk协议
class SdkAgreementPage extends StatefulWidget {
  SdkAgreementPage({Key key}) : super(key: key);

  @override
  _SdkAgreementPageState createState() => _SdkAgreementPageState();
}

class _SdkAgreementPageState extends State<SdkAgreementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("第三方sdk列表"),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      child: FutureBuilder(
        future: rootBundle.loadString('assets/files/第三方SDK协议.md'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Markdown(
              data: snapshot.data,
              styleSheet: MarkdownStyleSheet(
                // 支持修改样式
                h1: TextStyle(fontSize: 14),
              ),
              onTapLink: (test, href, title) {
                launch(href);
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
