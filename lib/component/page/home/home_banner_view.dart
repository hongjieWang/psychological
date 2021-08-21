import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/component/common/data_statistics.dart';
import 'package:standard_app/component/common/h5_web_view.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({Key key}) : super(key: key);

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  List bannerImages = [];

  @override
  void initState() {
    super.initState();
    ApiService().getBannerList().then((value) => {
          if (value['code'] == Api.success)
            {
              setState(() {
                bannerImages = value['rows'];
              })
            }
          else
            {
              Future.delayed(const Duration(milliseconds: 1000), () {
                ApiService().getBannerList().then((value) => {
                      setState(() {
                        bannerImages = value['rows'];
                      })
                    });
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 32.sp, right: 32.sp),
      height: 350.0.sp,
      width: double.infinity,
      child: Swiper(
          itemCount: bannerImages.length,
          itemBuilder: (context, int index) => InkWell(
              child: new Container(
                  decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(const Radius.circular(5)),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        '${bannerImages[index]['bannerImageUrl']}')),
              )),
              onTap: () {
                DataStatistics.instance.event("banner", {"name": "$index"});
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return H5WebViewPage(
                    title: bannerImages[index]['bannerName'],
                    url: bannerImages[index]['bannerLink'],
                  );
                }));
              }),
          autoplay: true,
          viewportFraction: 1,
          scale: 0.5,
          duration: 300,
          key: UniqueKey(),
          pagination: SwiperPagination(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(2),
              builder: DotSwiperPaginationBuilder(size: 5, activeSize: 5))),
    );
  }
}
