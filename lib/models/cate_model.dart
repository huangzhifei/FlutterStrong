
import 'package:flutter/material.dart';

class CateModel {
  List<CateItemModel> result = [];
  CateModel({required this.result});

  CateModel.fromJson(Map<String, dynamic> json) {
    List temp = json["result"];
    result = <CateItemModel>[];
    if (temp.isNotEmpty) {
      for (var element in temp) {
        result.add(CateItemModel.fromJson(element));
      }
    } else {
      // 说明数据为空，人为造点数据
      result = generateDemoData();
    }
  }

  List<CateItemModel> generateDemoData() {
    List<CateItemModel> data = [];
    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a431";
      item.title = "笔记本电脑AAA";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/07/06/a4067df79f5681b67395baec3a2fde41.jpg";
      item.pid = "12";
      item.sort = "A";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a432";
      item.title = "笔记本电脑BBB";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/07/06/a4067df79f5681b67395baec3a2fde41.jpg";
      item.pid = "12";
      item.sort = "B";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a433";
      item.title = "笔记本电脑CCC";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/07/06/a4067df79f5681b67395baec3a2fde41.jpg";
      item.pid = "12";
      item.sort = "C";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a434";
      item.title = "笔记本电脑DDD";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/07/06/a4067df79f5681b67395baec3a2fde41.jpg";
      item.pid = "12";
      item.sort = "D";
      data.add(item);
    }

    {
      CateItemModel item = CateItemModel();
      item.sId = "59f6ef443ce1fb0fb02c7a45";
      item.title = "笔记本电脑EEE";
      item.status = "1";
      item.pic = "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/07/06/a4067df79f5681b67395baec3a2fde41.jpg";
      item.pid = "12";
      item.sort = "E";
      data.add(item);
    }

    return data;
  }
}

class CateItemModel {
  late String sId;
  late String title;
  late Object status;
  late String pic;
  late String pid;
  late String sort;

  CateItemModel({
    String? sId,
    String? title,
    Object? status,
    String? pic,
    String? pid,
    String? sort
  });

  CateItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    pid = json['pid'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['title'] = title;
    data['status'] = status;
    data['pic'] = pic;
    data['pid'] = pid;
    data['sort'] = sort;
    return data;
  }

}