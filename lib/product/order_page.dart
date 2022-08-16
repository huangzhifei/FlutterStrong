import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_strong/models/order_model.dart';
import 'package:flutter_strong/product/order_list_page.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/order_services.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/services/user_services.dart';

enum OrderInfoType {
  orderInfoAll, // 全部订单
  orderInfoNeedPay, // 待支付
  orderInfoPayDone, // 待收货
  orderInfoEnd, // 已完成
  orderInfoCancel, // 已取消
}

class OrderPage extends StatefulWidget {
  final Map? arguments;
  const OrderPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late OrderInfoType _index; // 默认是全部订单
  final List<String> _tabTitleList = ["全部", "待付款", "待收货", "已完成", "已取消"];

  // 获取数据
  // List<OrderResult> _orderList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int state = widget.arguments!["state"] ?? 0;
    _index = OrderInfoType.values[state];
  }

  // _getListData() async {
  //   bool isLogin = await UserServices.getUserState();
  //   if (isLogin) {
  //     OrderModel resModel = await OrderServices.getOrderModel();
  //     setState(() {
  //       _orderList = resModel.result!;
  //     });
  //   } else {
  //     _orderList = [];
  //     Navigator.pushNamed(context, "/login");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);

    List<Widget> _tabWidgets = _tabTitleList.map((e) {
      return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Text(
          e,
          style: const TextStyle(fontSize: 14),
        ),
      );
    }).toList();

    List<OrderListPage> _tabBodyWidgets = [];
    for (int i = 0; i < _tabTitleList.length; i ++) {
     _tabBodyWidgets.add(OrderListPage(arguments: {
       "isShowNavigation": false,
       "type": i
     }));
    }

    return DefaultTabController(
      initialIndex: _index.index,
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("我的订单"),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(44),
              child: Material(
                // TabBar 中的tab的背景颜色取的实际是 AppBar 的主题色，
                // 所以我们将 TabBar 放在 Material 中来重置了主题色，变成我们想要的背景色
                color: Colors.white,
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  // indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 2.0,
                  tabs: _tabWidgets,
                  // 这里不需要特意触发切换时的通知，系统内容会触发子页面的 initState 方法
                  // onTap: (index) {
                  //   print("当前点击的tab index = $index");
                  //   // 如何刷新了
                  //   eventBus.fire(OrderListEvent("$index"));
                  // },
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: _tabBodyWidgets,
          )),
    );
  }
}
