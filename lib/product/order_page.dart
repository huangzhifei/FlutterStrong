import 'package:flutter/material.dart';
import 'package:flutter_strong/models/order_model.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/services/sign_services.dart';
import 'package:flutter_strong/services/user_services.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // 获取数据
  List<OrderResult> _orderList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getListData();
  }

  _getListData() async {
    List userInfo = await UserServices.getUserInfo();
    var tempJson = {"uid": userInfo[0]["_id"], "salt": userInfo[0]["salt"]};
    var sign = SignServices.getSign(tempJson);
    var response = {"data": ""};
    setState(() {
      var orderModel = OrderModel.fromJson(response);
      _orderList = orderModel.result;
    });
  }

  // 自定义商品列表组件
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

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("我的订单"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, ScreenAdaper.height(80), 0, 0),
            padding: EdgeInsets.all(ScreenAdaper.width(16)),
            child: ListView(
              children: _orderList.map((value) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/orderInfo");
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
          ),
          Positioned(
            top: 0,
            width: MediaQuery.of(context).size.width,
            height: ScreenAdaper.height(76),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: ScreenAdaper.height(76),
              color: Colors.white,
              child: Row(
                children: const <Widget>[
                  Expanded(
                      child: Text(
                    "全部",
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                      child: Text(
                    "待付款",
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                      child: Text(
                    "待收货",
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                      child: Text(
                    "已完成",
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                      child: Text(
                    "已取消",
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
