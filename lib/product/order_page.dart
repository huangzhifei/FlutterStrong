import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_strong/config/config.dart';
import 'package:flutter_strong/models/order_model.dart';
import 'package:flutter_strong/product/order_list_page.dart';
import 'package:flutter_strong/services/fsstorage.dart';
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
  List<OrderResult> _orderList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int state = widget.arguments!["state"] ?? 0;
    _index = OrderInfoType.values[state];
    _getListData();
  }

  _getListData() async {
    bool isLogin = await UserServices.getUserState();
    if (isLogin) {
      var tempD = await FSStorage.getString(kOrderListKey);
      List<OrderResult> res = [];
      if (tempD.isNotEmpty) {
        List orderList = json.decode(tempD);
        for (var item in orderList) {
          res.add(OrderResult.fromJson(item));
        }
      }
      setState(() {
        _orderList = res;
      });
    } else {
      _orderList = [];
      Navigator.pushNamed(context, "/login");
    }
  }



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
                ),
              ),
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              OrderListPage(arguments: {"isShowNavigation": false}),
              OrderListPage(arguments: {"isShowNavigation": false}),
              OrderListPage(arguments: {"isShowNavigation": false}),
              OrderListPage(arguments: {"isShowNavigation": false}),
              OrderListPage(arguments: {"isShowNavigation": false}),

              // Icon(Icons.local_bar, size: 128.0, color: Colors.black12,),
              // Icon(Icons.local_cafe, size: 128.0, color: Colors.black12,),
              // Icon(Icons.local_offer, size: 128.0, color: Colors.black12,),
              // Icon(Icons.local_cafe, size: 128.0, color: Colors.black12,),
              // Icon(Icons.local_offer, size: 128.0, color: Colors.black12,),
            ],
          )),
    );
  }

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("我的订单"),
  //     ),
  //     body: Stack(
  //       children: <Widget>[
  //         Container(
  //           margin: EdgeInsets.fromLTRB(0, ScreenAdaper.height(80), 0, 0),
  //           padding: EdgeInsets.all(ScreenAdaper.width(16)),
  //           child: ListView(
  //             children: _orderList.map((value) {
  //               return InkWell(
  //                 onTap: () {
  //                   Navigator.pushNamed(context, "/orderInfo");
  //                 },
  //                 child: Card(
  //                   child: Column(
  //                     children: [
  //                       ListTile(
  //                         title: Text(
  //                           "订单编号: ${value.sId}",
  //                           style: const TextStyle(color: Colors.black54),
  //                         ),
  //                       ),
  //                       const Divider(),
  //                       Column(
  //                         children: _orderItemWidget(value.orderItem),
  //                       ),
  //                       const SizedBox(
  //                         height: 10,
  //                       ),
  //                       ListTile(
  //                         leading: Text("合计: ￥${value.allPrice}"),
  //                         trailing: TextButton(
  //                           child: const Text(
  //                             "申请售后",
  //                             style: TextStyle(color: Colors.grey),
  //                           ),
  //                           onPressed: () {},
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //         Positioned(
  //           top: 0,
  //           width: MediaQuery.of(context).size.width,
  //           height: ScreenAdaper.height(44),
  //           child: Container(
  //             width: MediaQuery.of(context).size.width,
  //             height: ScreenAdaper.height(44),
  //             color: Colors.white,
  //             child: Row(
  //               children: <Widget>[
  //                 Expanded(
  //                   child: InkWell(
  //                     onTap: () {
  //                       print("全部");
  //                     },
  //                     child: Text(
  //                       "全部",
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(backgroundColor: Colors.grey.withOpacity(0.5)),
  //                   ),
  //                 )),
  //                 Expanded(
  //                   child: InkWell(
  //                       onTap: () {
  //
  //                       },
  //                       child: const Text(
  //                         "待付款",
  //                         textAlign: TextAlign.center,
  //                       )),
  //                 ),
  //                 Expanded(
  //                   child: InkWell(
  //                     onTap: () {
  //
  //                     },
  //                     child: const Text(
  //                     "待收货",
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 )),
  //                 Expanded(
  //                   child: InkWell(
  //                       onTap: () {
  //
  //                       },
  //                       child: const Text(
  //                         "已完成",
  //                         textAlign: TextAlign.center,
  //                       )),
  //                 ),
  //                 Expanded(
  //                   child: InkWell(
  //                     onTap: () {
  //
  //                     },
  //                     child: const Text(
  //                       "已取消",
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
