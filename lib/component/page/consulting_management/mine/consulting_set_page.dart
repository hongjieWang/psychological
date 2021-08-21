import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/common/cross_datetime.dart';
import 'package:standard_app/http/dio_util.dart';
import 'package:standard_app/util/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:standard_app/util/time_data.dart';

///咨询设置
class ConsultingSetPage extends StatefulWidget {
  @override
  _ConsultingSetPageState createState() => _ConsultingSetPageState();
}

class _ConsultingSetPageState extends State<ConsultingSetPage> {
  bool edit = false;
  List times = Get.arguments;

  ///分钟监听器
  TextEditingController _minController;

  ///价格监听器
  TextEditingController _priceController;

  ///语音复选框
  bool _voiceSelected = false;

  ///视频咨询
  bool _videoSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleUtils.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("咨询设置",
            style: StyleUtils.appBarTitleStyle(), textScaleFactor: 1.0),
        leading: Builder(builder: (context) {
          return IconButton(
              icon: Icon(Icons.close, color: Colors.black), //自定义图标
              iconSize: 20,
              onPressed: () {
                Get.back();
              });
        }),
        actions: <Widget>[
          //导航栏右侧菜单
          TextButton(
            onPressed: () {
              if (edit) {
                _submit();
              }
              setState(() {
                edit = !edit;
              });
            },
            child:
                Text(edit ? "完成" : "编辑", style: TextStyle(color: Colors.black)),
          )
        ],
      ),
      body: _body(),
    );
  }

  @override
  void initState() {
    _minController = TextEditingController(text: "50");
    _priceController = TextEditingController(text: "500");
    super.initState();
  }

  ///提交咨询师配置数据
  _submit() {
    Map data = {};

    ///添加咨询类型数据 1 视频 2 语音 9 全部
    int way = 0;
    if (_voiceSelected && _videoSelected) {
      way = 9;
    } else if (_voiceSelected) {
      way = 2;
    } else {
      way = 1;
    }
    data['way'] = way; //咨询类型
    data['price'] = _priceController.text;
    data['minutes'] = _minController.text;
    data['timeConfig'] = defaultTime;
    data['counselorId'] = Global.getCounselorId();
    DioUtil()
        .post(Api.CONSULT_CONFIG_API, data: data)
        .then((value) => print(value));
  }

  ///编辑主体内容
  Widget _body() {
    return Container(
        child: SingleChildScrollView(
            child: Column(
      children: [
        Offstage(
          offstage: edit,
          child: _title("预约咨询", _appointmentConsulting()),
        ),
        Offstage(
            offstage: edit,
            child: SizedBox(
              height: 20.sp,
            )),
        Offstage(offstage: edit, child: _title("咨询时间", _consultingTime())),
        Offstage(
            offstage: edit,
            child: SizedBox(
              height: 50.sp,
            )),
        Offstage(offstage: edit, child: _stopAppointment()),
        Offstage(offstage: !edit, child: _consultingType()),
        Offstage(offstage: !edit, child: _title("收费时长", _timePrice())),
        Offstage(offstage: !edit, child: _title("咨询时间", _consultingTimeEdit())),
      ],
    )));
  }

  ///编辑时间
  Widget _consultingTimeEdit() {
    return Container(
      child: new CrossDateTime(
        title: '申请调整时间',
        dateList: defaultTime,
        selected: [],
        onClickFun: remove,
        edit: true,
        editFun: _addTime,
        clearFun: _clear,
      ),
    );
  }

  ///清空所有
  void _clear(selectDay) {
    setState(() {
      List newDefalutTime = [];
      defaultTime.forEach((element) {
        if (element['day'] == selectDay['day']) {
          Map newElement = {
            "day": element['day'],
            "title": element['title'],
            "times": []
          };
          newDefalutTime.add(newElement);
          return;
        }
        newDefalutTime.add(element);
      });
      defaultTime = newDefalutTime;
    });
  }

  ///添加数据
  void _addTime(selectDay) {
    Pickers.showDatePicker(
      context,
      mode: DateMode.H,
      onConfirm: (p) {
        Map map = {
          "isFree": true,
          "time": '${p.hour}:00',
          "title": '${p.hour}:00',
          "value": '${p.hour}:00',
          "type": "time"
        };
        List list = selectDay['times'].toList();
        list.add(map);
        add(selectDay, list);
      },
    );
  }

  ///添加时间
  void add(item, times) {
    setState(() {
      List newDefalutTime = [];
      defaultTime.forEach((element) {
        if (element['day'] == item['day']) {
          Map newElement = {
            "day": element['day'],
            "title": element['title'],
            "times": times
          };
          newDefalutTime.add(newElement);
          return;
        }
        newDefalutTime.add(element);
      });
      defaultTime = newDefalutTime;
    });
  }

  ///移除数据
  void remove(item) {
    setState(() {
      List newDefalutTime = [];
      defaultTime.forEach((element) {
        if (element['day'] == item['day']['day']) {
          List times = element['times'].toList();
          times.remove(item['time']);
          Map newElement = {
            "day": element['day'],
            "title": element['title'],
            "times": times
          };
          newDefalutTime.add(newElement);
          return;
        }
        newDefalutTime.add(element);
      });
      defaultTime = newDefalutTime;
    });
  }

  ///收费时长
  Widget _timePrice() {
    return Container(
      padding: EdgeInsets.fromLTRB(30.sp, 30.sp, 30.sp, 30.sp),
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Row(children: [
          Expanded(
              child: Container(
            height: 50.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
              //设置四周边框
              border: new Border.all(width: 1.sp, color: Colors.grey[400]),
            ),
            child: TextField(
              controller: _minController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                // hintText: "50",
                border: InputBorder.none,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textAlign: TextAlign.center,
            ),
          )),
          SizedBox(
            width: 10.sp,
          ),
          Text("分钟"),
          SizedBox(width: 100.sp),
          Expanded(
            child: Container(
              height: 50.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
                //设置四周边框
                border: new Border.all(width: 1.sp, color: Colors.grey[400]),
              ),
              child: TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                controller: _priceController,
                decoration: InputDecoration(
                  // hintText: "50",
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 10.sp,
          ),
          Text("元/次"),
        ]),
        SizedBox(
          height: 30.sp,
        ),
        Text(
          "提示：时长固定50分钟，价格可在500-600元间选择。",
          style: TextStyle(color: Colors.grey),
        )
      ]),
    );
  }

  ///咨询类别
  Widget _consultingType() {
    return Container(
      padding: EdgeInsets.fromLTRB(30.sp, 20.sp, 30.sp, 20.sp),
      child: Row(
        children: [
          Text(
            "咨询类别",
            style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 20.sp,
          ),
          Checkbox(
            value: _voiceSelected,
            activeColor: Colors.blue, //选中时的颜色
            onChanged: (value) {
              setState(() {
                _voiceSelected = value;
              });
            },
          ),
          Text("语音咨询"),
          Checkbox(
            value: _videoSelected,
            activeColor: Colors.blue, //选中时的颜色
            onChanged: (value) {
              setState(() {
                _videoSelected = value;
              });
            },
          ),
          Text("视频咨询"),
        ],
      ),
    );
  }

  /// 暂停预约按钮
  Widget _stopAppointment() {
    return TextButton(
      onPressed: () {},
      child: Text(
        "暂停预约",
        style: TextStyle(color: Colors.white, fontSize: 28.sp),
      ),
      style: ButtonStyle(
        //背景颜色
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //默认不使用背景颜色
          return Color(0xFF3A8DFF);
        }), //设置按钮的大小
        minimumSize: MaterialStateProperty.all(Size(686.sp, 68.sp)),
        //外边框装饰 会覆盖 side 配置的样式
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
    );
  }

  ///咨询时间
  Widget _consultingTime() {
    return Container(
        child: CrossDateTime(
            title: '申请调整时间',
            dateList: times.length == 0 ? defaultTime : times,
            selected: [],
            onClickFun: print));
  }

  ///预约咨询
  Widget _appointmentConsulting() {
    return Container(
      padding: EdgeInsets.only(top: 40.sp, bottom: 40.sp),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            "视频咨询",
            style: TextStyle(fontSize: 28.sp, color: StyleUtils.fontColor_3),
          ),
          Text(
            "50分钟",
            style: TextStyle(fontSize: 28.sp, color: StyleUtils.fontColor_3),
          ),
          Text(
            "500元/次",
            style: TextStyle(fontSize: 28.sp, color: StyleUtils.fontColor_3),
          )
        ]),
        SizedBox(
          height: 30.sp,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            "视频咨询",
            style: TextStyle(fontSize: 28.sp, color: StyleUtils.fontColor_3),
          ),
          Text(
            "50分钟",
            style: TextStyle(fontSize: 28.sp, color: StyleUtils.fontColor_3),
          ),
          Text(
            "500元/次",
            style: TextStyle(fontSize: 28.sp, color: StyleUtils.fontColor_3),
          )
        ])
      ]),
    );
  }

  ///固定样式模版
  Widget _title(value, Widget content) {
    return Container(
        padding: EdgeInsets.fromLTRB(32.sp, 40.sp, 32.sp, 40.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w500,
                  color: StyleUtils.fontColor_3),
            ),
            SizedBox(
              height: 28.sp,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
                //设置四周边框
              ),
              child: content,
            )
          ],
        ));
  }
}
