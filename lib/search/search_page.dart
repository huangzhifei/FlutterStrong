import 'package:flutter/material.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/services/search_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // 删除提示
  _showAlertDialog(keywords) async {
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("提示信息！"),
          content: const Text("确定要删除吗？"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text("取消")),
            TextButton(
              child: const Text("确定"),
              onPressed: () async {
                // 异步，长按删除某条历史记录
                await SearchServices.removeHistoryData(keywords);

                Navigator.pop(context, "OK");
              },
            ),
          ],
        );
      },
    );
  }

  // 用户输入的值
  var _keywords = "";
  // 热搜数据
  final List _hotSearchListData = ["女装", "笔记本", "手机", "旅游背包", "冬季毛衣", "帆布鞋", "饭盒"];
  Widget _hotSearchList() {
    if (_hotSearchListData.isNotEmpty) {
      List<Widget> hotWidgets = _hotSearchListData.map((e) {
        return InkWell(
          child: Container(
            // 用户搜索的长度不一样，根据文字来，不能给 Container 设置长度
            // 内边距
            padding: const EdgeInsets.all(10),
            // 外边距
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              // 圆角
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(233, 233, 233, 0.8),
            ),
            child: Text(e),
          ),
          onTap: () {
            _keywords = e;
            // 保持历史搜索记录
            SearchServices.setHistoryData(_keywords);

            // 跳转到商品列表页面，传入搜索值
            // 商品列表直接返回到首页，而不是搜索页面
            Navigator.pushReplacementNamed(context, "/productList", arguments: {"keywords": _keywords});
          },
        );
      }).toList();

      return Wrap(
        // 内容超出的可换行
        children: hotWidgets,
      );
    } else {
      return const Text("");
    }
  }

  // 获取历史搜索记录列表 Model
  List _historyListData = [];
  _getHistoryListData() async {
    var historyListData = await SearchServices.getHistoryData();
    setState(() {
      _historyListData = historyListData;
    });
  }

  // 获取历史搜索记录列表 UI
  Widget _historyListWidget() {
    if (_historyListData.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "历史记录",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Divider(),
          Column(
            children: _historyListData.map((value) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text("$value"),
                    onLongPress: () {
                      _showAlertDialog(value);
                    },
                    onTap: () {
                      _keywords = value;
                      SearchServices.setHistoryData(_keywords);
                      Navigator.pushReplacementNamed(context, "/productList", arguments: {"keywords": _keywords});
                    },
                  ),
                  const Divider(),
                ],
              );
            }).toList(),
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            // 清空历史记录按钮居中
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                // 点击按钮
                child: Container(
                  width: ScreenAdaper.width(400),
                  height: ScreenAdaper.height(64),
                  decoration: BoxDecoration(
                    // 边框
                    border: Border.all(color: Colors.black54, width: 1),
                  ),
                  child: Row(
                    // 左删除图标，右清空按钮
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[Icon(Icons.delete), Text("清空历史记录")],
                  ),
                ),
                onTap: () {
                  // 清空本地缓存历史记录
                  SearchServices.clearHistoryList();
                  // 重新渲染页面
                  _getHistoryListData();
                },
              ),
            ],
          ),
        ],
      );
    } else {
      return const Text("");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 获取历史记录数据
    _getHistoryListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: ScreenAdaper.height(60),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.only(bottom: 10),
          child: TextField(
            // 进来默认选中，键盘弹出
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                // 去掉 TextField 边框
                borderSide: BorderSide.none,
                // 圆角和外层一样
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onChanged: (value) {
              // 获得输入的内容
              _keywords = value;
            },
          ),
        ),
        actions: <Widget>[
          // 点击搜索按钮
          InkWell(
            child: SizedBox(
              height: ScreenAdaper.height(70),
              width: ScreenAdaper.width(80),
              child: Row(
                children: const <Widget>[
                  Text("搜索"),
                ],
              ),
            ),
            onTap: () {
              // 保持历史搜索记录
              SearchServices.setHistoryData(_keywords);

              // 跳转到商品列表页面，传入搜索
              // 商品列表直接返回到首页，而不是搜索页面
              Navigator.pushReplacementNamed(context, "/productList", arguments: {"keywords": _keywords});
            },
          ),
        ],
      ),
      body: Padding(
        // 四周间距
        padding: const EdgeInsets.all(10),
        child: ListView(
          // 当搜索记录过多时候，支持下拉
          children: <Widget>[
            Text(
              "热搜",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const Divider(),
            // 热搜
            _hotSearchList(),
            // 添加间距
            const SizedBox(
              height: 10,
            ),
            // 历史记录列表
            _historyListWidget(),
          ],
        ),
      ),
    );
  }
}
