import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:standard_app/base/api.dart';
import 'package:standard_app/base/api_service.dart';
import 'package:standard_app/base/global.dart';
import 'package:standard_app/component/common/alert_dialog.dart';
import 'package:standard_app/component/common/show_sheet_dialog.dart';
import 'package:standard_app/util/Toasts.dart';
import 'package:standard_app/util/dialog.dart';
import 'package:standard_app/util/image_util.dart';
import 'package:standard_app/util/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///提现页面
class WithdrawPage extends StatefulWidget {
  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  TextEditingController controller = TextEditingController();
  String payImage =
      "https://julywhj-1258527903.cos.ap-beijing.myqcloud.com/706/bank_logo/weChar.png";
  String payName = "微信到账";
  int payType;
  //是否可以提现
  bool isWithdrawal = true;
  //按钮是否可点击
  bool isOnClickBtn = false;
  Map wallet = Get.arguments;
  List ways = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleUtils.buildAppBar("提现"),
      body: _body(),
    );
  }

  @override
  void initState() {
    super.initState();
    ApiService()
        .getPayWithdrawalWayByWalletNo(wallet['walletNo'])
        .then((value) => {
              if (value['code'] == Api.success)
                {
                  setState(() {
                    ways = value['data'].toList();
                    ways.forEach((element) {
                      if (element['defaultWithdrawal'] == 1) {
                        payName = element['bankName'];
                        payImage = element['logoImage'];
                        payType = element['payWithdrawalWayId'];
                      }
                    });
                  })
                }
            });
    controller.addListener(() {
      _checkNum();
    });
  }

  ///提现
  Widget _body() {
    return Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(color: StyleUtils.appBarColor),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [_account(), _withdrawalAmount(), _withdrawalRecord()]),
        ));
  }

  ///到账账户
  Widget _account() {
    return Container(
      margin: EdgeInsets.fromLTRB(30.sp, 40.sp, 30.sp, 20.sp),
      width: 750.w,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("到账渠道"),
            SizedBox(
              width: 40.w,
            ),
            Expanded(
              child: InkWell(
                  onTap: () => {print("object"), show()},
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Image.network(
                                  payImage,
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(payName),
                              ]),
                              Icon(Icons.chevron_right)
                            ]),
                        SizedBox(height: 10.h),
                        Text(
                          "2小时到账",
                          style: TextStyle(color: Colors.grey),
                        )
                      ])),
            )
          ]),
    );
  }

  ///提现金额
  Widget _withdrawalAmount() {
    return Container(
      width: 750.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.sp)),
          border: new Border.all(color: Colors.grey[300], width: 1.sp)),
      margin: EdgeInsets.fromLTRB(30.sp, 40.sp, 30.sp, 20.sp),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30.sp, 20.sp, 0.sp, 20.sp),
              child: Text(
                "提现金额",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(30.sp, 20.sp, 0.sp, 20.sp),
                child: Row(children: [
                  Image.asset(ImageUtils.getImgPath("money")),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: 40.sp),
                    ),
                  ),
                ])),
            Divider(height: 0),
            Padding(
              padding: EdgeInsets.fromLTRB(26.sp, 20.sp, 0.sp, 20.sp),
              child: Row(children: [
                SizedBox(
                  width: 10.w,
                ),
                Offstage(
                    offstage: !isWithdrawal,
                    child: Text(
                      "可提现金额 ${wallet['noWithdraw']}元,",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )),
                Offstage(
                    offstage: isWithdrawal,
                    child: Text(
                      "输入金额超过提现余额",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    )),
                SizedBox(
                  width: 10.w,
                ),
                Offstage(
                    offstage: !isWithdrawal,
                    child: InkWell(
                        onTap: () => {_allWithdrawal()},
                        child: Text(
                          "全部提现",
                          style: TextStyle(color: Colors.blue),
                        ))),
              ]),
            ),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        TextButton(
          onPressed: isWithdrawal && isOnClickBtn ? _onclickWithdrawal : null,
          child: Text(
            "提现",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            //背景颜色
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              //设置按下时的背景颜色
              if (states.contains(MaterialState.pressed)) {
                return Colors.blue[200];
              }
              //默认不使用背景颜色
              return isWithdrawal && isOnClickBtn ? Colors.green : Colors.grey;
            }),
            //设置按钮内边距
            padding: MaterialStateProperty.all(EdgeInsets.all(20.r)),
            //设置按钮的大小
            minimumSize: MaterialStateProperty.all(Size(600.w, 70.h)),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ]),
    );
  }

  /// 提现记录
  Widget _withdrawalRecord() {
    return Container(
      child: TextButton(
        onPressed: () {},
        child: Text(
          "提现记录",
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

//点击提现按钮
  _onclickWithdrawal() {
    print("提现");
    Map data = {
      "walletNo": wallet['walletNo'],
      "membersId": Global.getUserId(),
      "withdrawalWay": payType,
      "withdrawalNumber": controller.text
    };
    ApiService().payWithdrawalApply(data).then((value) => {
          if (value['code'] == Api.success)
            {Toasts.show("提现申请成功，请您耐心等待，我们的工作人员会及时处理。"), Get.back()}
          else
            {
              popDialog(
                  Get.context,
                  ShowAlertDialog(
                    items: ['取消', '确认'],
                    title: '提示',
                    content: value['msg'],
                    onTap: (index) {},
                  ))
            }
        });
  }

  //点击全部提现
  _allWithdrawal() {
    controller.text = "${wallet['noWithdraw']}";
  }

  _checkNum() {
    if (controller.text.isNotEmpty) {
      setState(() {
        isWithdrawal = wallet['noWithdraw'] >= double.parse(controller.text);
        isOnClickBtn = double.parse(controller.text) > 0;
      });
    } else {
      setState(() {
        isWithdrawal = true;
        isOnClickBtn = false;
      });
    }
  }

  void show() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return ShowSheetDialog(
          items: ['微信', '支付宝'],
          itemsWidget: _getItems(),
          title: '请选择到账方式',
          onTap: (key) {
            setState(() {
              print(key);
            });
          },
        );
      },
    );
  }

  ///获取到账渠道样式
  List<Map> _getItems() {
    List<Map> lables = [];
    ways.forEach((element) {
      lables.add({
        "key": element['payWithdrawalWayId'],
        "widget": _itemCreat(element['bankName'], element['logoImage'])
      });
    });
    return lables;
  }

  //自定义弹框显示样式
  Widget _itemCreat(title, logo) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.network(
            logo,
            width: 20,
            height: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.black),
            textAlign: TextAlign.center,
          )
        ]),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE7E8ED), width: 1)),
      ),
    );
  }
}
