
import 'dart:convert';
import 'package:flutter_strong/services/storage.dart';

class UserServices {
  // 获取用户信息
  static getUserInfo() async {
    List userInfoList = [];
    try {
      var ss = await Storage.getString("userInfo");
      var userInfoMap = json.decode({"username": "_username", "password": "_password"}.toString());
      // var userTemp = json.decode(await Storage.getString("userInfo"));
      // List userInfoList = [];
      // userInfoMap.forEach((key, value) {userInfoList.add(value);});
      // print(userInfoMap);
      // print(userInfoList);
    } catch (e) {
      print("error: $e");
      userInfoList = [];
    }
    return userInfoList;
  }

  // 获取用户登陆状态
  static getUserState() async {
    List userInfo = await UserServices.getUserInfo();
    if (userInfo[0] != null && userInfo[1] != null) {
      return true;
    } else {
      return false;
    }
  }

  // 退出登陆
  static loginOut() async {
    Storage.remove("userInfo");
  }
}