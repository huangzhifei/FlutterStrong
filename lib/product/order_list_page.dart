import 'package:flutter/material.dart';
import 'package:flutter_strong/models/order_model.dart';
import 'package:flutter_strong/services/screen_adaper.dart';

class OrderListPage extends StatefulWidget {
  final Map? arguments;
  const OrderListPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  late String title;
  bool isShowNavigation = true;
  late List<OrderResult> _orderList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.arguments!["title"] ?? "全部";
    isShowNavigation = widget.arguments!["isShowNavigation"] ?? true;
    _orderList = [];
  }

  // 订单商品列表组件
  List<Widget> _orderItemWidget(List<OrderItem> orderItems) {
    List<Widget> tempList = [];
    for (var item in orderItems) {
      tempList.add(Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: SizedBox(
              width: ScreenAdaper.width(120),
              height: ScreenAdaper.height(120),
              child: Image.network(
                item.productImg,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(item.productTitle),
            trailing: Text("x${item.productCount}"),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ));
    }
    return tempList;
  }

  Widget _getOrderListWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, ScreenAdaper.height(80), 0, 0),
      padding: EdgeInsets.all(ScreenAdaper.width(16)),
      child: ListView(
        children: _orderList.map((value) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/orderInfo", arguments: {

              });
            },
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "订单编号: ${value.sId}",
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  const Divider(),
                  Column(
                    children: _orderItemWidget(value.orderItem),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Text("合计: ￥${value.allPrice}"),
                    trailing: TextButton(
                      child: const Text(
                        "申请售后",
                        style: TextStyle(color: Colors.grey),
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
