import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/common/buttom_lables.dart';
import 'package:standard_app/util/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///咨询师个人信息页面
class CounselorInfoPage extends StatefulWidget {
  @override
  _CounselorInfoPageState createState() => _CounselorInfoPageState();
}

class _CounselorInfoPageState extends State<CounselorInfoPage> {
  bool edit = false;

  ///基本理念监听
  TextEditingController _basicIdeaController;

  /// 咨询技术监听
  TextEditingController _technologyController;

  /// 工作领域监听
  TextEditingController _fieldController;

  ///擅长疗法
  TextEditingController _goodWayController;

  ///擅长领域选择标签
  List _goodAtFielSelected = [];

  ///擅长人群
  List _crowdSelected = [];

  List _goodAtFiel = [];
  List _goodCrowd = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("个人信息",
            style: TextStyle(fontSize: 32.sp, color: Colors.black)),
        centerTitle: true,
        actions: <Widget>[
          //导航栏右侧菜单
          TextButton(
            onPressed: () {
              if (!edit) {
                ApiService().getLabelsService().then((value) => {
                      _goodAtFiel = value['data']['goodWays'],
                      _goodCrowd = value['data']['goodCrowd']
                    });
              }
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

  void _submit() {
    CounselorInfo info = CounselorInfo();
    info.idea = _basicIdeaController.text;
    info.technical = _technologyController.text;
    info.workArea = _fieldController.text;
    info.counselorId = Global.getCounselorId();
    info.crowd = _crowdSelected;
    info.goodWay = _goodWayController.text;
    info.goodField = _goodAtFielSelected;
    ApiService().postCounselorMineInfo(info.covMap()).then((value) => {});
  }

  @override
  void initState() {
    Map map = Get.arguments;
    _basicIdeaController = TextEditingController();
    _technologyController = TextEditingController();
    _fieldController = TextEditingController();
    _goodWayController = TextEditingController();
    _basicIdeaController.text = map['idea'] == null ? "" : map['idea'];
    _technologyController.text =
        map['technical'] == null ? "" : map['technical'];
    _fieldController.text = map['workArea'] == null ? "" : map['workArea'];
    _goodWayController.text = map['goodWay'] == null ? "" : map['goodWay'];
    _goodAtFielSelected =
        map['goodFieldEntities'] == null ? [] : map['goodFieldEntities'];
    _crowdSelected = map['crowdEntities'] == null ? [] : map['crowdEntities'];
    super.initState();
  }

  @override
  void dispose() {
    _basicIdeaController.dispose();
    _technologyController.dispose();
    _fieldController.dispose();
    super.dispose();
  }

  ///主体内容
  Widget _body() {
    return Container(
      color: StyleUtils.bgColor,
      height: double.infinity,
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _smallTitle("【基本理念】"),
          Offstage(
            offstage: edit,
            child: _textContext(_basicIdeaController.text),
          ),
          Offstage(
            offstage: !edit,
            child: _basicIdeaWidget(),
          ),
          _smallTitle("【咨询技术】"),
          Offstage(
            offstage: edit,
            child: _textContext(_technologyController.text),
          ),
          Offstage(
            offstage: !edit,
            child: _technologyWidget(),
          ),
          _smallTitle("【工作领域】"),
          Offstage(
            offstage: edit,
            child: _textContext(_fieldController.text),
          ),
          Offstage(
            offstage: !edit,
            child: _fieldWidget(),
          ),
          SizedBox(
            height: 40.sp,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.sp),
            child: Text("专业资质",
                style: TextStyle(fontSize: 32.sp, color: Color(0xFF454545))),
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            _smallTitle("擅长领域"),
            Offstage(
              offstage: !edit,
              child: IconButton(
                icon: Icon(
                  Icons.chevron_right,
                  size: 40.sp,
                  color: Colors.blue,
                ),
                onPressed: () {
                  _clickSpec(_goodAtField());
                },
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.only(left: 30.sp),
            child: Wrap(
              spacing: 8.0, // 主轴(水平)方向间距
              runSpacing: 4.0, // 纵轴（垂直）方向间距
              children: _goodAtFieldLables(),
            ),
          ), //擅长领域
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            _smallTitle("咨询人群"),
            Offstage(
              offstage: !edit,
              child: IconButton(
                icon: Icon(
                  Icons.chevron_right,
                  size: 40.sp,
                  color: Colors.blue,
                ),
                onPressed: () {
                  _clickSpec(_crowd());
                },
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.only(left: 30.sp),
            child: Wrap(
              spacing: 8.0, // 主轴(水平)方向间距
              runSpacing: 4.0, // 纵轴（垂直）方向间距
              children: _crowdFunLables(),
            ),
          ), //擅长人群
          _smallTitle("擅长疗法"),
          Offstage(
            offstage: edit,
            child: _textContext(_goodWayController.text),
          ),
          Offstage(offstage: !edit, child: _goodWayWidget()),
          SizedBox(height: 40.h)
        ],
      )),
    );
  }

  /// 擅长领域
  List<Widget> _goodAtFieldLables() {
    List<Widget> lables = [];
    _goodAtFielSelected.forEach((element) {
      lables.add(Text(
        "# ${element['counselorLabelName']}",
        style: TextStyle(color: StyleUtils.fontColor_6, fontSize: 20.sp),
      ));
    });
    return lables;
  }

  /// 擅长领域回调
  void _goodAtFieldSelectedFun(selected) {
    setState(() {
      _goodAtFielSelected = selected;
    });
  }

  ///底部呼出年龄选择
  void _clickSpec(Widget widget) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return widget;
      },
    );
  }

  ///基本理念编辑
  Widget _basicIdeaWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(30.sp, 20.sp, 30.sp, 10.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
        //设置四周边框
        border: new Border.all(width: 1.sp, color: Colors.grey[400]),
      ),
      child: TextField(
        controller: _basicIdeaController,
        keyboardType: TextInputType.multiline,
        maxLines: 10,
        maxLength: 1000,
        decoration: InputDecoration(
          labelText: "基本理念",
          border: InputBorder.none,
        ),
      ),
    );
  }

  ///咨询技术
  Widget _technologyWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(30.sp, 20.sp, 30.sp, 10.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
        //设置四周边框
        border: new Border.all(width: 1.sp, color: Colors.grey[400]),
      ),
      child: TextField(
        controller: _technologyController,
        keyboardType: TextInputType.multiline,
        maxLines: 10,
        maxLength: 1000,
        decoration: InputDecoration(
          labelText: "咨询技术",
          border: InputBorder.none,
        ),
      ),
    );
  }

  ///擅长疗法
  Widget _goodWayWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(30.sp, 20.sp, 30.sp, 10.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
        //设置四周边框
        border: new Border.all(width: 1.sp, color: Colors.grey[400]),
      ),
      child: TextField(
        controller: _goodWayController,
        keyboardType: TextInputType.multiline,
        maxLength: 100,
        decoration: InputDecoration(
          labelText: "擅长疗法",
          border: InputBorder.none,
        ),
      ),
    );
  }

  ///工作领域
  Widget _fieldWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(30.sp, 20.sp, 30.sp, 10.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
        //设置四周边框
        border: new Border.all(width: 1.sp, color: Colors.grey[400]),
      ),
      child: TextField(
        controller: _fieldController,
        keyboardType: TextInputType.multiline,
        maxLines: 10,
        maxLength: 1000,
        decoration: InputDecoration(
          labelText: "工作领域",
          border: InputBorder.none,
        ),
      ),
    );
  }

  ///擅长领域
  Widget _goodAtField() {
    return Container(
      height: 0.5.sh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.0.sp)),
        border: new Border.all(width: 1.sp, color: Colors.grey[400]),
      ),
      child: ButtomLablesPage(
        title: "擅长领域",
        datas: _goodAtFiel,
        selected: _goodAtFielSelected,
        submit: _goodAtFieldSelectedFun,
      ),
    );
  }

  ///擅长人群回调
  void _crowdFun(selecetd) {
    setState(() {
      _crowdSelected = selecetd;
    });
  }

  /// 擅长领域
  List<Widget> _crowdFunLables() {
    List<Widget> lables = [];
    _crowdSelected.forEach((element) {
      lables.add(Text(
        "# ${element['counselorLabelName']}",
        style: TextStyle(color: StyleUtils.fontColor_6, fontSize: 20.sp),
      ));
    });
    return lables;
  }

  ///咨询人群
  Widget _crowd() {
    return Container(
      height: 0.5.sh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.0.sp)),
        border: new Border.all(width: 1.sp, color: Colors.grey[400]),
      ),
      child: ButtomLablesPage(
        title: "擅长领域",
        datas: _goodCrowd,
        selected: _crowdSelected,
        submit: _crowdFun,
      ),
    );
  }

  ///文本内容展示
  Widget _textContext(text) {
    return Container(
      margin: EdgeInsets.fromLTRB(52.sp, 20.sp, 52.sp, 10.sp),
      child: Text(
        text,
        style: TextStyle(color: StyleUtils.fontColor_6, fontSize: 20.sp),
      ),
    );
  }

  /// 小标题
  Widget _smallTitle(value) {
    return Padding(
      padding: EdgeInsets.fromLTRB(32.sp, 40.sp, 32.sp, 10.sp),
      child: Text(value,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF80ADEA),
              fontSize: 26.sp)),
    );
  }
}

class CounselorInfo {
  ///基本理念
  String idea;

  ///咨询技术
  String technical;

  ///工作领域
  String workArea;

  ///擅长方式
  String goodWay;

  ///咨询人群
  List crowd;

  ///擅长领域
  List goodField;

  ///咨询师ID
  String counselorId;

  Map covMap() {
    return {
      "idea": this.idea,
      "technical": this.technical,
      "workArea": this.workArea,
      "goodWay": this.goodWay,
      "crowd": this.crowd,
      "goodField": this.goodField,
      "counselorId": this.counselorId
    };
  }
}
