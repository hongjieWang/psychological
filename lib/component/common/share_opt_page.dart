import 'package:flutter/material.dart';
import 'package:standard_app/util/style.dart';

/// 点击事件
typedef OnItemClickListener = void Function(int index);
typedef DoAction = void Function(ShareType shareType, ShareInfo shareInfo);
enum ShareType { SESSION, TIMELINE, COPY_LINK, DOWNLOAD }

/// 定义分享内容
class ShareInfo {
  /// 标题
  String title;

  /// 连接
  String url;

  /// 图片
  var img;

  /// 描述
  String describe;

  ShareInfo(this.title, this.url, {this.img, this.describe = ""});

  static ShareInfo fromJson(Map map) {
    return ShareInfo(map['title'], map['url'],
        img: map['img'], describe: map['describe']);
  }
}

/// 分享操作
class ShareOpt {
  final String title;
  final String img;
  final DoAction doAction;
  final ShareType shareType;

  const ShareOpt(
      {this.title = "",
      this.img = "",
      this.shareType = ShareType.SESSION,
      @required this.doAction});
}

/// 弹出窗
class ShareWidget extends StatefulWidget {
  final List<ShareOpt> list;
  final ShareInfo shareInfo;

  const ShareWidget(this.shareInfo, {Key key, @required this.list})
      : super(key: key);

  @override
  _ShareWidgetState createState() => _ShareWidgetState();
}

class _ShareWidgetState extends State<ShareWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            //边框设置
            decoration: BoxDecoration(
              //背景
              color: Colors.white,
              //设置四周边框
              border: Border.all(
                width: 1,
                color: Colors.white,
              ),
              //设置四周圆角角度
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            //设置 child 居中
            alignment: Alignment.center,
            height: 100.0,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: new Container(
                height: 100.0,
                child: new GridView.builder(
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: 1.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque, // 空白地方也可以点击
                      onTap: () {
                        Navigator.pop(context);
                        widget.list[index].doAction(
                            widget.list[index].shareType, widget.shareInfo);
                      },
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                            child: new Image.asset(
                              widget.list[index].img,
                              width: 40.0,
                              height: 40.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(widget.list[index].title,style: TextStyle(fontSize: 12,color: StyleUtils.fontColor_6),)
                        ],
                      ),
                    );
                  },
                  itemCount: widget.list.length,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
            ),
            //边框设置
            decoration: BoxDecoration(
              //背景
              color: Colors.white,
              //设置四周边框
              border: Border.all(
                width: 1,
                color: Colors.white,
              ),
              //设置四周圆角角度
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            //设置 child 居中
            alignment: Alignment.center,
            height: 50.0,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              behavior: HitTestBehavior.opaque,
              // 在空白的范围内就都可以点击,否则只有点击children里的text 或者image才有效果
              child: Center(
                child: new Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                  child: const Text(
                    '取消',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
