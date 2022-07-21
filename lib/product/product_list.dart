import 'package:flutter/material.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/services/search_services.dart';
import 'package:flutter_strong/uikit/fs_loading_widget.dart';
import 'package:flutter_strong/models/product_list_model.dart';

class ProductListPage extends StatefulWidget {
  // 上个页面传入 arguments 参数
  final Map arguments;
  const ProductListPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  // 是否有搜索的数据
  bool _hasData = true;
  var _keywords = "";

  // 配置search搜索框的值
  final _initKeywordsController = TextEditingController();

  // 二级导航数据
  final List _subHeaderList = [
    {"id": 1, "title": "综合", "fileds": "all", "sort": -1},
    {"id": 2, "title": "销量", "fileds": "sale_count", "sort": -1},
    {"id": 3, "title": "价格", "fileds": "price", "sort": -1},
    {"id": 4, "title": "筛选"}
  ];
  // 二级导航选中判断
  int _selectHeaderId = 1;

  // 通过事件打开侧边栏
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // 用于上拉分页
  final ScrollController _scrollController = ScrollController();
  // 解决重复请求的问题
  bool _flag = true;
  // 每页有多少条数据
  final int _pageSize = 8;
  // 是否有数据
  bool _hasMore = true;
  // 分页
  int _page = 1;
  // 排序:价格升序 sort=price_1 价格降序 sort=price_-1  销量升序 sort=salecount_1 销量降序 sort=salecount_-1
  String _sort = "";
  List <ProductListItemModel>_productList = [];

  // 导航改变的时候触发
  _subHeaderChange(id) {
    if (id == 4) {
      // 打开侧边栏
      _scaffoldKey.currentState!.openEndDrawer();
      setState(() {
        _selectHeaderId = id;
      });
    } else {
      // 更改选中颜色
      setState(() {
        _selectHeaderId = id;
        // 改变排序方式 id-1 在数组中为 0
        _sort = "${_subHeaderList[id-1]["fileds"]}_${_subHeaderList[id-1]["sort"]}";
        // 重置分页数为1
        _page = 1;
        // 清空旧数据列表
        _productList = [];
        // 回到顶部位置
        _scrollController.jumpTo(0);
        // 在价格中拉到最底部 hasMore 为 false，在销量时候就会只请求一页，需要重置
        _hasMore = true;
        // 再次点击，排序方式相反，从降序变为升序
        _subHeaderList[id-1]["sort"] = -_subHeaderList[id-1]["sort"];
        // 重新获取数据
        _getProductListData();
      });
    }
  }

  // 显示 header Icon
  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      return Icon(_selectHeaderId == id ? Icons.arrow_drop_down : Icons.arrow_drop_up);
    } else {
      return const Text("");
    }
  }

  _getProductListData() async {
    // 防止下拉加载请求未完成时候在去第二次重复请求
    setState(() {
      _flag = false;
    });
    // 判断是搜索传入还是分类传入
    var api;
    if (_keywords == null) {
      api = 1;
    } else {
      api = 2;
    }

    var result = <String, dynamic>{};
    var productList = ProductListModel.fromJson(result);
    // 判断是否有搜索的数据：第一页&最后一页数据为0时也造成无数据假象
    if (productList.result.isNotEmpty && _page == 1) {
      setState(() {
        _hasData = true;
      });
    } else {
      setState(() {
        _hasData = false;
      });
    }

    // 判断最后一页有没有数据
    if (productList.result.length < _pageSize) {
      setState(() {
        _productList.addAll(productList.result);
        _hasMore = false;
        // 请求已经完成
        _flag = true;
      });
    } else {
      setState(() {
        _productList.addAll(productList.result);
        _page++;
        _flag = true;
      });
    }
  }

  // 显示加载中
  Widget _showMore(index) {
    if (_hasMore) {
      return (index == _productList.length - 1) ? const LoadingWidget() : const Text("");
    } else {
      return (index == _productList.length - 1) ? const Text("--我是有底线--") : const Text("");
    }
  }

  // 商品列表
  Widget _productListWidget() {
    if (_productList.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(top: ScreenAdaper.height(80)),
        child: ListView.builder(
            itemBuilder: (context, index) {
              String sPic = _productList[index].pic;
              sPic = sPic.replaceAll("\\", "/");
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: ScreenAdaper.width(180),
                        height: ScreenAdaper.height(180),
                        child: Image.network(sPic, fit: BoxFit.cover,),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: ScreenAdaper.width(180),
                          margin: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(_productList[index].title, maxLines: 2, overflow: TextOverflow.ellipsis,),
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: ScreenAdaper.height(36),
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.fromLTRB(233, 233, 233, 0.9),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromRGBO(230, 230, 230, 0.9),
                                    ),
                                    child: const Text("4g"),
                                  ),
                                  Container(
                                    height: ScreenAdaper.height(36),
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.fromLTRB(233, 233, 233, 0.9),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromRGBO(230, 230, 230, 0.9),
                                    ),
                                    child: const Text("126"),
                                  ),
                                ],
                              ),
                              Text(_productList[index].price, style: const TextStyle(color: Colors.red, fontSize: 16),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  _showMore(index),
                ],
              );
            }
        ),
      );
    } else {
      return const LoadingWidget();
    }
  }

  // 筛选导航
  Widget _subHeaderWidget() {
    // 放在下面可以位于最顶层，盖住列表
    // Positioned 不能给 width 为 double.infinity
    return Positioned(
      // 位于顶部
      top: 0,
      width: MediaQuery.of(context).size.width,
      height: ScreenAdaper.height(70),
      child: Container(
        width: double.infinity,
        height: ScreenAdaper.height(80),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black54,
            ),
          ),
        ),
        child: Row(
          // 多个元素从左到右
          children: _subHeaderList.map((e){
            return Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenAdaper.height(20), 0, ScreenAdaper.height(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        e["title"],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: (_selectHeaderId == e["id"] ? Colors.red : Colors.black54)),
                      ),
                      _showIcon(e["id"]),
                    ],
                  ),
                ),
                onTap: () {
                  _subHeaderChange(e["id"]);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var _cid = widget.arguments["cid"];
    _keywords = widget.arguments["keywords"];
    _initKeywordsController.text = _keywords;

    _getProductListData();

    // 监听滚动条滚动事件
    _scrollController.addListener(() {
      // 获取滚动条滚动的高度 pixels
      // 获取页面高度 maxScrollExtent
      // 二者相等表示拉到底部, -20表示距离底部20的时候即下拉加载更多
      // 防止下拉加载请求未完成时候再去第二次重复请求
      // 加载到底部没有更多数据
      if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 20 &&
      _flag == true &&
      _hasMore == true) {
        _getProductListData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // 商品列表页也可以搜索
        title: Container(
          padding: const EdgeInsets.only(bottom: 8),
          height: ScreenAdaper.height(35),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextField(
            controller: _initKeywordsController,
            // 不需要默认选中，键盘弹出
            autofocus: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                // 去掉 TextField 边框
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _keywords = value;
              });
            },
          ),
        ),
        actions: <Widget>[
          InkWell(
            child: SizedBox(
              // height: ScreenAdaper.height(44),
              child: Row(
                children: const <Widget>[
                  Text("搜索", style: TextStyle(fontSize: 16),),
                  SizedBox(width: 15,),
                ],
              ),
            ),
            onTap: () {
              SearchServices.setHistoryData(_keywords);
              _subHeaderChange(1);
            },
          ),
        ],
      ),
      // 加这个会导致没有导航栏没有返回健
      // endDrawer: const Drawer(
      //   child: Text("商品列表"),
      // ),
      body: _hasData ? Stack(
        children: <Widget>[
          _productListWidget(),
          _subHeaderWidget(),
        ],
      ) : const Center(
        child: Text("无搜索结果"),
      ),
    );
  }
}
