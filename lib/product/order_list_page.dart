import 'package:flutter/material.dart';
import 'package:flutter_strong/models/order_model.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/order_services.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/services/user_services.dart';

class OrderListPage extends StatefulWidget {
  final Map? arguments;
  const OrderListPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  late String title;
  bool isShowNavigation = true;
  late int type = 0;
  late List<OrderResult> _orderList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.arguments!["title"] ?? "全部";
    isShowNavigation = widget.arguments!["isShowNavigation"] ?? true;
    type = widget.arguments!["type"];
    _orderList = [];
    _getListData(type);
    // 监听tab切换
    eventBus.on<OrderListEvent>().listen((event) {
      int type = int.parse(event.content);
      print("刷新type = $type");
      // _getListData(type);
    });
  }

  _getListData(type) async {
    bool isLogin = await UserServices.getUserState();
    if (isLogin) {
      OrderModel resModel = await OrderServices.getOrderModel(type);
      if (type == 0) {
        resModel.toJson();
      }
      setState(() {
        _orderList = resModel.result!;
      });
    } else {
      _orderList = [];
      Navigator.pushNamed(context, "/login");
    }
  }

  // 订单商品列表组件
  List<Widget> _orderItemWidget(List<OrderItem> orderItems) {
    List<Widget> tempList = [];
    for (var item in orderItems) {
      tempList.add(Column(
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          ListTile(
            leading: SizedBox(
              width: ScreenAdaper.width(120),
              // height: ScreenAdaper.height(120),
              child: Image.network(
                item.productImg,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(item.productTitle),
            subtitle: Text("价格: ${item.productPrice}"),
            trailing: Text("x${item.productCount}"),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ));
    }
    return tempList;
  }

  Widget _getOrderListWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, ScreenAdaper.height(0), 0, 0),
      padding: EdgeInsets.all(ScreenAdaper.width(8)),
      child: ListView(
        children: _orderList.map((value) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/orderInfo", arguments: {
                "model": value.toJson(),
              });
            },
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "订单编号: ${value.sId}",
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(),
                  Column(
                    children: _orderItemWidget(value.orderItem),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 1,
                  ),
                  ListTile(
                    leading: Text(
                      "合计: ￥${value.allPrice}",
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    trailing: TextButton(
                      child: const Text(
                        "申请售后",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isShowNavigation) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: _getOrderListWidget(),
      );
    } else {
      return _getOrderListWidget();
    }
  }
}
