//[{"cate":"鞋面材料","list":["牛皮 "]},
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

import 'package:flutter/material.dart';
import 'package:flutter_strong/models/product_content_main_model.dart';
import 'package:flutter_strong/product/product_content_car_num_page.dart';
import 'package:flutter_strong/provider/cart_provider.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/product/product_content_car_num_page.dart';

class ProductContentMainPage extends StatefulWidget {
  final List _productContentList;
  const ProductContentMainPage(this._productContentList, {Key? key}) : super(key: key);

  @override
  State<ProductContentMainPage> createState() => _ProductContentMainPageState();
}

class _ProductContentMainPageState extends State<ProductContentMainPage> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();

  // 获得 Detail 数据
  late ProductContentMainItem _productContent;
  List _attr = [];
  late String _selectedValue;
  late var _actionEventBus;
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

    _actionEventBus.cancel();
  }

  _initAttr() {
    // 第一条为默认选中
    List attr = _attr;
    for (var element in attr) {
      element.attrList.clear();
    }
  }

  _changeAttr(cate, title, setBottomState) {}

  // 获取选中的值
  _getSelectedAttrValue() {}

  List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
    List<Widget> attrItemList = [];
    for (var element in attrItem.attrList) {
      attrItemList.add(Container(
        margin: const EdgeInsets.all(10),
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
    return Container();
  }
}
