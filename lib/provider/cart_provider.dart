import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_strong/models/product_content_main_model.dart';
import 'package:flutter_strong/services/fsstorage.dart';

const String cartListKey = "cartList";

// Provider：存放购物车数据，存放全选状态
class CartProvider with ChangeNotifier {
  List<ProductContentMainItem> _cartList = <ProductContentMainItem>[];
  // 底部Num
  int get cartNum => _cartList.length;
  // 列表
  List get cartList => _cartList;

  // 初始化赋值,获取购物车数据
  CartProvider() {
    init();
  }

  init() async {
    //
    _cartList = <ProductContentMainItem>[];
    try {
      List tempData = json.decode(await FSStorage.getString(cartListKey));
      for (var item in tempData) {
        _cartList.add(ProductContentMainItem.fromJson(item));
      }
    } catch (error) {
      _cartList = <ProductContentMainItem>[];
    }
    // 获取
    _isCheckAll = isFirstCheckAll();

    computeAllPrice();

    notifyListeners();
  }

  // 更新列表数据
  updateCartList() {
    init();
  }

  // 全选
  bool _isCheckAll = false;

  // 获取私有方法
  bool get isCheckAll => _isCheckAll;

  // 全选反选
  checkAll(value) async {
    for (var element in _cartList) {
      element.checked = value;
    }

    _isCheckAll = value;
    computeAllPrice();

    await FSStorage.setString(cartListKey, json.encode(_cartList));
    // 通知
    notifyListeners();
  }

  bool isFirstCheckAll() {
    if (_cartList.isNotEmpty) {
      for (var item in _cartList) {
        if (item.checked == false) {
          return false;
        }
      }
      return true;
    } else {
      return false;
    }
  }

  // + - 后将数据保存到本地
  // 监听每一项的选中事件，使列表和全选按钮保持同步
  itemChange() async {
    if (isFirstCheckAll()) {
      _isCheckAll = true;
    } else {
      _isCheckAll = false;
    }

    // 计算总价
    computeAllPrice();

    await FSStorage.setString(cartListKey, json.encode(_cartList));

    notifyListeners();
  }

  itemCountChange() {
    FSStorage.setString(cartListKey, json.encode(_cartList));

    computeAllPrice();

    notifyListeners();
  }

  removeItem() {
    List<ProductContentMainItem> tempList = [];
    for (var item in _cartList) {
      if (item.checked == false) {
        tempList.add(item);
      }
    }
    _cartList = tempList;
    computeAllPrice();
    notifyListeners();
  }

  double _allPrice = 0;
  double get allPrice => _allPrice;
  // 计算总价
  computeAllPrice() {
    double tempAllPrice = 0;
    for (var item in _cartList) {
      if (item.checked == true) {
        tempAllPrice += item.price * item.count;
      }
    }
    _allPrice = tempAllPrice;
    notifyListeners();
  }
}
