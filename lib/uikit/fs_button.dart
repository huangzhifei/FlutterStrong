import 'package:flutter/material.dart';
import 'package:flutter_strong/services/screen_adaper.dart';

class FSButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonTitle;
  final VoidCallback? tapEvent;
  final double height;

  const FSButton({Key? key,
    this.buttonColor = Colors.black,
    this.buttonTitle = "按钮",
    this.height = 68,
    this.tapEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return InkWell(
      onTap: tapEvent,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        height: ScreenAdaper.height(height),
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonTitle,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
