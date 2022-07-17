// 购物车数据类
import 'dart:convert';
import 'package:flutter_strong/services/storage.dart';

class CartServices {

  // 购物车选中的数据
  static getCheckOutData() async {
    // 全部数据
    List cartListData = [];
    try {
      cartListData = json.decode(await Storage.getString("cartList"));
    } catch (e) {
      print(e);
      cartListData = [];
    }

    // 筛选选中的数据
    List tempCheckOutData = [];
    for (var element in cartListData) {
      if (element["checked"]) {
        tempCheckOutData.add(element);
      }
    }

    return tempCheckOutData;
  }

  // 加入购物车
  static addCart(item) async {
    // item = CartServices.form
  }

  // 过滤数据
  static formatCartData(item) {
    String sPic = item.pic
  }

}