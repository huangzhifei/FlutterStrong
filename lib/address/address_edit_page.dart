import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/services/user_services.dart';
import 'package:flutter_strong/uikit/fs_button.dart';
import 'package:flutter_strong/uikit/fs_text.dart';

class AddressEditPage extends StatefulWidget {
  final Map arguments;

  const AddressEditPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<AddressEditPage> createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {

  String area = "";

  // 初始化的时候给编辑页面赋值
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameController.text = widget.arguments["name"];
    phoneController.text = widget.arguments["phone"];
    addressController.text = widget.arguments["address"];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    eventBus.fire(AddressEvent("编辑成功..."));
  }

  @override
  Widget build(BuildContext context) {

    ScreenAdaper.init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("修改收货地址"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20,),
            FSText(
              controller: nameController,
              text: "收货人姓名",
              onChanged: (value) {
                nameController.text = value;
              },
            ),
            const SizedBox(height: 10,),
            FSText(
              controller: phoneController,
              text: "收货人电话",
              onChanged: (value) {
                phoneController.text = value;
              },
            ),

            const SizedBox(height: 10,),
            // 地址
            Container(
              padding: const EdgeInsets.only(left: 5),
              height: ScreenAdaper.height(68),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.black12),
                )
              ),
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.add_location),
                    area.isNotEmpty ? Text(area) : const Text("省/市/区", style: TextStyle(color: Colors.black54),)
                  ],
                ),
                onTap: () async {
                  Result? result = await CityPickers.showCityPicker(
                    context: context,
                    cancelWidget: const Text("取消", style: TextStyle(color: Colors.blue),),
                    confirmWidget: const Text("确定", style: TextStyle(color: Colors.blue),),
                  );
                  setState(() {
                    area = "${result!.provinceName}/${result!.cityName}/${result!.areaName}";
                  });
                },
              ),
            ),

            const SizedBox(height: 10,),
            FSText(
              controller: addressController,
              text: "详细地址",
              maxLines: 4,
              height: 200,
              onChanged: (value) {
                addressController.text = value;
              },
            ),

            const SizedBox(height: 40,),

            // 修改
            FSButton(
              buttonColor: Colors.red,
              buttonTitle: "修改",
              tapEvent: () async {
                bool isLogin = await UserServices.getUserState();
                if (isLogin) {
                  // 默认修改成功
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
