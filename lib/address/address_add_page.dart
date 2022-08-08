import 'dart:convert';
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_strong/config/config.dart';
import 'package:flutter_strong/models/address_model.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/fsstorage.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/uikit/fs_button.dart';
import 'package:flutter_strong/uikit/fs_text.dart';
import 'package:uuid/uuid.dart';

class AddressAddPage extends StatefulWidget {
  final Map arguments;
  const AddressAddPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<AddressAddPage> createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  late AddressModel addressModel =
      AddressModel(sId: const Uuid().v4(), isDefaultAddress: widget.arguments["isDefaultAddress"]);

  // 页面销毁广播
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    eventBus.fire(AddressEvent("增加地址成功"));
    eventBus.fire(DefaultAddressEvent("改收货地址成功..."));
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("增加收货地址"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            FSText(
              text: "收货人姓名",
              onChanged: (value) {
                addressModel.name = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FSText(
              text: "收货人电话",
              onChanged: (value) {
                addressModel.phone = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            // 弹出省市区
            Container(
              padding: const EdgeInsets.only(left: 5),
              height: ScreenAdaper.height(68),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.black12),
                ),
              ),
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.add_location),
                    addressModel.area.isNotEmpty
                        ? Text(
                            addressModel.area,
                            style: const TextStyle(color: Colors.black54),
                          )
                        : const Text(
                            "省/市/区",
                            style: TextStyle(color: Colors.black54),
                          ),
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
                      addressModel.area =
                          "${result.provinceName}/${result.cityName}/${result.areaName}";
                    }
                  });
                },
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            FSText(
              text: "详细地址",
              maxLines: 4,
              height: 200,
              onChanged: (value) {
                addressModel.address = "${addressModel.area} $value";
              },
            ),

            const SizedBox(
              height: 40,
            ),
            FSButton(
              buttonTitle: "增加",
              buttonColor: Colors.red,
              tapEvent: () async {
                print("点击了 增加 按钮");
                // 获取收货地址列表
                var tempD = await FSStorage.getString(kUsualAddressListKey);
                List tempAddressList = [];
                if (tempD.isEmpty) {
                  tempAddressList.add(addressModel.toJson());
                } else {
                  tempAddressList = json.decode(tempD);
                  tempAddressList.add(addressModel.toJson());
                }
                await FSStorage.setString(kUsualAddressListKey, json.encode(tempAddressList));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
