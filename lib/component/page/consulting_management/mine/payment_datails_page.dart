import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_app/util/style.dart';

///交易详情
class PaymentDatailsPage extends StatefulWidget {
  @override
  _PaymentDatailsPageState createState() => _PaymentDatailsPageState();
}

class _PaymentDatailsPageState extends State<PaymentDatailsPage> {
  Map wallet = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(wallet);
    bool type = wallet['paymentsType'] == "1";
    return Scaffold(
      appBar: StyleUtils.buildAppBar("交易详情"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(),
        child: Flex(
          direction: Axis.vertical,
          children: [
            renderCard([
              renderItem(
                type ? "收入" : "提现",
                child: Text(
                  "${wallet['paymentsNumber']} 元",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              renderItem(
                "类型",
                child: Text(
                  type ? "咨询收入" : "提现支出",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              renderItem(
                "商品",
                child: Text(
                  wallet['remark'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              renderItem("时间",
                  child: Text(
                    wallet['createTime'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  )),
              renderItem("订单编号",
                  child: Text(
                    wallet['orderNo'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  )),
              renderItem("流水号",
                  child: Text(
                    wallet['payNo'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  )),
              renderItem("支付渠道", child: Text("data")),
              renderItem("余额",
                  child: Text(
                    "${wallet['accountBalance']}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  )),
            ])
          ],
        ),
      ),
    );
  }

  Widget renderCard(List widgets) {
    List<Widget> list = [];

    for (int i = 0; i < widgets.length; i++) {
      list
        ..add(widgets[i])
        ..add(Divider(
          height: 1,
        ));
    }

    return Container(
        color: Colors.white,
        child: Column(
          children: list.toList(),
        ));
  }

  Widget renderItem(String title, {Widget child}) {
    List<Widget> list = [
      Text(
        title,
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
      child != null ? child : Container()
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: list.toList(),
      ),
    );
  }
}
