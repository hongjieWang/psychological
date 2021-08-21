import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/common/data_statistics.dart';
import 'package:standard_app/util/style.dart';
import 'package:standard_app/util/toasts.dart';

///用户评价
class ConsultEvaluatePage extends StatefulWidget {
  ConsultEvaluatePage({Key key}) : super(key: key);

  @override
  _ConsultEvaluatePageState createState() => _ConsultEvaluatePageState();
}

class _ConsultEvaluatePageState extends State<ConsultEvaluatePage> {
  int _crId = Get.arguments;
  final TextEditingController _evaluationContentController =
      new TextEditingController();
  double _ratingSource;
  int _labelNum;
  List _selectedLables = [];
  bool _isAnonymous;
  List lableDataList = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("发表评价", icon: Icons.arrow_back_ios),
      body: _body(),
    );
  }

  @override
  void initState() {
    super.initState();

    ///获取评价标签
    ApiService().getEvaluateLabels().then((res) => {
          setState(() {
            if (res['code'] == Api.success) {
              lableDataList = res['data'];
            }
          })
        });
  }

  ///评价内容
  Widget _body() {
    return Listener(
        onPointerMove: (onPointerMove) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(32.sp, 42.sp, 32.sp, 0),
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _head(),
                _lables(),
                Divider(),
                _evaluationContent(),
                _submit(),
                SizedBox(
                  height: 24.sp,
                ),
                _anonymous()
              ],
            ),
          ),
        ));
  }

  ///第一行评分及其数量标签显示
  Widget _head() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_score(), _labelNumShow()],
      ),
    );
  }

  Widget _labelNumShow() {
    return Text(
      '${this._labelNum == null ? 0 : this._labelNum}/3',
      style: TextStyle(fontSize: 24.sp, color: StyleUtils.fontColor_6),
    );
  }

  ///评分部分内容显示
  Widget _score() {
    return Row(
      children: [
        Text(
          '综合评分',
          style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w500,
              color: StyleUtils.fontColor_3),
        ),
        _rating(),
        _scoreShows()
      ],
    );
  }

  ///评分说明组件
  Widget _scoreShows() {
    return Padding(
      padding: EdgeInsets.only(left: 20.sp),
      child: Text(
        _scoreShowsText(),
        style: TextStyle(color: StyleUtils.fontColor_6, fontSize: 24.sp),
      ),
    );
  }

  ///评分组件
  Widget _rating() {
    return Padding(
      padding: EdgeInsets.only(left: 10.sp),
      child: RatingBar.builder(
        initialRating: _ratingSource == null ? 0 : _ratingSource,
        minRating: 1,
        allowHalfRating: false,
        unratedColor: Colors.amber.withAlpha(50),
        itemCount: 5,
        itemSize: 40.0.sp,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0.sp),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber[900],
        ),
        onRatingUpdate: (rating) {
          setState(() {
            this._ratingSource = rating;
          });
        },
        updateOnDrag: true,
      ),
    );
  }

  ///根据评分判断文字说明
  String _scoreShowsText() {
    String _scoreShows = "";
    if (this._ratingSource == null) {
      return _scoreShows;
    }
    double source = this._ratingSource;
    if (source == 1) {
      _scoreShows = "很差";
    } else if (2 >= source && 1 < source) {
      _scoreShows = "差";
    } else if (source > 2 && source <= 3) {
      _scoreShows = "一般";
    } else if (source > 3 && source <= 4) {
      _scoreShows = "好";
    } else {
      _scoreShows = "很好";
    }
    return _scoreShows;
  }

  ///评价标签显示
  Widget _lables() {
    return Container(
      padding: EdgeInsets.only(top: 20.sp),
      child: Wrap(
        spacing: 20.0.sp, // 主轴(水平)方向间距
        runSpacing: -30.sp, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.center,
        children: lable(),
      ),
    );
  }

  ///构建list集合
  List<Widget> lable() {
    List<Widget> lableList = [];
    if (lableDataList.isNotEmpty) {
      Iterable list;
      if (lableDataList.length >= 12) {
        list = lableDataList.getRange(0, 12);
      } else {
        list = lableDataList.getRange(0, lableDataList.length);
      }
      list.forEach((element) {
        lableList.add(TextButton(
          onPressed: () {
            _onClickLable(element);
          },
          child: new Text(
            element['evaluateLabelName'],
            style: TextStyle(
                color: this._selectedLables.contains(element)
                    ? Colors.white
                    : StyleUtils.fontColor_6,
                fontSize: 20.sp),
          ),
          style: ButtonStyle(
            //背景颜色
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              //设置按下时的背景颜色
              if (states.contains(MaterialState.pressed)) {
                return Colors.blue[200];
              }
              //默认不使用背景颜色
              return this._selectedLables == null
                  ? Color(0xFFE3E3E3)
                  : this._selectedLables.contains(element)
                      ? Color(0xFF5191E8)
                      : Color(0xFFE3E3E3);
            }),
            padding: MaterialStateProperty.all(EdgeInsets.all(6.sp)),
            minimumSize: MaterialStateProperty.all(Size(150.sp, 20.sp)),
            shape: MaterialStateProperty.all(StadiumBorder()),
          ),
        ));
      });
    }
    return lableList;
  }

  ///评价内容
  Widget _evaluationContent() {
    return Container(
      child: Card(
          color: Colors.grey[80],
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _evaluationContentController,
              maxLines: 13,
              maxLength: 255,
              decoration: InputDecoration.collapsed(
                  hintText: "可根据实际咨询情况进行评价~",
                  hintStyle: TextStyle(
                      color: StyleUtils.fontColor_9, fontSize: 22.sp)),
            ),
          )),
    );
  }

  ///提交评价按钮
  Widget _submit() {
    return Padding(
      padding: EdgeInsets.only(top: 30.sp),
      child: TextButton(
        onPressed: () {
          _onClickSubmit();
        },
        child: Text(
          '提 交 评 价',
          style: TextStyle(color: Colors.white, fontSize: 30.sp),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            //设置按下时的背景颜色
            if (states.contains(MaterialState.pressed)) {
              return Colors.blue[200];
            }
            //默认不使用背景颜色
            return Color(0xFF3A8DFF);
          }),
          padding: MaterialStateProperty.all(EdgeInsets.all(14.sp)),
          minimumSize: MaterialStateProperty.all(Size(686.sp, 68.sp)),
          shape: MaterialStateProperty.all(StadiumBorder()),
        ),
      ),
    );
  }

  ///匿名评价
  Widget _anonymous() {
    return Container(
      child: Row(
        children: [
          InkWell(
            child: Icon(
              Icons.verified,
              size: 30.sp,
              color: this._isAnonymous == null
                  ? Colors.black54
                  : _isAnonymous
                      ? Colors.green[700]
                      : Colors.black54,
            ),
            onTap: () {
              DataStatistics.instance.event("anonymous_evaluate", {"key": ""});
              setState(() {
                this._isAnonymous =
                    this._isAnonymous == null ? false : !this._isAnonymous;
              });
            },
          ),
          Text(
            '匿名评价',
            style: TextStyle(fontSize: 20.sp, color: StyleUtils.fontColor_9),
          )
        ],
      ),
    );
  }

  ///点击评价标签处理事件
  _onClickLable(element) {
    DataStatistics.instance.event(
        "onclick_evaluate_lable", {"lable": element['evaluateLabelName']});
    setState(() {
      if (this._selectedLables == null || this._selectedLables.length == 0) {
        this._selectedLables = [];
        this._selectedLables.add(element);
      } else {
        if (this._selectedLables.length >= 3) {
          if (this._selectedLables.contains(element)) {
            this._selectedLables.remove(element);
          }
        } else {
          if (this._selectedLables.contains(element)) {
            this._selectedLables.remove(element);
          } else {
            this._selectedLables.add(element);
          }
        }
      }
      this._labelNum = this._selectedLables.length;
    });
  }

  ///点击提交按钮
  _onClickSubmit() async {
    DataStatistics.instance.event("submit_evaluate", {"key": ""});
    String labelIds = "";
    _selectedLables.forEach((element) {
      labelIds = labelIds + "${element['evaluateLabelId']}" + ",";
    });
    Map data = {
      "evaluateLabelIds": labelIds,
      "membersId": Global.getUserId(),
      "crId": _crId,
      "evaluateScore": _ratingSource,
      "evaluateContent": _evaluationContentController.text,
      "anonymous": _isAnonymous
    };
    ApiService()
        .pushEvaluate(data)
        .then((res) => {Toasts.show("评价成功"), Get.back()});
  }
}
