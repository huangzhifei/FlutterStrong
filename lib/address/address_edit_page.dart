import 'dart:convert';
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_strong/config/config.dart';
import 'package:flutter_strong/models/address_model.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/fsstorage.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/services/user_services.dart';
import 'package:flutter_strong/uikit/fs_button.dart';
import 'package:flutter_strong/uikit/fs_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddressEditPage extends StatefulWidget {
  final AddressModel addressModel;
  // final Map<String, dynamic> arguments;
  const AddressEditPage({Key? key, required this.addressModel}) : super(key: key);

  @override
  State<AddressEditPage> createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  // // 初始化的时候给编辑页面赋值
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  AddressModel addressModel = AddressModel(sId: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressModel = widget.addressModel;
    // 需要这样初始化，不然一输入光标就跑到最前面去，还会出现输入一个字符，会随机自动重复输入N个其他字符
    nameController = TextEditingController.fromValue(TextEditingValue(
      // 设置内容
      text: addressModel.name,
      selection: TextSelection.fromPosition(
        TextPosition(
          affinity: TextAffinity.downstream,
          offset: addressModel.name.length,
        ),
      ),
    ));
    phoneController = TextEditingController.fromValue(TextEditingValue(
      // 设置内容
      text: addressModel.phone,
      selection: TextSelection.fromPosition(
        TextPosition(
          affinity: TextAffinity.downstream,
          offset: addressModel.phone.length,
        ),
      ),
    ));
    addressController = TextEditingController.fromValue(TextEditingValue(
      // 设置内容
      text: addressModel.address,
      selection: TextSelection.fromPosition(
        TextPosition(
          affinity: TextAffinity.downstream,
          offset: addressModel.address.length,
        ),
      ),
    ));
  }

  @override
  void dispose() {
    eventBus.fire(AddressEvent("编辑成功..."));
    // TODO: implement dispose
    super.dispose();
  }

  _saveChangeAddress() async {
    bool isLogin = await UserServices.getUserState();
    if (isLogin) {
      // 默认修改成功
      // 获取收货地址列表
      var tempD = await FSStorage.getString(kUsualAddressListKey);
      if (tempD.isNotEmpty) {
        List tempAddressList = json.decode(tempD);
        for (var item in tempAddressList) {
          if (item["sId"] == addressModel.sId) {
            item["name"] = addressModel.name;
            item["phone"] = addressModel.phone;
            item["area"] = addressModel.area;
            item["address"] = addressModel.address;
          }
        }
        await FSStorage.setString(kUsualAddressListKey, json.encode(tempAddressList));
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "修改失败", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("修改收货地址"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _saveChangeAddress();
            },
            child: const Text("确定", style: TextStyle(color: Colors.white, fontSize: 18),),
          ),
          // const SizedBox(width: 1,),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            FSText(
              controller: nameController,
              text: "收货人姓名",
              onChanged: (value) {
                addressModel.name = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FSText(
              controller: phoneController,
              text: "收货人电话",
              onChanged: (value) {
                addressModel.phone = value;
              },
            ),

            const SizedBox(
              height: 10,
            ),
            // 地址
            Container(
              padding: const EdgeInsets.only(left: 5),
              height: ScreenAdaper.height(68),
              decoration: const BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 1, color: Colors.black12),
              )),
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.add_location),
                    addressModel.area.isNotEmpty
                        ? Text(addressModel.area)
                        : const Text(
                            "省/市/区",
                            style: TextStyle(color: Colors.black54),
                          )
                  ],
                ),
                onTap: () async {
                  Result? result = await CityPickers.showCityPicker(
                    context: context,
                    cancelWidget: const Text(
                      "取消",
                      style: TextStyle(color: Colors.blue),
                    ),
                    confirmWidget: const Text(
                      "确定",
                      style: TextStyle(color: Colors.blue),
                    ),
                  );
                  setState(() {
                    if (result != null) {
                      addressModel.area = "${result.provinceName}/${result.cityName}/${result.areaName}";
                    }
                  });
                },
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            FSText(
              controller: addressController,
              text: "详细地址",
              maxLines: 4,
              height: 200,
              onChanged: (value) {
                addressModel.address = value;
              },
            ),

            const SizedBox(
              height: 40,
            ),

            // 修改
            FSButton(
              buttonColor: Colors.red,
              buttonTitle: "修改",
              tapEvent: () async {
                _saveChangeAddress();
              },
            ),
          ],
        ),
      ),
    );
  }
}
