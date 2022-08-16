/*
  此类会随机生成订单数据，用来测试
 */
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_strong/config/config.dart';
import 'package:flutter_strong/models/order_model.dart';
import 'package:flutter_strong/services/fsstorage.dart';
import 'dart:convert';

import 'package:uuid/uuid.dart';

class OrderServices {
  static Future<OrderModel> generateOrderListData([bool flag = true]) async {
    // flag = true, 重新生成
    // flag = false, 取缓存
    OrderModel model = OrderModel();
    model.result = [];
    if (flag) {
      List<String> ts = [
        "苹果笔记本 Mac book pro 15 寸",
        "香皂 玫瑰花香",
        "香奈儿 喷香型 男式专用",
        "iPad WIFI 版 128G",
        "华为折叠屏手机 10888",
        "儿童故事书，《西游记》等系列读书",
        "nice 蔚蓝手机壳，钢化膜",
        "运行褲、气垫跑鞋、冰袖、墨镜等潮牌",
        "APad 4G 版 128G",
        "苹果手机 iPhone 14 Max Pro",
      ];

      List<String> ns = [
        "黄志飞",
        "洋洋",
        "果果",
        "黄黄",
        "帅哥"
      ];

      List<String> ps = [
        "13590483623",
        "13266627407",
        "13434519082",
        "13148842345",
        "15098453782"
      ];

      List<String> ds = [
        "广东省 深圳市 宝安区 西乡街道 40 号",
        "湖北省 天门市 干一镇 陈岭村",
        "北京市 西直门 大街 44 号",
        "广东省 深圳市 南山区 创智天地大厦 32 楼",
        "河南省 南阳市 宛城区 七建局"
      ];

      int oResCount = Random().nextInt(4) + 5;
      int oResItemCount = Random().nextInt(4) + 1;
      for (int i = 0; i < oResCount; i ++) {
        OrderResult res = OrderResult.fromWithNull();
        res.sId = const Uuid().v1();
        res.uid = const Uuid().v4();
        res.name = ns[Random().nextInt(3)];
        res.phone = ps[Random().nextInt(3)];
        res.address = ds[Random().nextInt(3)];
        res.orderItem = [];
        int allPrice = 0;
        for (int j = 0; j < oResItemCount; j ++) {
          OrderItem oItem = OrderItem.fromWithNull();
          oItem.sId = const Uuid().v1();
          oItem.orderId = const Uuid().v4();
          oItem.productTitle = ts[Random().nextInt(ts.length)];
          oItem.productId = const Uuid().v1() + "$i";
          oItem.productPrice = Random().nextInt(10000);
          oItem.addTime = DateTime.now().microsecond;
          oItem.selectedAttr = "红色,优化";
          oItem.productCount = Random().nextInt(6) + 1;
          oItem.productImg = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/07/04/c264a3a80afd240cdf1343e8f8de5a9d.jpg";
          res.orderItem.add(oItem);
          allPrice += oItem.productPrice * oItem.productCount;
        }
        res.allPrice = "$allPrice";
        res.payStatus = Random().nextInt(4) + 1;
        res.orderStatus = res.payStatus;
        model.result!.add(res);
      }
      // 缓存到本地
      await FSStorage.setString(kOrderListKey, json.encode(model));
    } else {
      var tempD = await FSStorage.getString(kOrderListKey);
      if (tempD.isNotEmpty) {
        model = OrderModel.fromJson(json.decode(tempD)) ;
      }
    }
    return model;
  }

  static Future<OrderModel> getOrderModel([int type = 0]) async {
    var tempD = await FSStorage.getString(kOrderListKey);
    OrderModel model = OrderModel();
    if (tempD.isNotEmpty) {
      model = OrderModel.fromJson(json.decode(tempD));
      OrderModel tempModel = OrderModel();
      tempModel.result = [];
      if (type == 1) {
        List<OrderResult>? resList = model.result;
        for (int i = 0; i < resList!.length; i ++) {
          int payStatus = resList[i].payStatus;
          if (payStatus == 1) {
            tempModel.result!.add(resList[i]);
          }
        }
        model = tempModel;
      } else if (type == 2) {
        List<OrderResult>? resList = model.result;
        for (int i = 0; i < resList!.length; i ++) {
          int payStatus = resList[i].payStatus;
          if (payStatus == 2) {
            tempModel.result!.add(resList[i]);
          }
        }
        model = tempModel;
      } else if (type == 3) {
        List<OrderResult>? resList = model.result;
        for (int i = 0; i < resList!.length; i ++) {
          int payStatus = resList[i].payStatus;
          if (payStatus == 3) {
            tempModel.result!.add(resList[i]);
          }
        }
        model = tempModel;
      } else if (type == 4) {
        List<OrderResult>? resList = model.result;
        for (int i = 0; i < resList!.length; i ++) {
          int payStatus = resList[i].payStatus;
          if (payStatus == 4) {
            tempModel.result!.add(resList[i]);
          }
        }
        model = tempModel;
      } else {
        // 全部
      }
    }
    return model;
  }

  // 获取待支付
  static Future<OrderModel> getNeedPayOrderModel() async {
    return OrderServices.getOrderModel(1);
  }

  // 获取待收货
  static Future<OrderModel> getPayDoneOrderModel() async {
    return OrderServices.getOrderModel(2);
  }

  // 获取已完成
  static Future<OrderModel> getEndOrderModel() async {
    return OrderServices.getOrderModel(3);
  }

  // 获取已取消
  static Future<OrderModel> getCancelOrderModel() async {
    return OrderServices.getOrderModel(4);
  }
}