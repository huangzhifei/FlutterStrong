import 'dart:convert';
import 'package:flutter_strong/services/fsstorage.dart';

class UserServices {
  // 获取用户信息
  static getUserInfo() async {
    List userInfoList = [];
    try {
      var userTemp = json.decode(await FSStorage.getString("userInfo"));
      userTemp.forEach((key, value) {userInfoList.add(value);});
      // print(userInfoMap);
      // print(userInfoList);
    } catch (e) {
      // print("error: $e");
      userInfoList = [];
    }
    return userInfoList;
  }

  // 获取用户登陆状态
  static getUserState() async {
    List userInfo = await UserServices.getUserInfo();
    print("userInfo: " + userInfo.toString());
    if (userInfo.isNotEmpty && userInfo[0] != null && userInfo[1] != null) {
      return true;
    } else {
      return false;
    }
  }

  // 退出登陆
  static loginOut() async {
    FSStorage.remove("userInfo");
  }
}