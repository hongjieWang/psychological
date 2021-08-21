import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final String buttonName;
  final Function buttonAction;
  final TextEditingController controller;
  const InputWidget({
    Key key,
    @required this.title,
    @required this.hintText,
    @required this.controller,
    this.buttonName,
    this.buttonAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          Row(children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              width: 8,
            ),
            SizedBox(
              width: 1,
              height: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFFBDC2CE)),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    hintStyle:
                        TextStyle(fontSize: 13, color: Color(0xFFBDC2CE))),
                keyboardType: TextInputType.number,
              ),
            ),
            InkWell(
              onTap: buttonAction,
              child: Text(
                buttonName != null ? buttonName : "",
                style: TextStyle(fontSize: 13, color: Color(0xFF0B65DF)),
              ),
            ),
          ]),
          SizedBox(
            width: double.infinity,
            height: 0.5,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color(0xFFE3EBF0)),
            ),
          )
        ],
      ),
    );
  }
}
