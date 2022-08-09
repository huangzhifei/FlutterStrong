import 'package:flutter/material.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter/rendering.dart';

class FSText extends StatefulWidget {
  final String text;
  final bool password;
  final Function(String)? onChanged;
  final int maxLines;
  final double height;
  final TextEditingController? controller;

  const FSText({
    Key? key,
    this.text = "输入内容",
    this.password = false,
    this.onChanged,
    this.maxLines = 1,
    this.height = 68,
    this.controller,
  }) : super(key: key);
  // const FSText({Key? key}) : super(key: key);

  @override
  State<FSText> createState() => _FSTextState();
}

class _FSTextState extends State<FSText> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.controller != null) {
      // 不加这段代码，一输入光标就跑到最前面去
      // widget.controller!.addListener(() {
      //   print("addListener");
      //   final String str = widget.controller!.text;
      //   widget.controller!.value = widget.controller!.value.copyWith(
      //     text: str,
      //     selection: TextSelection(baseOffset: str.length, extentOffset: str.length),
      //     composing: TextRange.empty,
      //   );
      // });
    }
  }

  @override
  void dispose() {
    if (widget.controller != null) {
      widget.controller!.dispose();
    }
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Container(
      height: ScreenAdaper.height(widget.height),

      // 文本框
      child: TextField(
        autofocus: true,
        controller: widget.controller,
        maxLines: widget.maxLines,
        obscureText: widget.password,
        decoration: InputDecoration(
            hintText: widget.text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            )),
        onChanged: widget.onChanged,
      ),

      // 底部线条
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 1,
        color: Colors.black12,
      ))),
    );
  }
}
