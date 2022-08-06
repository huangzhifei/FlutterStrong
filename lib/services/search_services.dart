import 'dart:convert';
import 'package:flutter_strong/config/config.dart';
import 'package:flutter_strong/services/fsstorage.dart';

class SearchServices {

  // 保存历史搜索记录到本地缓存里
  static setHistoryData(keywords) async {
    /*
          1、获取本地存储里面的数据  (searchList)
          2、判断本地存储是否有数据
              2.1、如果有数据
                    1、读取本地存储的数据
                    2、判断本地存储中有没有当前数据，
                        如果有不做操作、
                        如果没有当前数据,本地存储的数据和当前数据拼接后重新写入
              2.2、如果没有数据
                    直接把当前数据放在数组中写入到本地存储
     */
    try {
      // 将 json 字符串转化
      List searchListData = json.decode(await FSStorage.getString(kSearchListKey));

      // 判断本地存储是否有数据：判断数组中是否有某个值
      var hasKeywords = searchListData.any((element) {
        return element == keywords;
      });

      // 如果没有当前数据：本地存储的数据和当前数据拼接后重新写入
      if (!hasKeywords) {
        searchListData.add(keywords);
        await FSStorage.setString(kSearchListKey, json.encode(searchListData));
      }

    } catch(e) {
      print(e);
      // 直接把当前数据放在数组中写入到本地存储
      List tempList = [];
      tempList.add(keywords);
      // 将数组转化为字符串
      await FSStorage.setString(kSearchListKey, json.encode(tempList));
    }
  }

  // 从本地缓存里取出历史搜索记录
  static getHistoryData() async {
    try {
      List searchListData = json.decode(await FSStorage.getString(kSearchListKey));
      return searchListData;
    } catch (e) {
      print(e);
      return [];
    }
  }

  // 清空历史记录
  static clearHistoryList() async {
    await FSStorage.remove("searchList");
  }

  // 长按删除某条历史记录
  static removeHistoryData(keywords) async {
    List searchListData = json.decode(await FSStorage.getString(kSearchListKey));
    searchListData.remove(keywords);
    await FSStorage.setString(kSearchListKey, json.encode(searchListData));
  }
}