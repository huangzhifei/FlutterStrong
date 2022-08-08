import 'package:flutter/material.dart';
import 'package:flutter_strong/address/address_edit_page.dart';
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

      // 退出
      Navigator.pop(context);
    } else {
      // 弹出登陆界面
    }
  }

  // 删除框
  _delAddress(AddressModel value) async {
    // 本地
    bool isLogin = await UserServices.getUserState();
    if (isLogin) {
      // 删掉本地的某条记录
      List<AddressModel> tempData = <AddressModel>[];
      for (var item in _addressList) {
        if (item.sId == value.sId) {
        } else {
          tempData.add(item);
        }
      }
      await FSStorage.setString(kUsualAddressListKey, json.encode(tempData));
      // 重新刷新列表
      _getAddressList();
    } else {
      // 弹出登陆界面
    }
  }

  _showDelAlertDialog(value) async {
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
                  _delAddress(value);
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
    super.dispose();
    eventBus.fire(DefaultAddressEvent("修改收货地址成功..."));
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
                          Navigator.pushNamed(context, "/addressEdit", arguments: {
                            "sId": _addressList[index].sId,
                            "name": _addressList[index].name,
                            "phone": _addressList[index].phone,
                            "address": _addressList[index].address,
                            "area": _addressList[index].area,
                          });
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
