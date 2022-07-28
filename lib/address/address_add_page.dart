import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/uikit/fs_button.dart';
import 'package:flutter_strong/uikit/fs_text.dart';

class AddressAddPage extends StatefulWidget {
  const AddressAddPage({Key? key}) : super(key: key);

  @override
  State<AddressAddPage> createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {

  String area = "";
  String name = "";
  String phone = "";
  String address = "";

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
            const SizedBox(height: 20,),
            FSText(
              text: "收货人姓名",
              onChanged: (value) {
                name = value;
              },
            ),
            const SizedBox(height: 10,),
            FSText(
              text: "收货人电话",
              onChanged: (value) {
                phone = value;
              },
            ),
            const SizedBox(height: 10,),
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
                    area.isNotEmpty ? Text(area, style: const TextStyle(color: Colors.black54),),
                  ],
                ),
                onTap: () async {
                  Result? result = await CityPickers.showCityPicker(
                    context: context,
                    cancelWidget: const Text("取消", style: TextStyle(color: Colors.blue),),
                    confirmWidget: const Text("确定", style: TextStyle(color: Colors.blue),),
                  );
                  setState(() {
                    area = "${result!.provinceName}/${result.cityName}/${result.areaName}";
                  });
                },
              ),
            ),

            const SizedBox(height: 10,),
            FSText(
              text: "详细地址",
              maxLines: 4,
              height: 200,
              onChanged: (value) {
                address = "$area $value";
              },
            ),

            const SizedBox(height: 40,),
            FSButton(
              buttonTitle: "增加",
              buttonColor: Colors.red,
              tapEvent: () async {
                // 假设成功
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
