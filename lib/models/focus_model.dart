/*
'{
    "_id":"59f6ef443ce1fb0fb02c7a43",
    "title":"笔记本电脑 ",
    "status":"1",
    "pic":"public\\upload\\UObZahqPYzFvx_C9CQjU8KiX.png",
    "url":"12"
  }'
 */
// 小项目中使用 dart:convert 手动序列化 JSON 非常好
// 大项目类型安全，很多时候像 20 看不出来是 int 还是 string，
// 而且还会自动补全类似 people.name，不是 people["name"]
// 最重要的是编译时无法提前发现 people["name] 打错key

// 下面的是手动敲的，后面考虑自动生成
import 'package:flutter/material.dart';

class FocusModel {
  List<FocusItem> result = [];

  FocusModel({required List<FocusItem> result});

  FocusModel.fromJson(Map<String, dynamic> json) {
    List responseResult = json["result"];
    result = <FocusItem>[];
    if (responseResult.isNotEmpty) {
      for (var item in responseResult) {
        result.add(FocusItem.fromJson(item));
      }
    } else {
      // 说明数据为空，人为造点数据
      result = generateDemoData();
    }
  }

  List<FocusItem> generateDemoData() {
    List<FocusItem> data = [];
    {
      FocusItem item = FocusItem();
      item.sId = "59f6ef443ce1fb0fb02c7a43";
      item.title = "笔记本电脑A";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.url = "12";
      data.add(item);
    }

    {
      FocusItem item = FocusItem();
      item.sId = "59f6ef443ce1fb0fb02c7a44";
      item.title = "笔记本电脑B";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/07/04/c264a3a80afd240cdf1343e8f8de5a9d.jpg";
      item.url = "13";
      data.add(item);
    }

    {
      FocusItem item = FocusItem();
      item.sId = "59f6ef443ce1fb0fb02c7a45";
      item.title = "笔记本电脑C";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/07/06/6805466d25fee701b7e1280e76ffa092.png";
      item.url = "14";
      data.add(item);
    }

    {
      FocusItem item = FocusItem();
      item.sId = "59f6ef443ce1fb0fb02c7a46";
      item.title = "笔记本电脑D";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/06/30/16318a5e6eba54a8fede932fa14013d4.png";
      item.url = "15";
      data.add(item);
    }

    {
      FocusItem item = FocusItem();
      item.sId = "59f6ef443ce1fb0fb02c7a47";
      item.title = "笔记本电脑E";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png";
      item.url = "16";
      data.add(item);
    }

    {
      FocusItem item = FocusItem();
      item.sId = "59f6ef443ce1fb0fb02c7a48";
      item.title = "笔记本电脑F";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/07/04/c264a3a80afd240cdf1343e8f8de5a9d.jpg";
      item.url = "17";
      data.add(item);
    }

    {
      FocusItem item = FocusItem();
      item.sId = "59f6ef443ce1fb0fb02c7a49";
      item.title = "笔记本电脑G";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/07/06/6805466d25fee701b7e1280e76ffa092.png";
      item.url = "18";
      data.add(item);
    }

    {
      FocusItem item = FocusItem();
      item.sId = "59f6ef443ce1fb0fb02c7a50";
      item.title = "笔记本电脑H";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/06/30/16318a5e6eba54a8fede932fa14013d4.png";
      item.url = "19";
      data.add(item);
    }

    return data;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["result"] = result.map((e) => e.toJson()).toList();
    return data;
  }
}

class FocusItem {
  late String sId;    // 商品id
  late String title;  // 标题
  late String status;
  late String pic;    // 商品图片
  late String url;    // 点击跳转的详情页

  // 可选构造函数
  FocusItem({String? sId, String? title, String? status, String? pic, String? url});

  // 命名构造函数
  FocusItem.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    title = json["title"];
    status = json["status"];
    pic = json["pic"];
    url = json["url"];
  }

  // 类里面的属性转化为 Map 类型
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["_id"] = sId;
    data["title"] = title;
    data["status"] = status;
    data["pic"] = pic;
    data["url"] = url;
    return data;
  }
}