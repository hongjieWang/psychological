import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/common/avatar.dart';
import 'package:standard_app/component/common/go_login_page.dart';
import 'package:standard_app/routes/routes.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:standard_app/util/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///我的关注
class MyFansPage extends StatefulWidget {
  const MyFansPage({Key key}) : super(key: key);

  @override
  _MyFansPageState createState() => _MyFansPageState();
}

class _MyFansPageState extends State<MyFansPage> {
  List datas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("我的关注", icon: Icons.arrow_back_ios),
      body: _body(),
    );
  }

  @override
  void initState() {
    super.initState();
    if (Global.getUserId() != "0" && Global.getUserId() != "null") {
      ApiService().focusList().then((value) => {
            if (value['code'] == Api.success)
              {
                setState(() {
                  datas = value['data'];
                })
              }
          });
    } else {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Get.toNamed(RouteConfig.goLoginPage);
      });
    }
  }

  ///关注主体
  Widget _body() {
    return Container(
      color: StyleUtils.bgColor,
      padding: EdgeInsets.only(left: 32.sp, right: 32.sp),
      child: ListView.separated(
        itemCount: datas.length,
        //列表项构造器
        itemBuilder: (BuildContext context, int index) {
          return _item(datas[index]);
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Color(0xFFF1F1F1),
          );
        },
      ),
    );
  }

  Widget _item(item) {
    return Container(
      width: double.infinity,
      height: 150.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Avatar(
                url: item['targetMembers']['avatar'],
                width: 106.sp,
                height: 106.sp,
              ),
              SizedBox(
                width: 24.sp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${item['targetMembers']['nickName'] == null ? "咨询师" : item['targetMembers']['nickName']}",
                    style: TextStyle(
                        color: StyleUtils.fontColor_3, fontSize: 32.sp),
                  ),
                  SizedBox(
                    height: 4.sp,
                  ),
                  Row(children: [
                    Image.asset(ImageUtils.getImgPath("certification3x")),
                    SizedBox(width: 6.sp),
                    Text(
                      "认证咨询师",
                      style:
                          TextStyle(color: Color(0xFF969CA5), fontSize: 24.sp),
                    ),
                  ])
                ],
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: Text("已关注",
                style:
                    TextStyle(color: StyleUtils.fontColor_3, fontSize: 22.sp)),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(StadiumBorder()),
              minimumSize: MaterialStateProperty.all(Size(148.sp, 44.sp)),
              //背景颜色
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                //设置按下时的背景颜色
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue[200];
                }
                //默认不使用背景颜色
                return Color(0xFFE7E7E7);
              }),
              padding: MaterialStateProperty.all(EdgeInsets.all(6.sp)),
            ),
          )
        ],
      ),
    );
  }
}
