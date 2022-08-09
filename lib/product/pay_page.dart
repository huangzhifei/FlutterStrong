import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_strong/uikit/fs_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PayPage extends StatefulWidget {
  final Map? arguments;
  const PayPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  List payList = [
    {"title": "支付宝支付", "checked": true, "image": "https://www.itying.com/themes/itying/images/alipay.png"},
    {"title": "微信支付", "checked": false, "image": "https://www.itying.com/themes/itying/images/weixinpay.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("去支付"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - (64 + 64),
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
                itemCount: payList.length + 1,
                itemBuilder: (context, index) {
                  if (index < payList.length) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: Image.network(payList[index]["image"]),
                          title: Text(payList[index]["title"]),
                          trailing: payList[index]["checked"] ? const Icon(Icons.check) : const Text(""),
                          onTap: () {
                            setState(() {
                              // 让 payList 里面的 checked 都等于 false;
                              for (var item in payList) {
                                item["checked"] = false;
                              }
                              // 当前选中的 true
                              payList[index]["checked"] = true;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: FSButton(
                        buttonTitle: "支付",
                        buttonColor: Colors.red,
                        height: 44,
                        tapEvent: () {
                          print("支付中");
                          if (widget.arguments != null) {
                            Function payCallback = widget.arguments!["callback"];
                            payCallback(true);
                          }
                          Fluttertoast.showToast(msg: "支付成功", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
