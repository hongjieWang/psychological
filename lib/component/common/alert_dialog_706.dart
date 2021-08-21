import 'package:flutter/material.dart';

class ShowAlertDialog706 extends StatefulWidget {
  // 内容区域布局
  TextAlign contentAlign;
  // 标题
  String title;
  //内容
  String content;
  //内容
  Widget widget;
  // 点击返回index 0 1
  Function onTap;
  //按钮
  List<String> items;
  ShowAlertDialog706(
      {this.contentAlign = TextAlign.left,
      this.onTap,
      @required this.items,
      this.content,
      this.title,
      this.widget});
  @override
  _ShowAlertDialog706State createState() => _ShowAlertDialog706State();
}

class _ShowAlertDialog706State extends State<ShowAlertDialog706> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        // ClipRRect 创建圆角矩形 要不然发现下边button不是圆角
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: Color(0xFFFFFFFF),
            width: (260),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 20),
                (widget.title == null || widget.title.length == 0)
                    ? Container()
                    : Container(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              color: Color(0xFF222222),
                              fontWeight: FontWeight.bold,
                              fontSize: (17)),
                        ),
                      ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: widget.widget != null
                      ? widget.widget
                      : Text(
                          widget.content,
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: (12),
                          ),
                        ),
                ),
                SizedBox(height: 20),
                _itemCreat(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemCreat() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.items.map((res) {
          int index = widget.items.indexOf(res);
          return TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (widget.onTap != null) {
                widget.onTap(index);
              }
            },
            child: Text(
              res,
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                //设置按下时的背景颜色
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue[200];
                }
                //默认不使用背景颜色
                return index % 2 == 0 ? Color(0xFF999999) : Color(0xFF5191E8);
              }),
              padding: MaterialStateProperty.all(EdgeInsets.all(3)),
              minimumSize: MaterialStateProperty.all(Size(92, 26)),
              shape: MaterialStateProperty.all(StadiumBorder()),
            ),
          );
        }).toList(),
      ),
    );
  }
}
