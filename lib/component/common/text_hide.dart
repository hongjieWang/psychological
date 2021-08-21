import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextHide extends StatelessWidget {
  final String value;
  final bool isShowText;
  final Function showTextFun;
  const TextHide({Key key, this.value, this.isShowText, this.showTextFun})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _text(value),
    );
  }

  Widget _text(_text) {
    if (_isExpansion(_text)) {
      //是否截断
      if (isShowText) {
        return Column(
          children: <Widget>[
            new Text(
              _text,
              textAlign: TextAlign.left,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  showTextFun();
                },
                child: Text("[收起]"),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                  minimumSize: MaterialStateProperty.all(Size(10.sp, 10.sp)),
                ),
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: <Widget>[
            new Text(
              _text,
              maxLines: 2,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  showTextFun();
                },
                child: Text("[展开]"),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                  minimumSize: MaterialStateProperty.all(Size(10.sp, 10.sp)),
                ),
              ),
            ),
          ],
        );
      }
    } else {
      return Text(
        _text,
        maxLines: 2,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
      );
    }
  }

  bool _isExpansion(String text) {
    TextPainter _textPainter = TextPainter(
        maxLines: 2,
        text: TextSpan(
            text: text,
            style: TextStyle(fontSize: 16.0.sp, color: Colors.black)),
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: 200, minWidth: 50);
    if (_textPainter.didExceedMaxLines) {
      //判断 文本是否需要截断
      return true;
    } else {
      return false;
    }
  }
}
