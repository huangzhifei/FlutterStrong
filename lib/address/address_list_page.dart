import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_strong/config/config.dart';
import 'package:flutter_strong/models/address_model.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/fsstorage.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/services/user_services.dart';
import 'dart:convert';

class AddressListPage extends StatefulWidget {
  const AddressListPage({Key? key}) : super(key: key);

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  // 请求列表数据
  late List<AddressModel> _addressList = <AddressModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getAddressList();
    eventBus.on<AddressEvent>().listen((event) {
      print(event);
      _getAddressList();
    });
  }

  _getAddressList() async {
    var tempD = await FSStorage.getString(kUsualAddressListKey);
    List<AddressModel> address = <AddressModel>[];
    if (tempD.isNotEmpty) {
      List tempData = json.decode(tempD);
      for (var item in tempData) {
        address.add(AddressModel.fromJson(item));
      }
    }
    setState(() {
      _addressList = address;
    });
  }

  // 修改默认收货地址
  _changeDefaultAddress(value) async {
    // 改成存本地
    bool isLogin = await UserServices.getUserState();
    if (isLogin) {
      // 持久化本地
      for (var item in _addressList) {
        if (item.isDefaultAddress && item.sId != value) {
          item.isDefaultAddress = false;
          continue;
        }
        if (item.sId == value) {
          item.isDefaultAddress = true;
        }
      }
      await FSStorage.setString(kUsualAddressListKey, json.encode(_addressList));
      // 退出
      Navigator.pop(context);
    } else {
      // 弹出登陆界面
      Fluttertoast.showToast(msg: "请先登录", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
    }
  }

  // 删除框
  _delAddress(var sId) async {
    // 本地
    bool isLogin = await UserServices.getUserState();
    if (isLogin) {
      // 删掉本地的某条记录
      List<AddressModel> tempData = <AddressModel>[];
      bool isDelDefaultAddress = false;
      for (var item in _addressList) {
        if (item.sId == sId) {
          // 如果删除的是默认地址，需要把默认地址给其他地址
          if (item.isDefaultAddress == true) {
            isDelDefaultAddress = true;
          }
        } else {
          tempData.add(item);
        }
      }
      if (isDelDefaultAddress) {
        for (var item in tempData) {
          item.isDefaultAddress = true;
          break;
        }
      }
      await FSStorage.setString(kUsualAddressListKey, json.encode(tempData));
      // 重新刷新列表
      _getAddressList();
    } else {
      // 弹出登陆界面
      Navigator.pushNamed(context, "/login");
    }
  }

  _showDelAlertDialog(sId) async {
    await showDialog(
        // 表示点击灰色背景的时候是否消失弹框
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("提示信息"),
            content: const Text("您确定要删除吗?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("取消"),
              ),
              TextButton(
                child: const Text("确定"),
                onPressed: () async {
                  _delAddress(sId);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  // 监听页面销毁
  @override
  void dispose() {
    // TODO: implement dispose
    eventBus.fire(DefaultAddressEvent("修改收货地址成功..."));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("收货地址列表"),
      ),
      body: Stack(
        children: <Widget>[
          // 地址列表
          ListView.builder(
              itemCount: _addressList.length,
              itemBuilder: (buildContext, index) {
                return Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: _addressList[index].isDefaultAddress == true
                          ? const Icon(
                              Icons.check,
                              color: Colors.red,
                            )
                          : null,
                      title: InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${_addressList[index].name} ${_addressList[index].phone}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(_addressList[index].address),
                          ],
                        ),
                        onTap: () {
                          // 修改默认地址
                          _changeDefaultAddress(_addressList[index].sId);
                        },
                        onLongPress: () {
                          // 删除收货地址
                          _showDelAlertDialog(_addressList[index].sId);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          // 可以直接传 model
                          Navigator.pushNamed(context, "/addressEdit", arguments: _addressList[index]);
                        },
                      ),
                    ),
                    const Divider(
                      height: 20,
                    ),
                  ],
                );
              }),

          // 底部按钮
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            height: ScreenAdaper.height(88),
            child: Container(
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: ScreenAdaper.height(88),
              decoration: const BoxDecoration(
                  color: Colors.red,
                  border: Border(
                    top: BorderSide(width: 1, color: Colors.black54),
                  )),
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.add, color: Colors.white),
                    Text(
                      "增加收货地址",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/addressAdd", arguments: {
                    "isDefaultAddress": false,
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
