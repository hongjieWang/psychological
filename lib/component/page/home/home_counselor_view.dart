import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/address_picker/locations_data.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:standard_app/component/page/home/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/component/page/home/home_state.dart';
import 'package:standard_app/util/image_util.dart';

///咨询师列表
class HomeCounselorPage extends StatelessWidget {
  final HomeController logic = Get.put(HomeController());
  final HomeState state = Get.find<HomeController>().state;


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Obx(
      () => ListView.separated(
        padding: EdgeInsets.only(top: 10.sp),
        shrinkWrap: true,
        primary: true,
        scrollDirection: Axis.vertical,
        itemCount: state.counselorData.length + 1,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (state.total.value > state.counselorData.length &&
              (state.counselorData.length != 0
                      ? state.counselorData.length - 1
                      : 0) ==
                  index) {
            //加载时显示loading
            return Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(strokeWidth: 2.0)),
            );
          } else if (state.total.value == state.counselorData.length &&
              state.counselorData.length == index) {
            state.loading.value = false;
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ));
          }
          return _item(state.counselorData[index]);
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    ));
  }

  ///咨询师展示列表
  Widget _item(counselor) {
    return Container(
        padding: EdgeInsets.only(left: 40.sp, right: 40.sp, bottom: 0.sp),
        child: InkWell(
          onTap: () {
            logic.onClickItem(counselor);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _avatar(counselor),
              _counselorContent(counselor),
              _priceAndAddress(counselor)
            ],
          ),
        ));
  }

  ///地区和金钱
  Widget _priceAndAddress(counselor) {
    List<String> address = Address.getCityNameByCode(
        provinceCode: "${counselor['members']['province']}",
        cityCode: "${counselor['members']['city']}");
    return Container(
      height: 140.sp,
      width: 110.sp,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                ImageUtils.getImgPath("address3x"),
                width: 7,
                height: 9,
              ),
              SizedBox(width: 3),
              Text(
                address.isNotEmpty ? "${address[0]}\n${address[1]}" : "-",
                style: TextStyle(fontSize: 20.sp, color: Color(0xFFBDC2CE)),
              ),
            ],
          ),
          Text(
            "¥ ${counselor['price'] == 0 ? counselor['counselorLevelEntity']['minPrice'] : counselor['price']}",
            style: TextStyle(
                color: Color(0xFFF2C13B), fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  ///咨询师姓名标签展示
  Widget _counselorContent(counselor) {
    return Container(
      width: 410.sp,
      padding: EdgeInsets.only(left: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(counselor["members"]["membersName"],
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
              SizedBox(
                width: 20.sp,
              ),
              Text(
                counselor["aptitudes"],
                style: TextStyle(color: Color(0xFF666666), fontSize: 12),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 6.sp),
            child: Text.rich(
              TextSpan(children: [
                TextSpan(
                  text:
                      "${counselor["consultNum"] == 0 ? "暂无" : counselor["consultNum"]}",
                  style: TextStyle(color: Color(0xFF3A8DFF), fontSize: 10),
                ),
                TextSpan(
                  text: "人咨询过  ",
                  style: TextStyle(fontSize: 10),
                ),
                TextSpan(
                  text:
                      "${counselor["evaluateNum"] == 0 ? "暂无" : counselor["evaluateNum"]}",
                  style: TextStyle(color: Color(0xFF3A8DFF), fontSize: 10),
                ),
                TextSpan(
                  text: "人评价",
                  style: TextStyle(fontSize: 10),
                ),
              ]),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Wrap(
            spacing: 12.sp, // 主轴(水平)方向间距
            runSpacing: 4.0.sp,
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: _lables(counselor),
          )
        ],
      ),
    );
  }

  ///评分组件
  Widget _rating(_ratingSource) {
    return Padding(
      padding: EdgeInsets.zero,
      child: RatingBarIndicator(
        rating: _ratingSource,
        itemSize: 30.0.sp,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
      ),
    );
  }

  /// 咨询师标签
  List<Widget> _lables(counselor) {
    int size = counselor['goodFieldEntities'] != null
        ? counselor['goodFieldEntities'].length
        : 3;
    List<Widget> lables = [];
    for (int i = 0; i < size; i++) {
      lables.add(Container(
        width: 120.sp,
        height: 42.sp,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            border: new Border.all(color: Color(0xFFF1F1F1), width: 0.5),
            color: Color(0xFFF1F1F1),
            borderRadius: new BorderRadius.circular((20.0.sp))),
        child: new Text(
          counselor['goodFieldEntities'][i]['counselorLabelName'],
          style: TextStyle(fontSize: 10, color: Color(0xFF6E788A)),
        ),
      ));
    }
    return lables;
  }

  /// 头像
  Widget _avatar(item) {
    return Container(
      child: InkWell(
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(60.sp)),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              item["members"]["avatar"],
              width: 126.r,
              height: 126.r,
              fit: BoxFit.cover,
            )),
        onTap: () {},
      ),
    );
  }
}
