import 'package:flutter/material.dart';

// 构建一个 List Item
class DemoItem extends StatefulWidget {
  DemoItem({Key? key}) : super(key: key);

  late int index;
  late BuildContext context;

  DemoItem.buildIndex(this.context, this.index, {Key? key}) : super(key: key);

  @override
  State<DemoItem> createState() => _DemoItemState();
}

class _DemoItemState extends State<DemoItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          print("context: ${widget.context}");
          print("index: " + widget.index.toString());
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 0, top: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // 上面文本
              Container(
                padding: const EdgeInsets.only(left: 15.0,),
                child: const Text(
                  "这是⼀点描述",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14.0,
                  ),
                ),
              ),

              const Padding(padding: EdgeInsets.only(bottom: 5.0)),
              // 底部数字和icon
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _getBottomItem(Icons.star, "1000"),
                  _getBottomItem(Icons.link, "12000"),
                  _getBottomItem(Icons.subject, "400"),
                ],
              ),
            ],
          ),
        ),
      ),
      );
  }

  _getBottomItem(IconData icon, String text) {
    // 充满 Row 横向的布局
    return Expanded(
      flex: 1,
      child: Row(
        // 主轴居中,即是横向居中
        mainAxisAlignment: MainAxisAlignment.center,
        // 竖向也居中
        crossAxisAlignment: CrossAxisAlignment.center,
        // ⼤⼩按照最⼤充满
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // ⼀个图标，⼤⼩16.0，绿⾊
          Icon(
            icon,
            size: 16.0,
            color: Colors.green,
          ),
          // 间隔
          const Padding(padding: EdgeInsets.only(left: 5.0,)),
          // 文本
          Text(
            text,
            // 设置字体样式：颜⾊绿⾊，字体⼤⼩14.0
            style: const TextStyle(
              color: Colors.green,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
