import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/services/user_services.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({Key? key}) : super(key: key);

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  // 请求列表数据
  List addressList = [];

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
    // 请求接口
    var response = [];
    setState(() {
      addressList = response;
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
  _delAddress(value) async {
    // 本地
    bool isLogin = await UserServices.getUserState();
    if (isLogin) {
      // 删掉本地的某条记录

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
              itemCount: addressList.length,
              itemBuilder: (buildContext, index) {
                return Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: addressList[index]["default_address"] == 1
                          ? const Icon(
                              Icons.check,
                              color: Colors.red,
                            )
                          : null,
                      title: InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${addressList[index]["name"]} ${addressList[index]["phone"]}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("${addressList[index]["address"]}"),
                          ],
                        ),
                        onTap: () {
                          // 修改默认地址
                          _changeDefaultAddress(addressList[index]["_id"]);
                        },
                        onLongPress: () {
                          // 删除收货地址
                          _showDelAlertDialog(addressList[index]["_id"]);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/addressEdit", arguments: {
                            "id": addressList[index]["_id"],
                            "name": addressList[index]["name"],
                            "phone": addressList[index]["phone"],
                            "address": addressList[index]["address"],
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
                border:Border(
                  top: BorderSide(width: 1, color: Colors.black54),
                )
              ),
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.add, color: Colors.white),
                    Text("增加收货地址", style: TextStyle(color: Colors.white),),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/addressAdd");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
