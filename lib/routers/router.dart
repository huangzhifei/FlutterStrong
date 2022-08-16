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
import 'package:flutter_strong/product/product_list_page.dart';
import 'package:flutter_strong/search/search_page.dart';
import 'package:flutter_strong/tabs/tab_bars.dart';
import 'package:flutter_strong/product/order_list_page.dart';

/*
 * 主要的 Widget 页面
 * ProductContentRatePage() 产品内容：评价页面
 * ProductContentMainPage() 产品内容：商品页面
 * ProductContentDetailPage() 产品内容：详情页面
 * ProductContentCarNumPage() 产品购买时的数量页面（左减、右增）
 * UserPage() 我的页面
 * HomePageWidget() 首页
 * CategoryPage() 分类页面
 * CartItem() 购物车里一条记录页面
 * CartNum() 购物车里一条记录右边的数量页面（左减、右增）
**/

//配置路由
final routes = {
  '/': (context) => const TabBars(),// 主 tab
  '/search': (context) => const SearchPage(), // 搜索
  '/login': (context) => const LoginPage(),// 登陆
  '/cart': (context, {arguments}) => CartPage(arguments: arguments),  // 购物车
  '/productList': (context, {arguments}) => ProductListPage(arguments: arguments), // 产品列表
  '/productContent': (context, {arguments}) => ProductContentPage(arguments: arguments),// 产品内容壳页面
  '/checkOut': (context) => const CheckOutPage(), // 结算页
  '/addressAdd': (context,{arguments}) => AddressAddPage(arguments: arguments), // 收货地址添加
  '/addressEdit': (context, {arguments}) => AddressEditPage(arguments: arguments), // 编辑地址
  '/addressList': (context) => const AddressListPage(), // 收货地址列表
  '/pay': (context, {arguments}) => PayPage(arguments: arguments), // 支付（立即下单）
  '/order': (context, {arguments}) => OrderPage(arguments: arguments), // 定单
  '/orderInfo': (context, {arguments}) => OrderInfoPage(arguments: arguments), // 定单详情页
  '/orderListPage': (context, {arguments}) => OrderListPage(arguments: arguments), // 订单分类列表（已付款、已经收货等）
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