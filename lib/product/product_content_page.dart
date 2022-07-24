import 'package:flutter/material.dart';
import 'package:flutter_strong/models/product_content_main_model.dart';
import 'package:flutter_strong/product/product_content_detail_page.dart';
import 'package:flutter_strong/product/product_content_main_page.dart';
import 'package:flutter_strong/product/product_content_rate_page.dart';
import 'package:flutter_strong/provider/cart_provider.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/uikit/fs_button.dart';
import 'package:flutter_strong/uikit/fs_loading_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_strong/services/cart_services.dart';

class ProductContentPage extends StatefulWidget {
  final Map arguments;
  const ProductContentPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ProductContentPage> createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  late CartProvider _cartProvider;

  // 页面详情 Model
  final List _productContentList = [];
  _getDetailData() async {
    Map<String, dynamic> result = {};
    var productDetailModel = ProductContentMainModel.fromJson(result);
    setState(() {
      _productContentList.add(productDetailModel.result);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getDetailData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    _cartProvider = Provider.of<CartProvider>(context);

    return DefaultTabController(
      length: 3, // tab 数量
      child: Scaffold(
        appBar: AppBar(
          // tab 位于导航栏位置处
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                // 设置宽度让导航栏三个按钮更加紧凑
                width: ScreenAdaper.width(400),
                child: const TabBar(
                  // 底部指示器线条为红色
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: <Widget>[
                    Tab(
                      child: Text("商品"),
                    ),
                    Tab(
                      child: Text("详情"),
                    ),
                    Tab(
                      child: Text("评价"),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                // 弹出下拉菜单
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(ScreenAdaper.width(600), 100, 10, 0),
                  items: [
                    PopupMenuItem(
                      child: Row(
                        children: const [
                          Icon(Icons.home),
                          Text("首页"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: const [
                          Icon(Icons.search),
                          Text("搜索"),
                        ],
                      ),
                    ),
                  ],
                );
              },
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
        body: _productContentList.isNotEmpty
            ? Stack(
                children: <Widget>[
                  TabBarView(
                    // 禁止详情页面上下和左右滑动冲突问题
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      ProductContentMainPage(_productContentList),
                      ProductContentDetailPage(_productContentList),
                      const ProductContentRatePage(),
                    ],
                  ),
                  // 底部按钮
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    height: ScreenAdaper.height(88),
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                              color: Colors.black26,
                              width: 1,
                            ),
                          )),
                      child: Row(
                        // 左购物车，右按钮
                        children: <Widget>[
                          // 购物车
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/cart');
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
                              width: 100,
                              height: ScreenAdaper.height(88),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    size: ScreenAdaper.fontSize(36),
                                  ),
                                  Text("购物车", style: TextStyle(fontSize: ScreenAdaper.fontSize(22))),
                                ],
                              ),
                            ),
                          ),

                          // 添加购物车
                          Expanded(
                            flex: 1,
                            child: FSButton(
                              buttonColor: const Color.fromRGBO(253, 1, 0, 0.9),
                              buttonTitle: "加入购物车",
                              // 事件广播，在其他页面调用方法
                              tapEvent: () async {
                                if (_productContentList[0].att.length > 0) {
                                  // 弹出筛选框
                                  eventBus.fire(ProductContentEvent("加入购物车"));
                                } else {
                                  // 调用加入购物车服务改变数据
                                  await CartServices.addCart(_productContentList[0]);
                                  // 先加入购物车后再更新数据
                                  _cartProvider.updateCartList();
                                  // 弹出提示框
                                  Fluttertoast.showToast(
                                      msg: "加入购物车成功", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
                                }
                              },
                            ),
                          ),
                          // 立刻购买
                          Expanded(
                            flex: 1,
                            child: FSButton(
                              buttonColor: const Color.fromRGBO(255, 165, 0, 0.9),
                              buttonTitle: "立即购买",
                              tapEvent: () {
                                if (_productContentList[0].attr.length > 0) {
                                  eventBus.fire(ProductContentEvent("立即购买"));
                                } else {
                                  print("立即购买");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const LoadingWidget(),
      ),
    );
  }
}
