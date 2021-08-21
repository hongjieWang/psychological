import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:standard_app/component/common/data_statistics.dart';

import 'consult/consult_page.dart';
import 'home/home_page.dart';
import 'mine/mine_page.dart';
import 'package:umeng_common_sdk/umeng_common_sdk.dart';

///首页导航栏
class IndexPage extends StatefulWidget {
  int currentIndex = 0;
  IndexPage({Key key, this.currentIndex}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: '首页'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chat_bubble_2), label: '咨询'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person_circle), label: '我的')
  ];

  ///页面
  final List<Widget> tabBodies = [HomePage(), ConsultPage(), MinePage()];

  ///索引
  int currentIndex = 0;

  ///选中的页面信息
  var currentPage;

  @override
  void initState() {
    currentIndex = widget.currentIndex;
    currentPage = tabBodies[currentIndex];
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initPlatformState() async {
    print("initPlatformState");
    String platformVersion;
    try {
      platformVersion = await UmengCommonSdk.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    print(platformVersion);
    if (!mounted) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 255, 255, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          DataStatistics.instance
              .event("index_page", {"page": mapIndexPageName(index)});
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }

  String mapIndexPageName(index) {
    if (index == 0) {
      return "首页";
    } else if (index == 1) {
      return "咨询";
    } else if (index == 2) {
      return "我的";
    }
  }
}
