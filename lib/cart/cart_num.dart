import 'package:flutter/material.dart';
import 'package:flutter_strong/models/product_content_main_model.dart';
import 'package:flutter_strong/provider/cart_provider.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:provider/provider.dart';

class CartNum extends StatefulWidget {
  final ProductContentMainItem _itemData;
  const CartNum(this._itemData, {Key? key}) : super(key: key);

  @override
  State<CartNum> createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  late CartProvider _cartProvider;

  // 获得上一个页面传入
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    _cartProvider = Provider.of<CartProvider>(context);

    // 左侧按钮
    Widget _leftBtn() {
      return InkWell(
        onTap: () {
          if (widget._itemData.count > 1) {
            widget._itemData.count = widget._itemData.count - 1;
            _cartProvider.itemCountChange();
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: ScreenAdaper.width(45),
          height: ScreenAdaper.height(45),
          child: const Text("-"),
        ),
      );
    }

    // 右侧按钮
    Widget _rightBtn() {
      return InkWell(
        onTap: () {
          widget._itemData.count = widget._itemData.count + 1;
          _cartProvider.itemCountChange();
        },
        child: Container(
          alignment: Alignment.center,
          width: ScreenAdaper.width(45),
          height: ScreenAdaper.height(45),
          child: const Text("+"),
        ),
      );
    }

    // 中间
    Widget _centerArea() {
      return Container(
        alignment: Alignment.center,
        width: ScreenAdaper.width(70),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: ScreenAdaper.width(2), color: Colors.black12),
            right: BorderSide(width: ScreenAdaper.width(2), color: Colors.black12),
          ),
        ),
        height: ScreenAdaper.height(45),
        child: Text("${widget._itemData.count}"),
      );
    }

    return Container(
      width: ScreenAdaper.width(168),
      decoration: BoxDecoration(
        border: Border.all(width: ScreenAdaper.width(2), color:Colors.black12)
      ),
      child: Row(
        children: <Widget>[
          _leftBtn(),
          _centerArea(),
          _rightBtn(),
        ],
      ),
    );
  }
}
