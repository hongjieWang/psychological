import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectDateTime extends StatefulWidget {
  final String title;
  final List dateList;
  final List selected;
  final Function onClickFun;
  final bool showTitle;
  SelectDateTime(
      {Key key,
      this.title,
      this.dateList,
      this.selected,
      this.onClickFun,
      this.showTitle})
      : super(key: key);

  @override
  _SelectDateTimeState createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  String title;
  List dateList;
  List selected;
  Color btn;
  Function onClickFun;
  @override
  Widget build(BuildContext context) {
    title = widget.title;
    dateList = widget.dateList;
    selected = widget.selected;
    onClickFun = widget.onClickFun;
    return Container(
      padding: EdgeInsets.only(top: 10.sp),
      child: _selectDateTime(),
    );
  }

  ///将该模块抽成组件-时间组件编写
  Widget _selectDateTime() {
    return Container(
      child: Container(
          decoration: new BoxDecoration(
            //背景
            color: Colors.white,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(20.0.sp)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Offstage(offstage: widget.showTitle, child: _timeTitle()),
              Offstage(
                  offstage: widget.showTitle,
                  child: Divider(
                      height: 0,
                      indent: 20.sp,
                      endIndent: 20.sp,
                      color: Colors.black26)),
              _timeBody()
            ],
          )),
    );
  }

  /// 组件标题
  Widget _timeTitle() {
    return Container(
      padding: EdgeInsets.only(left: 20.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close, size: 50.sp),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('确认'))
        ],
      ),
    );
  }

  ///组件内容显示
  Widget _timeBody() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _week(),
        ],
      ),
    );
  }

  Widget _week() {
    return Container(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _days(),
          )),
    );
  }

  List<Widget> _days() {
    List<Widget> list = [];
    if (dateList.isNotEmpty) {
      dateList.forEach((element) {
        list.add(_day(element));
      });
    }
    return list;
  }

  ///当天时间显示
  Widget _day(day) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.zero,
            child: Row(children: _listDay(day)),
          ),
          Padding(
              padding: EdgeInsets.zero,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: _listItem(day)),
              ))
        ],
      ),
    );
  }

  List<Widget> _listDay(data) {
    List<Widget> list = [];
    list.add(_item(data));
    // list.add(_item(element));
    return list;
  }

  List<Widget> _listItem(data) {
    List times = data['times'];
    List<Widget> list = [];
    if (times.isNotEmpty) {
      // list.add(_item(data));
      times.forEach((element) {
        if (element['isFree']) {
          list.add(_item(element));
        }
      });
    }
    return list;
  }

  ///单个时间块显示
  Widget _item(data) {
    return Padding(
        padding: EdgeInsets.all(10.sp),
        child: TextButton(
          onPressed: data['isFree']
              ? () {
                  _onClickTime(data);
                }
              : null,
          child: Text(
            data['title'],
            style: TextStyle(
                color: data['isFree'] ? Colors.black : Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w300),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              btn = data['isFree'] ? Colors.white : Color(0xFF9b95c9);
              if (selected.contains(data)) {
                btn = Colors.indigo[200];
              }
              return btn;
            }),
            //设置边框
            side: MaterialStateProperty.all(
                BorderSide(color: Colors.black12, width: 1)),
            minimumSize: MaterialStateProperty.all(Size(50.r, 50.r)),
          ),
        ));
  }

  ///时间选择
  _onClickTime(item) {
    setState(() {
      if (selected.contains(item)) {
        selected.remove(item);
      } else {
        if (this.selected.isNotEmpty) {
          selected.removeLast();
        }
        selected.add(item);
        btn = Colors.blue[300];
        onClickFun(item);
      }
    });
  }
}
