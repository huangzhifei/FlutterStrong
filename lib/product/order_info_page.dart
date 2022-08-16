import 'package:flutter/material.dart';
import 'package:flutter_strong/models/order_model.dart';
import 'package:flutter_strong/services/screen_adaper.dart';

class OrderInfoPage extends StatefulWidget {
  final Map arguments;
  const OrderInfoPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<OrderInfoPage> createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  late OrderResult _orderRes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orderRes = OrderResult.fromJson(widget.arguments["model"]);
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

  // 如何解决英文单词被整体截断呢？
  // 将单词的每个字符切割开，插入宽度0的占位字符，打破系统默认的机制，这样就可以以字符为单位省略了
  // 需要注意。这种方式相当于修改了文本的内容，一般文本最大一行显示可以用，如果文本支持2行以及以上的显示的话，
  // 将会导致换行不再按照字符进行而按照单词进行
  String toCharacterBreakStr(String word) {
    if (word.isEmpty) {
      return word;
    }
    String breakWord = '';
    for (var element in word.runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }
    return breakWord;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("订单详情"),
      ),
      body: ListView(
        children: <Widget>[
          // 收货地址
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                ListTile(
                  leading: const Icon(Icons.add_location),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${_orderRes.name} ${_orderRes.phone}"),
                      const SizedBox(height: 10),
                      Text(_orderRes.address),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          // 列表
          Column(
            children: _orderItemWidget(_orderRes.orderItem),
          ),

          // 详情信息
          Container(
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Row(
                    children: <Widget>[
                      const Text(
                        "订单编号：",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          toCharacterBreakStr(_orderRes.sId),
                          // softWrap: true,
                          // style: const TextStyle(backgroundColor: Colors.green),
                        ),
                      ),
                      // Expanded(child: const Text("123456789-987654321-3456789-1234-3445568992874-238484884", maxLines: 2,),)
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: const <Widget>[
                      Text(
                        "下单日期：",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("2022-07-27"),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: const <Widget>[
                      Text(
                        "支付方式：",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("微信支付"),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: const <Widget>[
                      Text(
                        "配送方式：",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("顺丰"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          Container(
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Row(
                    children: <Widget>[
                      const Text(
                        "总金额：",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "￥${_orderRes.allPrice}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
