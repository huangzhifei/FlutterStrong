import 'package:flutter/material.dart';
import 'package:flutter_strong/login/login.dart';
import 'package:flutter_strong/product/product_list.dart';
import 'package:flutter_strong/search/search_page.dart';
import 'package:flutter_strong/tabs/tab_bars.dart';
import 'package:flutter_strong/category/category_page.dart';
//配置路由
final routes = {
  '/': (context) => const TabBars(),
  '/search': (context) => const SearchPage(),
  '/cart': (context) => const CategoryPage(),
  '/login': (context) => const LoginPage(),
  '/productList': (context, {arguments}) => ProductListPage(arguments: arguments),
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