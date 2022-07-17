import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_strong/models/product_list_model.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_strong/models/focus_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  // 轮播图 FocusModel
  List<FocusItem> _focusData = [];
  _getFocusData() async {
    // var apiURL = "${Config.domain}api/focus";
    // var result = await Dio().get(apiURL);
    List<dynamic> temp = [];
    var result = {"result": temp};
    // print(result.data is Map); // String 需要 Json 化成 Map
    FocusModel focusModel = FocusModel.fromJson(result);
    setState(() {
      _focusData = focusModel.result;
    });
  }

  // 轮播图
  Widget _swiperWidget() {
    if (_focusData.isNotEmpty) {
      return AspectRatio(
        // 不同设备宽高不同，只能设置为宽高比例
        aspectRatio: 2.0 / 1.0,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            String pic = _focusData[index].pic;
            pic = pic.replaceAll("\\", "/");
            return Image.network(
              pic,
              fit: BoxFit.fill,
            );
          },
          itemCount: _focusData.length,
          pagination: const SwiperPagination(), // 分页器
          autoplay: true, // 自动轮播
        ),
      );
    } else {
      return const Text("加载中...");
    }
  }


  // 标题栏
  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdaper.height(20),
      child: Text(
        value,
        style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      // 左侧红色边框
      decoration: BoxDecoration(
        // color: Colors.lightGreen,
        border: Border(
          left: BorderSide(
              color: Colors.red,
              width: ScreenAdaper.width(5)
          ),
        ),
      ),
      // 左侧边框右移一点
      margin: EdgeInsets.only(left: ScreenAdaper.width(20)),
      // 内部组件之间有间距，好像只对 child 起作用
      padding: EdgeInsets.only(left: ScreenAdaper.width(10)),
      // 对齐方式，左居中对齐
      alignment: Alignment.centerLeft,
    );
  }

  // 水平列表（猜你喜欢）Model
  List<ProductListItemModel> _hotProductListData = [];
  _getHotProductData() async {
    // var apiURL = "${Config.domain}api/plist?is_hot=1";
    // var result = await Dio().get(apiURL);
    List<dynamic> temp = [];
    var result = {"result": temp};
    var hotProductList = ProductListModel.fromJson(result);
    setState(() {
      _hotProductListData = hotProductList.result;
    });
  }

  // 水平列表（猜你喜欢）UI
  Widget _horizontalProductListWidget() {
    if (_hotProductListData.isNotEmpty) {
      // ListView 不能嵌套，需包装在 Container 中，指定宽高实现水平滑动
      return Container(
        // color: Colors.purple,
        height: ScreenAdaper.height(135),
        // 左边第一个元素不能挨边
        padding: EdgeInsets.only(left: ScreenAdaper.width(20), bottom: 0, right: ScreenAdaper.width(0), top: 5),
        child: ListView.builder(
          itemCount: _hotProductListData.length ~/ 2,
          itemBuilder: (context, index) {
            String sPic = _hotProductListData[index].sPic;
            sPic = sPic.replaceAll("\\", "/");
            return Column(
              children: <Widget>[
                Container(
                  // 设置图片的宽高
                  height: ScreenAdaper.height(100),
                  width: ScreenAdaper.width(100),
                  // 设置间距
                  margin: EdgeInsets.only(right: ScreenAdaper.width(10)),
                  child: Image.network(
                    sPic,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  // 这里的 right 保证了底部 Text 和上面的 icon 居中对齐了。
                  padding: EdgeInsets.only(top: ScreenAdaper.height(5),right: ScreenAdaper.width(10)),
                  child: Text(
                      _hotProductListData[index].price,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        // backgroundColor: Colors.lightGreen,
                      )),
                ),
              ],
            );
          },
          // 水平滑动
          scrollDirection: Axis.horizontal,
        ),
      );
    } else {
      return const Text("加载中...");
    }
  }

  // 纵向列表（热门推荐) Model
  List<ProductListItemModel> _bestProductListData = [];
  _getBestProductData() async {
    // var apiURL = "${Config.domain}api/plist?is_best=1";
    // var result = await Dio().get(apiURL);
    List<dynamic> temp = [];
    var result = {"result": temp};
    ProductListModel bp = ProductListModel.fromJson(result);
    setState(() {
      _bestProductListData = bp.result;
    });
  }

  // 纵向列表（热门推荐）UI
  Widget _recProductListWidget() {
    var itemWidth = (ScreenAdaper.getScreenWidth() - 50) * 0.5;
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 20, right: 20),
      // GridView 只能设置宽高比，无法设置 Item 高度
      child: Wrap(
        spacing: 10, // 水平间距（中间的10）
        runSpacing: 10, // 纵向间距（上下的10）
        children: _bestProductListData.map((item){
          String sPic = item.sPic;
          sPic = sPic.replaceAll("\\", "/");
          return InkWell(
            child: Container(
              width: itemWidth,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1.0/1.0,
                      child: Image.network(
                        sPic,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    // 和图片间距 10
                    padding: EdgeInsets.only(top: ScreenAdaper.height(5)),
                    child: Text(
                      item.title,
                      maxLines: 2,
                      // ... 溢出
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold
                        // backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                  Padding(
                    // 和标题间距10
                    padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
                    child: Stack(
                      // 左边原价，右边打折价格
                      children: <Widget>[
                        Align(
                          // 中间偏左
                          alignment: Alignment.centerLeft,
                          child: Text(item.price, style: const TextStyle(color: Colors.red, fontSize: 16),),
                        ),
                        Align(
                          // 中间偏右
                          alignment: Alignment.centerRight,
                          // 下划线
                          child: Text(item.oldPrice, style: const TextStyle(color: Colors.black54, fontSize: 14, decoration: TextDecoration.lineThrough),),
                        ),
                      ],
                  ),
                  ),
                ],
              ),
            ),
            // 跳转到详情页
            onTap: () {
              // print("onTap click");
              Navigator.pushNamed(context, "/productContent", arguments: {
                "id": item.sId,
              });
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 获取轮播图
    _getFocusData();
    // 获取猜你喜欢数据
    _getHotProductData();
    // 获取热门推荐数据
    _getBestProductData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenAdaper.init(context);

    return Scaffold(
      appBar: AppBar(
        // 扫描按钮
        leading: IconButton(
          icon: const Icon(Icons.center_focus_weak, size: 28, color:Colors.black),
          onPressed: () {
            // print("leading");
          },
        ),
        actions: <Widget>[
          IconButton(
              onPressed: (){
                // print("1");
              },
              icon: const Icon(Icons.message, size: 28, color: Colors.black),
          ),
        ],
        title: InkWell(
          // 搜索框支持点击
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
            // print("onTap");
            Navigator.pushNamed(context, "/search");
          },
        ),
      ),
      body: ListView(
        // 支持上下滑动
        children: <Widget>[
          SizedBox(height: ScreenAdaper.height(2),),
          _swiperWidget(),
          SizedBox(height: ScreenAdaper.height(10),),
          _titleWidget("猜你喜欢"),
          SizedBox(height: ScreenAdaper.height(10),),
          _horizontalProductListWidget(),
          _titleWidget("热门推荐"),
          SizedBox(height: ScreenAdaper.height(10),),
          _recProductListWidget(),
        ],
      ),
    );
  }
}
