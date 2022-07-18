import 'package:flutter/material.dart';
import 'package:flutter_strong/models/cate_model.dart';
import 'package:flutter_strong/services/screen_adaper.dart';

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
    // var api = "${Config.domain}api/pcate";
    // var result = await Dio().get(api);
    List<dynamic> temp = [];
    var result = {"result": temp};
    var leftCate = CateModel.fromJson(result, 1);
    setState(() {
      _leftCateList = leftCate.result;
    });

    //请求获得到左侧数据后，在请求默认选中的右侧数据
    _getRightCateData(_leftCateList[0].sId);
  }

  // 左侧组件 UI
  Widget _leftCateWidget(leftWidth) {
    if (_leftCateList.isNotEmpty) {
      return SizedBox(
        // 左边容器固定宽度
        width: leftWidth,
        // 高度自适应屏幕
        height: double.infinity,
        // color: Colors.green,
        child: ListView.builder(
          itemBuilder: (context, index) {
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
                  child: Container(
                    // 文本框设置背景颜色宽高等
                    child: Text(
                      _leftCateList[index].title,
                      textAlign: TextAlign.center,
                    ),
                    width: double.infinity,
                    height: ScreenAdaper.height(64),
                    padding: EdgeInsets.only(top: ScreenAdaper.height(24)),
                    color: _selectIndex == index ? const Color.fromRGBO(240, 240, 240, 0.9) : Colors.white,
                  ),
                ),
                const Divider(height: 1), // 分割线1px
              ],
            );
          },
          itemCount: _leftCateList.length,
        ),
      );
    } else {
      return SizedBox(
        width: leftWidth,
        height: double.infinity,
        child: const DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
        ),
      );
    }
  }

  // 右侧组件 Model
  List<CateItemModel> _rightCateList = [];
  _getRightCateData(pid) async {
    // var api = "${Config.domain}api/pcate?pid=$pid";
    // var result = await Dio().get(api);
    List<dynamic> temp = [];
    var result = {"result": temp};
    var reTemp = CateModel.fromJson(result, 2);
    setState(() {
      _rightCateList = reTemp.result;
    });
  }

  // 右侧组件 UI
  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (_rightCateList.isNotEmpty) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: double.infinity,
          color: const Color.fromRGBO(240, 240, 240, 0.9),
          // color: Colors.lightGreen,
          child: GridView.builder(
              shrinkWrap: true,
              // 动态网格布局
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // 配置每一行的数量、宽高比、间距
                  crossAxisCount: 3,
                  // item 宽高比，适配不同设备
                  childAspectRatio: rightItemWidth / rightItemHeight,
                  mainAxisSpacing: 10,
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
                          height: ScreenAdaper.height(25),
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
          // 扫描按钮
          icon: const Icon(
            Icons.center_focus_weak,
            size: 28,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          // 消息按钮
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
                Text(
                  "搜索",
                  style: TextStyle(fontSize: ScreenAdaper.fontSize(18)),
                ),
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
