import 'package:flutter/material.dart';
import 'package:flutter_strong/models/product_content_main_model.dart';
import 'package:flutter_strong/services/screen_adaper.dart';

class ProductContentCarNumPage extends StatefulWidget {
  final ProductContentMainItem _productContent;

  const ProductContentCarNumPage(this._productContent, {Key? key}) : super(key: key);

  @override
  State<ProductContentCarNumPage> createState() => _ProductContentCarNumPageState();
}

class _ProductContentCarNumPageState extends State<ProductContentCarNumPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    ScreenAdaper.init(context);

    // 左侧按钮
    Widget _leftBtn() {
      return InkWell(
        onTap: () {
          // 最多减为 1
          if (widget._productContent.count! > 1) {
            setState(() {
              widget._productContent.count = (widget._productContent.count! - 1);
            });
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
          setState(() {
            widget._productContent.count = (widget._productContent.count! + 1);
          });
        },
        child: Container(
          alignment: Alignment.center,
          width: ScreenAdaper.width(45),
          height: ScreenAdaper.height(45),
          child: const Text("+"),
        ),
      );
    }

    Widget _centerArea() {
      return Container(
        alignment: Alignment.center,
        width: ScreenAdaper.width(70),
        height: ScreenAdaper.width(45),
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(width: 1, color: Colors.black12),
            right: BorderSide(width: 1, color: Colors.black12),
          )
        ),
        child: Text("${widget._productContent.count}"),
      );
    }

    return Container(
      width: ScreenAdaper.width(164),
      decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
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
