// [{"cate":"鞋面材料","list":["牛皮 "]},
// {"cate":"闭合方式","list":["系带"]},
// {"cate":"颜色","list":["红色","白色","黄色"]}]

/*
   [
      {
       "cate":"尺寸",
       list":[{
            "title":"xl",
            "checked":false
          },
          {
            "title":"xxxl",
            "checked":true
          },
        ]
      },
      {
       "cate":"颜色",
       list":[{
            "title":"黑色",
            "checked":false
          },
          {
            "title":"白色",
            "checked":true
          },
        ]
      }
  ]
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_strong/models/product_content_main_model.dart';
import 'package:flutter_strong/product/product_content_car_num_page.dart';
import 'package:flutter_strong/provider/cart_provider.dart';
import 'package:flutter_strong/services/cart_services.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/uikit/fs_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductContentMainPage extends StatefulWidget {
  final List<ProductContentMainItem> _productContentList;
  const ProductContentMainPage(this._productContentList, {Key? key}) : super(key: key);

  @override
  State<ProductContentMainPage> createState() => _ProductContentMainPageState();
}

class _ProductContentMainPageState extends State<ProductContentMainPage> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  // 获得 Detail 数据
  late ProductContentMainItem _productContent;
  List<Attr>? _attr = <Attr>[];
  late String _selectedValue;
  late StreamSubscription _actionEventBus; // 订阅者
  late CartProvider _cartProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _productContent = widget._productContentList[0];
    _attr = _productContent.attr!;
    _initAttr();
    _actionEventBus = eventBus.on<ProductContentEvent>().listen((event) {
      _attrBottomSheet();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // 订阅者一定要释放，不然就会内存泄漏
    _actionEventBus.cancel();
  }

  _initAttr() {
    // 第一条为默认选中
    for (var element in _attr!) {
      element.attrList!.clear();
      for (int j = 0; j < element.list!.length; j++) {
        if (j == 0) {
          element.attrList!.add({"title": element.list![j], "checked": true});
        } else {
          element.attrList!.add({"title": element.list![j], "checked": false});
        }
      }
    }

    // 获取选中值
    _getSelectedAttrValue();
  }

  _changeAttr(cate, title, setBottomState) {
    var attr = _attr;
    for (int i = 0; i < attr!.length; i++) {
      if (attr[i].cate == cate) {
        for (int j = 0; j < attr[i].attrList!.length; j++) {
          attr[i].attrList![j]["checked"] = false;
          if (title == attr[i].attrList![j]["title"]) {
            attr[i].attrList![j]["checked"] = true;
          }
        }
      }
    }

    setBottomState(() {
      _attr = attr;
    });
    _getSelectedAttrValue();
  }

  // 获取选中的值
  _getSelectedAttrValue() {
    var attr = _attr;
    List tempAttr = [];
    for (int i = 0; i < attr!.length; i++) {
      for (int j = 0; j < attr[i].attrList!.length; j++) {
        if (attr[i].attrList![j]["checked"] == true) {
          tempAttr.add(attr[i].attrList![j]["title"]);
        }
      }
    }

    setState(() {
      _selectedValue = tempAttr.join(",");
      _productContent.selectedAttr = _selectedValue;
    });
  }

  List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
    List<Widget> attrItemList = [];
    for (var element in attrItem.attrList) {
      attrItemList.add(Container(
        margin: const EdgeInsets.all(4),
        child: InkWell(
          onTap: () {
            // 切换选中 Tag
            _changeAttr(attrItem.cate, element["title"], setBottomState);
          },
          child: Chip(
            label: Text(
              element["title"],
              style: TextStyle(color: (element["checked"] ? Colors.white : Colors.black54)),
            ),
            padding: const EdgeInsets.all(10),
            backgroundColor: (element["checked"] ? Colors.red : Colors.black26),
          ),
        ),
      ));
    }
    return attrItemList;
  }

  List<Widget> _getAttrWidget(setBottomState) {
    List<Widget> attrList = [];
    for (var item in _attr!) {
      attrList.add(Wrap(
        children: <Widget>[
          SizedBox(
            width: ScreenAdaper.width(120),
            child: Padding(
              padding: EdgeInsets.only(top: ScreenAdaper.height(22)),
              child: Text(
                "${item.cate}: ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 120,
            child: Wrap(
              children: _getAttrItemWidget(item, setBottomState),
            ),
          ),
        ],
      ));
    }
    return attrList;
  }

  // 底部弹出框
  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setBottomState) {
            return GestureDetector(
              // 点击穿透问题：禁止
              behavior: HitTestBehavior.opaque,
              // 解决 showModalBottomSheet 点击消失的问题
              onTap: () {
                return;
              },
              child: Stack(
                children: <Widget>[
                  // 选项
                  Container(
                    padding: EdgeInsets.all(ScreenAdaper.width(20)),
                    child: ListView(
                      children: <Widget>[
                        // 取消按钮
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            child: const Icon(Icons.cancel),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        // 选项
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _getAttrWidget(setBottomState),
                        ),
                        // 数量增减
                        const Divider(),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: ScreenAdaper.height(80),
                          child: Row(
                            children: <Widget>[
                              const Text(
                                "数量",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ProductContentCarNumPage(_productContent),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 底部按钮
                  Positioned(
                    bottom: 0,
                    width: MediaQuery.of(context).size.width,
                    height: ScreenAdaper.height(76),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: FSButton(
                              buttonColor: const Color.fromRGBO(253, 1, 0, 0.9),
                              buttonTitle: "加入购物车",
                              tapEvent: () async {
                                await CartServices.addCart(_productContent);
                                // 弹出页面消失
                                Navigator.pop(context);
                                // 先加入购物车后再更新数据
                                _cartProvider.updateCartList();
                                // 弹出提示框
                                Fluttertoast.showToast(
                                    msg: "加入购物车成功", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: FSButton(
                              buttonTitle: "立即购买",
                              buttonColor: const Color.fromRGBO(253, 165, 0, 0.9),
                              tapEvent: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenAdaper.init(context);
    String? pic = _productContent.pic;
    _cartProvider = Provider.of<CartProvider>(context);

    return Container(
      padding: const EdgeInsets.all(4),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.1,
            child: Image.network(
              pic!,
              fit: BoxFit.cover,
            ),
          ),
          // 标题
          Container(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _productContent.title ?? "",
              style: TextStyle(color: Colors.black87, fontSize: ScreenAdaper.fontSize(30)),
            ),
          ),
          // 二级标题
          Container(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _productContent.subTitle ?? "",
              style: TextStyle(color: Colors.black54, fontSize: ScreenAdaper.fontSize(22)),
            ),
          ),
          // 价格
          Container(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: <Widget>[
                // 均匀分配
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      const Text("特价: "),
                      Text(
                        "￥${_productContent.oldPrice}",
                        style: TextStyle(color: Colors.red, fontSize: ScreenAdaper.fontSize(44)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Text("原价"),
                      Text(
                        "￥${_productContent.price}",
                        style: TextStyle(
                          color: Colors.green.withOpacity(0.8),
                          fontSize: ScreenAdaper.fontSize(28),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            color: Colors.black54,
          ),

          // 当没有筛选项目时候不显示
          _attr!.isNotEmpty
              ? Container(
                  margin: const EdgeInsets.only(top: 0),
                  height: ScreenAdaper.height(40),
                  child: InkWell(
                    onTap: () {
                      _attrBottomSheet();
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          "已选 ",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenAdaper.fontSize(18)),
                        ),
                        Text(
                          _selectedValue,
                          style: TextStyle(fontSize: ScreenAdaper.fontSize(16)),
                        ),
                      ],
                    ),
                  ),
                )
              : const Text(""),
          const Divider(
            color: Colors.black54,
          ),
          // 运费
          SizedBox(
            height: ScreenAdaper.height(40),
            child: Row(
              children: <Widget>[
                Text(
                  "运费 ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenAdaper.fontSize(18),
                  ),
                ),
                Text(
                  "免运费",
                  style: TextStyle(fontSize: ScreenAdaper.fontSize(16)),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black54,
          ),
          const SizedBox(height: 70), // 修复底部会被上层遮挡住的问题
        ],
      ),
    );
  }
}
