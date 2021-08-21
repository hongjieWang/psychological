import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/component/page/consulting_management/consulting/consulting_view.dart';
import 'package:standard_app/component/page/home/home_page.dart';
import 'package:standard_app/routes/routes.dart';

import 'mine/consulting_mine_page.dart';

///咨询管理
class ConsultingHomePage extends StatefulWidget {
  @override
  _ConsultingHomePageState createState() => _ConsultingHomePageState();
}

class _ConsultingHomePageState extends State<ConsultingHomePage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: '返回平台'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chat_bubble_2), label: '咨询管理'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person_circle), label: '我的')
  ];

  ///页面
  final List<Widget> tabBodies = [
    HomePage(),
    ConsultingPage(),
    ConsultingMinePage()
  ];

  ///索引
  int currentIndex = 1;

  ///选中的页面信息
  var currentPage;

  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          if (index == 0) {
            return goHome();
          }
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

  ///返回主页
  void goHome() {
    Get.offAndToNamed(RouteConfig.main);
  }
}
