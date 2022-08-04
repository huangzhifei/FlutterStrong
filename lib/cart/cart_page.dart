import 'package:flutter/material.dart';
import 'package:flutter_strong/cart/cart_item.dart';
import 'package:flutter_strong/provider/cart_provider.dart';
import 'package:flutter_strong/provider/checkout_provider.dart';
import 'package:flutter_strong/services/cart_services.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/services/user_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

const Map data = {"isHome": true};

class CartPage extends StatefulWidget {
  final Map arguments;
  const CartPage({Key? key, this.arguments = data}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CheckOutProvider _checkOutProvider;

  // 点击结算按钮
  doCheckOut() async {
    // 获取结算数据
    List checkOutData = await CartServices.getCheckOutData();
    // 保存选中数据
    _checkOutProvider.changeCheckOutListData(checkOutData);
    // 购物车是否有选中的数据
    if (checkOutData.isNotEmpty) {
      // 判断用户是否登陆
      bool userLoginState = await UserServices.getUserState();
      if (userLoginState) {
        Navigator.pushNamed(context, "/checkOut");
      } else {
        Fluttertoast.showToast(msg: "请先登陆再结算", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
        Navigator.pushNamed(context, "/login");
      }
    } else {
      Fluttertoast.showToast(msg: "没有选中商品哦", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
    }
  }

  // 是否编辑状态支持删除
  bool _isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);

    // 是不是门户的购物车
    bool isHome = widget.arguments["isHome"];
    // 获取通知提供的值：全选按钮
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    // 获取结算页面
    _checkOutProvider = Provider.of<CheckOutProvider>(context);

    Widget getCartWidget() {
      if (cartProvider.cartList.isNotEmpty) {
        List<Widget> cartItems = cartProvider.cartList.map((e) {
          return CartItem(e);
        }).toList();

        return Stack(
          children: <Widget>[
            // 商品、列表
            ListView(
              children: <Widget>[
                Column(
                  children: cartItems,
                ),
                SizedBox(
                  // color: Colors.green,
                  height: isHome ? ScreenAdaper.height(78) : ScreenAdaper.height(48),
                ),
              ],
            ),
            // 底部按钮条
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              height: ScreenAdaper.height(78),
              child: Container(
                // width: MediaQuery.of(context).size.width,
                // height: ScreenAdaper.height(78),
                // 顶部线条
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: ScreenAdaper.width(2),
                      color: Colors.black12,
                    ),
                  ),
                  color: Colors.white,
                ),

                //左全选、右结算
                child: Stack(
                  children: <Widget>[
                    // 全选
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        // 左单选框，右文本
                        children: <Widget>[
                          // 单选框
                          SizedBox(
                            width: ScreenAdaper.width(40),
                            child: Checkbox(
                              value: cartProvider.isCheckAll,
                              activeColor: Colors.pink,
                              onChanged: (value) {
                                // 实现全选反选
                                cartProvider.checkAll(value);
                              },
                            ),
                          ),
                          // 文本
                          const Text("全选"),
                          const SizedBox(
                            width: 20,
                          ),
                          _isEdit == false ? const Text("合计: ") : const Text(""),
                          _isEdit == false
                              ? Text(
                                  "￥ ${cartProvider.allPrice}",
                                  style: const TextStyle(color: Colors.red),
                                )
                              : const Text(""),
                        ],
                      ),
                    ),
                    // 结算
                    _isEdit == false
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min, // 这里要设置 Row 最小，不然就撑开跑最左边去了
                              children: <Widget>[
                                TextButton(
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                                    child: const Text(
                                      "结算",
                                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: doCheckOut),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          )
                        : Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min, // 这里要设置 Row 最小，不然就撑开跑最左边去了
                              children: <Widget>[
                                TextButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                                  child: const Text(
                                    "删除",
                                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    // 删除数据
                                    cartProvider.removeItem();
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            )),
                  ],
                ),
              ),
            ),
          ],
        );
      } else {
        return const Center(
          child: Text("购物车是空的..."),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("购物车"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  _isEdit = !_isEdit;
                });
              },
              icon: _isEdit == false ? const Icon(Icons.edit) : const Icon(Icons.done)),
        ],
      ),
      body: getCartWidget(),
    );
  }
}
