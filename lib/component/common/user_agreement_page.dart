import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:standard_app/util/style.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

///用户协议
class UserAgreementPage extends StatefulWidget {
  @override
  _UserAgreementPageState createState() => _UserAgreementPageState();
}

class _UserAgreementPageState extends State<UserAgreementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("用户协议"),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      child: FutureBuilder(
        future: rootBundle.loadString('assets/files/706在线心理咨询用户注册协议.md'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Markdown(data: snapshot.data);
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
