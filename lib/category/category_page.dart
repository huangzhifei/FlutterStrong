import 'package:flutter/material.dart';
import 'package:flutter_strong/models/cate_model.dart';
import 'package:flutter_strong/config/config.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:dio/dio.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin {
  // 缓存当前页面
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  // 左边选中
  int _selectIndex = 0;

  // 左侧组件 Model
  List<CateItemModel> _leftCateList = [];
  _getLeftCateData() async {
    var api = "${Config.domain}api/pcate";
    var result = await Dio().get(api);
    var leftCate = CateModel.fromJson(result.data);
    setState(() {
      _leftCateList = leftCate.result;
    });

    //请求获得到左侧数据后，在请求默认选中的右侧数据
    _getRightCateData(_leftCateList[0].sId);
  }

  // 左侧组件 UI
  Widget _leftCateWidget(leftWidth) {
    if (_leftCateList.isNotEmpty) {
      return Container(
        // 左边容器固定宽度
        width: leftWidth,
        // 高度自适应屏幕
        height: double.infinity,
        color: Colors.white,
        child: ListView.builder(itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    // 点击切换左侧颜色
                    _selectIndex = index;
                    // 点击切换右侧界面
                    _getRightCateData(_leftCateList[index].pid);
                  });
                },
              ),
              const Divider(height: 1), // 分割线1px
            ],
          );
        }),
      );
    } else {
      return SizedBox(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

  // 右侧组件 Model
  List<CateItemModel> _rightCateList = [];
  _getRightCateData(pid) async {
    var api = "${Config.domain}api/pcate?pid=$pid";
    var result = await Dio().get(api);
    var temp = CateModel.fromJson(result.data);
    setState(() {
      _rightCateList = temp.result;
    });
  }

  // 右侧组件 UI
  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (_rightCateList.isNotEmpty) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: double.infinity,
          color: const Color.fromRGBO(240, 240, 240, 0.9),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // 配置每一行的数量、宽高比、间距
                  crossAxisCount: 3,
                  // item 宽高比，适配不同设备
                  childAspectRatio: rightItemWidth / rightItemWidth,
                  mainAxisExtent: 10,
                  crossAxisSpacing: 10),
              itemCount: _rightCateList.length,
              itemBuilder: (context, index) {
                String sPic = _rightCateList[index].pic;
                sPic = sPic.replaceAll("\\", "/");
                return InkWell(
                  onTap: () {
                    // 跳转传值
                    Navigator.pushNamed(context, "/productList", arguments: {
                      "cid": _rightCateList[index].sId,
                    });
                  },
                  child: Column(
                    children: <Widget>[
                      // 图片
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(sPic, fit: BoxFit.cover),
                      ),
                      // 文本
                      SizedBox(
                        height: ScreenAdaper.height(28),
                        child: Text(_rightCateList[index].title),
                      ),
                    ],
                  ),
                );
              }),
        ),
      );
    } else {
      return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: double.infinity,
          color: const Color.fromRGBO(240, 246, 246, 0.9),
          child: const Text("加载中..."),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLeftCateData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ScreenAdaper.init(context);

    // 计算右侧 GridView 宽高比
    // 左侧宽度 = 屏幕四分之一
    var leftWidth = ScreenAdaper.getScreenWidth() / 4;
    var rightItemWidth = (ScreenAdaper.getScreenWidth() - leftWidth - 20 - 20) / 3;
    rightItemWidth = ScreenAdaper.width(rightItemWidth);
    var rightItemHeight = rightItemWidth + ScreenAdaper.height(28);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.center_focus_weak,
            size: 28,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.message,
              size: 28,
              color: Colors.black,
            ),
          ),
        ],
        title: InkWell(
          child: Container(
            height: ScreenAdaper.height(35),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.search),
                Text("搜索", style: TextStyle(fontSize: ScreenAdaper.fontSize(18)),),
              ],
            ),
          ),
          onTap: () {
            // 跳到搜索页面
            Navigator.pushNamed(context, "/search");
          },
        ),
      ),
      body: Row(
        // 左右两栏，每栏为列
        children: <Widget>[
          _leftCateWidget(leftWidth),
          _rightCateWidget(rightItemWidth, rightItemHeight),
        ],
      ),
    );
  }
}
