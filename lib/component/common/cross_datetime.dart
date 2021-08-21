import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///横向时间选择器
// ignore: must_be_immutable
class CrossDateTime extends StatefulWidget {
  final String title;
  final List dateList;
  final List selected;
  final Function onClickFun;
  bool edit = false;
  Function editFun;
  Function clearFun;
  CrossDateTime(
      {Key key,
      this.title,
      this.dateList,
      this.selected,
      this.onClickFun,
      this.edit,
      this.editFun,
      this.clearFun})
      : super(key: key);

  @override
  _CrossDateTimeState createState() => _CrossDateTimeState();
}

class _CrossDateTimeState extends State<CrossDateTime> {
  //标题
  String title;
  //时间数据
  List dateList;
  //已选择数据
  List selected;
  Map selectedDay = {};
  Map selectedTime = {};
  Function onClickFun;
  bool edit = false;
  Function editFun;
  Function clearFun;
  @override
  Widget build(BuildContext context) {
    title = widget.title;
    dateList = widget.dateList;
    selected = widget.selected;
    onClickFun = widget.onClickFun;
    edit = widget.edit == null ? false : widget.edit;
    editFun = widget.editFun == null ? () {} : widget.editFun;
    clearFun = widget.clearFun == null ? () {} : widget.clearFun;
    if (dateList != null) {
      if (selectedDay.isEmpty) {
        selectedDay = dateList.length > 0 ? dateList.first : {};
      } else {
        dateList.forEach((element) {
          if (element['day'] == selectedDay['day']) {
            selectedDay = element;
          }
        });
      }
    }

    return Container(
      decoration: new BoxDecoration(
        //背景
        color: Colors.white,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: _dateTime(),
    );
  }

  ///选择器
  Widget _dateTime() {
    return Column(
      children: [
        _days(),
        Divider(
          height: 0,
          indent: 10.0.sp,
          endIndent: 10.0.sp,
          color: Colors.black12,
        ),
        _time()
      ],
    );
  }

  ///日期选择组件
  Widget _days() {
    return Padding(
        padding: EdgeInsets.fromLTRB(10.0.sp, 10.0.sp, 10.0.sp, 0.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _dayItems(),
          ),
        ));
  }

  List<Widget> _dayItems() {
    List<Widget> dates = [];
    if (dateList.isNotEmpty) {
      dateList.forEach((element) {
        dates.add(_day(element));
      });
    }
    return dates;
  }

  ///单个日期组件
  Widget _day(date) {
    bool _isSelected = false;
    if (selectedDay['title'] == date['title']) {
      _isSelected = true;
    }
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(children: [
          InkWell(
            onTap: () {
              _onClickDay(date);
            },
            child: Column(
              children: [
                Text(
                  date['title'],
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF333333)),
                ),
                Offstage(
                  offstage: !_isSelected,
                  child: Container(
                    width: 50 * 2.sp,
                    height: 10.sp,
                    decoration: BoxDecoration(
                      color: Color(0xFF80ADEA),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]));
  }

  ///时间显示组件
  Widget _time() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Wrap(children: timeItems(selectedDay)),
    );
  }

  List<Widget> timeItems(Map data) {
    List<Widget> times = [];
    if (data.isNotEmpty) {
      List ts = data['times'];
      if (ts.isNotEmpty) {
        ts.forEach((element) {
          if (element['isFree']) {
            times.add(_timeItem(element));
          }
        });
      }
    }
    if (edit) {
      times.add(IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          editFun(this.selectedDay);
        },
      ));
      times.add(TextButton(
        onPressed: () {
          clearFun(this.selectedDay);
        },
        child: Text("清空"),
      ));
    }
    return times;
  }

  Widget _timeItem(time) {
    bool _isSelected = false;
    if (selectedTime.hashCode == time.hashCode) {
      _isSelected = true;
    }
    return Padding(
        padding: EdgeInsets.fromLTRB(10.sp, 0.0.sp, 10.0.sp, 6.0.sp),
        child: TextButton(
          onPressed: () {
            _onClickTime(time);
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: time['time'],
              style: TextStyle(
                  color: _isSelected ? Color(0xFF3A8DFF) : Color(0xFF999999),
                  fontSize: 11),
            ),
            WidgetSpan(
              child: Offstage(
                  offstage: !edit,
                  child: Icon(
                    Icons.close,
                    size: 20,
                  )),
            )
          ])),
          style: ButtonStyle(
            side: MaterialStateProperty.all(BorderSide(
                color: _isSelected ? Color(0xFF3A8DFF) : Color(0xFFE7E7E7),
                width: 1)),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return _isSelected ? Color(0xFFD9E9FF) : Colors.white;
            }),
            shape: MaterialStateProperty.all(StadiumBorder()),
            //设置按钮内边距
            padding: MaterialStateProperty.all(EdgeInsets.all(4)),
            //设置按钮的大小
            minimumSize: MaterialStateProperty.all(Size(55 * 2.sp, 24 * 2.sp)),
          ),
        ));
  }

  //日期点击事件
  _onClickDay(date) {
    setState(() {
      this.selectedDay = date;
    });
  }

  //时间点击事件
  _onClickTime(Map time) {
    var map = new Map();
    map['time'] = time;
    map['day'] = this.selectedDay;
    setState(() {
      if (this.selectedTime.isNotEmpty &&
          time.hashCode == this.selectedTime.hashCode) {
        this.selectedTime = {};
        this.selected.remove(time);
      } else {
        this.selectedTime = time;
        this.selected.clear();
        this.selected.add(this.selectedTime);
        onClickFun(map);
      }
    });
  }
}
