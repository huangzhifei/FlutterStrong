import 'package:flutter/material.dart';
import 'package:flutter_strong/provider/checkout_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CheckOutProvider _checkOutProvider;

  // 点击结算按钮
  doCheckOut() async {
    // 获取结算数据
    // List checkOutData = await CartSer
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
