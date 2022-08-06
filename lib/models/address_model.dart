import 'package:flutter/cupertino.dart';

class AddressModel {
  String sId = ""; // 唯一标识
  String area = "";
  String name = "";
  String phone = "";
  String address = "";
  bool isDefaultAddress = false;

  AddressModel(
      {required this.sId,
      this.area = "",
      this.name = "",
      this.phone = "",
      this.address = "",
      this.isDefaultAddress = false});

  AddressModel.fromJson(json) {
    if (json != null) {
      sId = json["sId"] ?? "";
      area = json["area"] ?? "";
      name = json["name"] ?? "";
      phone = json["phone"] ?? "";
      address = json["address"] ?? "";
      isDefaultAddress = json["isDefaultAddress"] ?? false;
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["sId"] = sId;
    data["area"] = area;
    data["name"] = name;
    data["phone"] = phone;
    data["address"] = address;
    data["isDefaultAddress"] = isDefaultAddress;
    return data;
  }
}
