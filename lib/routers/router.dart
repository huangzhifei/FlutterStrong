import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_strong/address/address_add_page.dart';
import 'package:flutter_strong/address/address_edit_page.dart';
import 'package:flutter_strong/address/address_list_page.dart';
import 'package:flutter_strong/cart/cart_page.dart';
import 'package:flutter_strong/login/login.dart';
import 'package:flutter_strong/product/check_out_page.dart';
import 'package:flutter_strong/product/order_info_page.dart';
import 'package:flutter_strong/product/order_page.dart';
import 'package:flutter_strong/product/pay_page.dart';
import 'package:flutter_strong/product/product_content_page.dart';
import 'package:flutter_strong/product/product_list.dart';
import 'package:flutter_strong/search/search_page.dart';
import 'package:flutter_strong/tabs/tab_bars.dart';

//配置路由
final routes = {
  '/': (context) => const TabBars(),// 主 tab
  '/search': (context) => const SearchPage(), // 搜索
  '/login': (context) => const LoginPage(),// 登陆
  '/cart': (context) => const CartPage(),
  '/productList': (context, {arguments}) => ProductListPage(arguments: arguments), // 产品列表
  '/productContent': (context, {arguments}) => ProductContentPage(arguments: arguments),// 产品详情
  '/checkOut': (context) => const CheckOutPage(), // 结算
  '/addressAdd': (context) => const AddressAddPage(), // 收货地址添加
  '/addressEdit': (context, {arguments}) => AddressEditPage(arguments: arguments), // 编辑地址
  '/addressList': (context) => const AddressListPage(), // 收货地址列表
  '/pay': (context) => const PayPage(), // 支付
  '/order': (context) => const OrderPage(), // 定单
  '/orderInfo': (context) => const OrderInfoPage(), // 定单详情
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final String name = settings.name ?? "";
  final Function? pageContentBuilder = routes[name];
  if (settings.arguments != null) {
    final Route<dynamic> route = MaterialPageRoute(
        builder: (context) => pageContentBuilder!(context, arguments: settings.arguments));
    return route;
  } else {
    final Route<dynamic>route = MaterialPageRoute(builder: (context) => pageContentBuilder!(context));
    return route;
  }
}