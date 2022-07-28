import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_strong/provider/cart_provider.dart';
import 'package:flutter_strong/provider/checkout_provider.dart';
import 'package:flutter_strong/services/check_out_services.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/services/user_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  // 获取默认地址
  List _addressList = [];

  late CheckOutProvider _checkOutProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getDefaultAddress();

    eventBus.on<DefaultAddressEvent>().listen((event) {
      _getDefaultAddress();
    });
  }

  _getDefaultAddress() async {
    List userInfo = await UserServices.getUserInfo();
    var temJson = {
      "uid": userInfo[0]["_id"],
      "salt": userInfo[0]["salt"],
    };

    var response = {};
    setState(() {
      _addressList = response["result"];
    });
  }

  // 商品 item ui
  Widget _checkOutItem(item) {
    return Row(
      children: <Widget>[
        // 图片
        SizedBox(
          width: ScreenAdaper.width(160),
          child: Image.network(
            item["pic"],
            fit: BoxFit.cover,
          ),
        ),

        // 标题
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item["title"],
                  maxLines: 2,
                ),
                Text(
                  item["selectedAttr"],
                  maxLines: 2,
                ),
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "￥${item["price"]}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("x${item["count"]}"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);

    // 获取结算商品数据
    _checkOutProvider = Provider.of<CheckOutProvider>(context);
    var _cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("结算"),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              // 地址
              Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  _addressList.isEmpty
                      ? ListTile(
                          leading: const Icon(Icons.add_location),
                          title: const Center(
                            // 使文本居中
                            child: Text("请添加收获地址"),
                          ),
                          trailing: const Icon(Icons.navigate_next),
                          onTap: () {
                            Navigator.pushNamed(context, "/addressAdd");
                          },
                        )
                      : ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("${_addressList[0]["name"]} ${_addressList[0]["phone"]}"),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("${_addressList[0]["address"]}"),
                            ],
                          ),
                          trailing: const Icon(Icons.navigate_next),
                          onTap: () {
                            Navigator.pushNamed(context, "/addressList");
                          },
                        ),
                ],
              ),
              const Divider(
                height: 20,
              ),

              // 商品列表
              Container(
                padding: EdgeInsets.all(ScreenAdaper.width(20)),
                child: Column(
                  children: _checkOutProvider.checkOutListData.map((e) {
                    return Column(
                      children: <Widget>[
                        _checkOutItem(e),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                ),
              ),

              // 运费
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdaper.width(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text("商品金额：￥100"),
                    Divider(),
                    Text("立减：￥5"),
                    Divider(),
                    Text("运费：￥0"),
                  ],
                ),
              ),

              // 按钮条
              Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width,
                height: ScreenAdaper.height(100),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  height: ScreenAdaper.height(100),
                  // 线条
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(
                        width: 1,
                        color: Colors.black26,
                      ))),
                  child: Stack(
                    children: <Widget>[
                      // 总价
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () async {
                            // 有默认收获地址才可以下单
                            if (_addressList.isNotEmpty) {
                              bool isLogin = await UserServices.getUserState();
                              // 有登陆态，就假设下单会成功
                              if (isLogin) {
                                // 删除购物车选中的商品数据
                                await CheckOutServices.removeUnSelectedCartItem();

                                // 调用 CartProvider 更新购物车数据
                                _cartProvider.updateCartList();

                                // 跳转到支付页面
                                Navigator.pushNamed(context, "/pay");
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "请先填写收获地址", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
                            }
                          },
                          child: const Text(
                            "立即下单",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
