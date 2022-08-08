import 'package:flutter/material.dart';
import 'package:flutter_strong/config/config.dart';
import 'package:flutter_strong/models/address_model.dart';
import 'dart:convert';
import 'package:flutter_strong/provider/cart_provider.dart';
import 'package:flutter_strong/provider/checkout_provider.dart';
import 'package:flutter_strong/services/check_out_services.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/fsstorage.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/services/user_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_strong/models/product_content_main_model.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  // 获取默认地址
  late AddressModel _defaultAddress = AddressModel(sId: "");
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
    bool isLogin = await UserServices.getUserState();
    if (isLogin) {
      // 获取收货地址列表
      var tempD = await FSStorage.getString(kUsualAddressListKey);
      if (tempD.isNotEmpty) {
        List tempAddressList = json.decode(tempD);
        if (tempAddressList.isNotEmpty) {
          AddressModel addressData = AddressModel(sId: "");
          for (var item in tempAddressList) {
            AddressModel m = AddressModel.fromJson(item);
            if (m.isDefaultAddress && m.sId.isNotEmpty) {
              addressData = m;
              break;
            }
          }
          setState(() {
            // todo
            _defaultAddress = addressData;
          });
        } else {
          setState(() {
            // todo
            _defaultAddress = AddressModel(sId: "");
          });
        }
      }
    } else {
      Fluttertoast.showToast(msg: "请先登陆", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
      Navigator.pushNamed(context, "/login");
    }
  }

  // 商品 item ui
  Widget _checkOutItem(value) {
    ProductContentMainItem item = ProductContentMainItem.fromJson(value);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 图片
        SizedBox(
          width: ScreenAdaper.width(120),
          child: Image.network(
            item.pic,
            fit: BoxFit.cover,
          ),
        ),

        // 标题
        Expanded(
          flex: 1,
          child: Container(
            // color: Colors.purple,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(item.title, maxLines: 2, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30,),
                Text(
                  item.selectedAttr.isNotEmpty ? item.selectedAttr : "测试数据",
                  maxLines: 2,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 60,
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "￥${item.price}",
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "x${item.count}",
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                      ),
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
                  _defaultAddress.sId.isEmpty
                      ? ListTile(
                          leading: const Icon(Icons.add_location),
                          title: const Center(
                            // 使文本居中
                            child: Text("请添加收获地址", style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          trailing: const Icon(Icons.navigate_next),
                          onTap: () {
                            Navigator.pushNamed(context, "/addressAdd", arguments: {"isDefaultAddress" : true});
                          },
                        )
                      : ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("${_defaultAddress.name} ${_defaultAddress.phone}"),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(_defaultAddress.address),
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
                height: 1,
              ),

              // 商品列表
              Container(
                padding: EdgeInsets.all(ScreenAdaper.width(8)),
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
                // color: Colors.blue,
                padding: EdgeInsets.only(
                    left: ScreenAdaper.width(8),
                    right: ScreenAdaper.width(8),
                    bottom: ScreenAdaper.width(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text("商品金额：￥100", style: TextStyle(fontSize: 16),),
                    Divider(),
                    Text("立减：￥5", style: TextStyle(fontSize: 16),),
                    Divider(),
                    Text("运费：￥0", style: TextStyle(fontSize: 16),),
                  ],
                ),
              ),

              // 按钮条
              Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width,
                height: ScreenAdaper.height(60),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  height: ScreenAdaper.height(60),
                  // 线条
                  decoration: const BoxDecoration(
                      // color: Colors.white,
                      border: Border(
                          top: BorderSide(
                        width: 1,
                        color: Colors.black26,
                      ))),
                  child: Stack(
                    children: <Widget>[
                      // 总价
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () async {
                            // 有默认收获地址才可以下单
                            if (_defaultAddress.sId.isNotEmpty) {
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
