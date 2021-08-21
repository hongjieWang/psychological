import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:standard_app/util/image_util.dart';

/// icon
class TopTypeGridView extends StatelessWidget {
  List mTypeData;

  TopTypeGridView({Key key, @required this.mTypeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: 90,
      child: new GridView.builder(
          padding: EdgeInsets.only(top: 0, bottom: 0),
          itemCount: mTypeData.length,
          shrinkWrap: true,
          //  禁止滑动
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return _buildItem(context, index, mTypeData[index]);
          }),
    );
  }

  _buildItem(BuildContext context, int index, String data) {
    return new InkWell(
      // 竖向布局
      child: new Column(children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: new Container(
            width: 50,
            height: 50,
            child: Image.asset(ImageUtils.getImgPath("seelp_icon3x")),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0),
          child: Text(
            data,
            style: new TextStyle(
                fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
      onTap: () {
        switch (index) {
        }
      },
    );
  }
}
