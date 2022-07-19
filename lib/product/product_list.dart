import 'package:flutter/material.dart';
import 'package:flutter_strong/uikit/fs_loading_widget.dart';

class ProductListPage extends StatefulWidget {
  // 上个页面传入 arguments 参数
  Map? arguments;
  ProductListPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  bool _hasData = true;
  var _cid;
  var _keywords;

  var _initKeywordsController = TextEditingController();

  // 二级导航数据
  List _subHeaderList = [
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
  ScrollController _scrollController = ScrollController();
  bool _flag = true;
  // 每页有多少条数据
  int _pageSize = 8;
  // 是否有数据
  bool _hasMore = true;
  String _sort = "";
  List _productList = [];

  int _page = 1;
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
        _sort = "";
        _page = 1;
        _productList = [];
        _scrollController.jumpTo(0);
        _hasMore = true;
        _subHeaderList[id-1]["sort"] = -_subHeaderList[id-1]["sort"];
        // 重新获取数据
        _getProductListData();
      });
    }
  }

  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      return Icon(_selectHeaderId == id ? Icons.arrow_drop_down : Icons.arrow_drop_up);
    } else {
      return const Text("");
    }
  }

  _getProductListData() async {

  }

  // 显示加载中
  Widget _showMore(index) {
    if (_hasMore) {
      return (index == _productList.length - 1) ? const LoadingWidget() : const Text("");
    } else {
      return (index == _productList.length - 1) ? const Text("--我是有底线--") : const Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
