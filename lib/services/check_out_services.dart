import 'dart:convert';
import 'package:flutter_strong/config/config.dart';
import 'package:flutter_strong/models/product_content_main_model.dart';
import 'package:flutter_strong/services/fsstorage.dart';

class CheckOutServices {
  // 计算总价
  static getAllPrice(List<ProductContentMainItem> checkOutListData) {
    var tempAllPrice = 0.0;
    for (var item in checkOutListData) {
      if (item.checked == true) {
        tempAllPrice += item.price * item.count;
      }
    }
    return tempAllPrice;
  }

  static removeUnSelectedCartItem() async {
    List<ProductContentMainItem> _cartList = <ProductContentMainItem>[];
    List<ProductContentMainItem> _tempList = <ProductContentMainItem>[];

    // 获取购物车的数据
    try {
      var tempD = await FSStorage.getString(kCartListKey);
      if (tempD.isNotEmpty) {
        List cartListData = json.decode(tempD);
        if (cartListData.isNotEmpty) {
          for (var item in cartListData) {
            _cartList.add(ProductContentMainItem.fromJson(item));
          }
        }
      }
    } catch (e) {
      print("removeUnSelectedCartItem: ""$e");
    }

    for (var item in _cartList) {
      if (item.checked == false) {
        _tempList.add(item);
      }
    }

    FSStorage.setString(kCartListKey, json.encode(_tempList));
  }
}