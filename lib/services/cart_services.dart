// 购物车数据类：涉及增加、删除、本地持久化缓存等
import 'dart:convert';

import 'package:flutter_strong/config/config.dart';
import 'package:flutter_strong/models/product_content_main_model.dart';
import 'package:flutter_strong/services/fsstorage.dart';

class CartServices {

  // 购物车选中的数据
  static getCheckOutData() async {
    // 全部数据
    List cartListData = [];
    try {
      cartListData = json.decode(await FSStorage.getString(kCartListKey));
    } catch (e) {
      print(e);
      cartListData = [];
    }

    // 筛选选中的数据
    List tempCheckOutData = [];
    for (var element in cartListData) {
      if (element["checked"] == true) {
        tempCheckOutData.add(element);
      }
    }
    return tempCheckOutData;
  }

  // 加入购物车，由于没有服务端接口，全本地缓存
  static addCart(ProductContentMainItem item) async {
    // 先把对象转成 Map 类型的数据
    Map<String, dynamic> data = CartServices.formatCartData(item);

    // 本地缓存
    try {
      List l = json.decode(await FSStorage.getString(kCartListKey));
      List<ProductContentMainItem> cartListData = <ProductContentMainItem>[];
      for (var value in l) {
        cartListData.add(ProductContentMainItem.fromJson(value));
      }

      // 是否有当前类型的数据
      bool hasData = cartListData.any((element) {
        // 相同 ID 的商品由于属性不一样，也要另外添加一行
        if (data["_id"] == element.sId && data["selectedAttr"] == element.selectedAttr) {
          return true;
        } else {
          return false;
        }
      });

      if (hasData) {
        for (int i = 0; i < cartListData.length; i ++) {
          if (cartListData[i].sId == item.sId && cartListData[i].selectedAttr == item.selectedAttr) {
            cartListData[i].count = cartListData[i].count + 1;
          }
          await FSStorage.setString(kCartListKey, json.encode(cartListData));
        }
      } else {
        // 没有当前数据就直接添加一行
        cartListData.add(item);
        await FSStorage.setString(kCartListKey, json.encode(cartListData));
      }
    } catch (e) {
      print(e);
      List<ProductContentMainItem> tempList = [];
      await FSStorage.setString(kCartListKey, json.encode(tempList));
    }
  }

  // 过滤数据
  static formatCartData(ProductContentMainItem item) {
    final Map<String, dynamic> data = {};
    data["_id"] = item.sId;
    data["title"] = item.title;

    data["price"] = item.price;
    data["selectedAttr"] = item.selectedAttr;
    data["count"] = item.count;
    data["pic"] = item.pic;

    // 是否选中，默认加入购物车即选中
    data["checked"] = true;

    return data;
  }
}

/*
      1、获取本地存储的cartList数据
      2、判断cartList是否有数据
            有数据：
                1、判断购物车有没有当前数据：
                        有当前数据：
                            1、让购物车中的当前数据数量 等于以前的数量+现在的数量
                            2、重新写入本地存储

                        没有当前数据：
                            1、把购物车cartList的数据和当前数据拼接，拼接后重新写入本地存储。

            没有数据：
                1、把当前商品数据以及属性数据放在数组中然后写入本地存储



                List list=[
                  {"_id": "1",
                    "title": "磨砂牛皮男休闲鞋-有属性",
                    "price": 688,
                    "selectedAttr": "牛皮 ,系带,黄色",
                    "count": 4,
                    "pic":"public\upload\RinsvExKu7Ed-ocs_7W1DxYO.png",
                    "checked": true
                  },
                    {"_id": "2",
                    "title": "磨xxxxxxxxxxxxx",
                    "price": 688,
                    "selectedAttr": "牛皮 ,系带,黄色",
                    "count": 2,
                    "pic":"public\upload\RinsvExKu7Ed-ocs_7W1DxYO.png",
                    "checked": true
                  }

                ];


*/