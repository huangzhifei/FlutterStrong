import 'package:flutter/material.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter/rendering.dart';

class FSText extends StatelessWidget {

  final String text;
  final bool password;
  final Function(String)? onChanged;
  final int maxLines;
  final double height;
  final TextEditingController? controller;

  const FSText({Key? key,
    this.text = "输入内容",
    this.password = false,
    this.onChanged,
    this.maxLines = 1,
    this.height = 68,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Container(
      height: ScreenAdaper.height(height),

      // 文本框
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        obscureText: password,
        decoration: InputDecoration(
          hintText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          )
        ),
        onChanged: onChanged,
      ),

      // 底部线条
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          )
        )
      ),
    );
  }
}
