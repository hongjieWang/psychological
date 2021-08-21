import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:standard_app/util/Toasts.dart';

///底部呼出选择标签小部件
class ButtomLablesPage extends StatefulWidget {
  final String title;
  final List datas;
  final List selected;
  final Function submit;
  ButtomLablesPage(
      {Key key, this.title, this.datas, this.selected, this.submit})
      : super(key: key);

  @override
  _ButtomLablesPageState createState() => _ButtomLablesPageState();
}

class _ButtomLablesPageState extends State<ButtomLablesPage> {
  String title = "";

  ///最多选择数量
  int maxSelected = 3;

  ///已经选择数量
  int selectNum = 0;
  List selected = [];
  List datas = [];
  Function submit;
  @override
  void initState() {
    title = widget.title == null ? "" : widget.title;
    datas = widget.datas;
    submit = widget.submit;
    selected = widget.selected == null ? [] : widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30.0.sp)),
      ),
      margin: EdgeInsets.fromLTRB(30.sp, 20.sp, 30.sp, 20.sp),
      child: Column(children: [_title(), _content()]),
    );
  }

  /// 选择领域
  onSelectedChanged(Map _index) {
    bool isSelected = false;
    Map temp;
    for (Map e in selected) {
      if (e['counselorLabelNo'] == _index['counselorLabelNo']) {
        isSelected = true;
        temp = e;
        break;
      }
    }
    setState(() {
      if (isSelected) {
        selected.remove(temp);
      } else {
        if (selected.length == maxSelected) {
          Toasts.show("最多只能选择$maxSelected个标签");
          return;
        }
        selected.add(_index);
      }
    });
  }

  ///标签内容
  Widget _content() {
    return SingleChildScrollView(
        child: Wrap(
            spacing: 4.0, // 主轴(水平)方向间距
            runSpacing: 2.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: _inputSelects.toList()));
  }

  // 迭代器生成list
  Iterable<Widget> get _inputSelects sync* {
    for (int i = 0; i < datas.length; i++) {
      yield InputSelect(
        index: datas[i],
        choice: datas[i]['counselorLabelName'],
        parent: this,
        widget: null,
      );
    }
  }

  ///标题样式
  Widget _title() {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("${selected.length}/$maxSelected"),
        Text(title),
        TextButton(
          onPressed: () {
            submit(selected);
            Get.back();
          },
          child: Text("完成"),
        )
      ]),
    );
  }
}

// 实现 ChoiceInput
// index 为标识ChoiceInput
// parent 为父控件
class InputSelect extends StatelessWidget {
  const InputSelect(
      {@required this.index,
      @required this.widget,
      @required this.parent,
      @required this.choice})
      : super();

  @override
  Widget build(BuildContext context) {
    List selected = parent.selected.toList();
    bool isSelected = false;
    for (Map e in selected) {
      if (e['counselorLabelNo'] == index['counselorLabelNo']) {
        isSelected = true;
        break;
      }
    }
    return Padding(
        padding: const EdgeInsets.all(1),
        child: FilterChip(
          label: Text(choice),
          //选定的时候背景
          selectedColor: Colors.blueAccent,
          //被禁用得时候背景
          labelPadding: EdgeInsets.only(left: 2.0, right: 2.0),
          materialTapTargetSize: MaterialTapTargetSize.padded,
          onSelected: (bool value) {
            parent.onSelectedChanged(index);
          },
          selected: isSelected,
        ));
  }

  final Map index;
  final widget;
  final parent;
  final String choice;
}
