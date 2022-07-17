import 'package:flutter/material.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/provider/cart_provider.dart';
import 'package:flutter_strong/cart/cart_num.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final Map _itemData;
  const CartItem(this._itemData, {Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    var cartProvider = Provider.of<CartProvider>(context);

    return Container(
      height: ScreenAdaper.height(200),
      padding: EdgeInsets.all(5),

      // 底部线条
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: ScreenAdaper.width(2),
            color: Colors.black12,
          ),
        ),
      ),

      child: Row(
        children: <Widget>[
          // 单选框
          SizedBox(
            width: ScreenAdaper.width(50),
            child: Checkbox(
              value: widget._itemData["checked"],
              onChanged: (bool? value) {
                setState(() {
                  widget._itemData["checked"] = !widget._itemData["checked"];
                });
                cartProvider.itemChange();
              },
            ),
          ),

          // 图片
          SizedBox(
            width: ScreenAdaper.width(160),
            child: Image.network(widget._itemData["pic"], fit: BoxFit.cover,),
          ),

          // 标题
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                // 上 title，下 detail
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(widget._itemData["title"], maxLines: 2,),
                  Text(widget._itemData["selectedAttr"], maxLines: 2,),

                  // 左钱，右操作
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget._itemData["price"],
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(widget._itemData),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
