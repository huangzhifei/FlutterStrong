
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 封装静态宽、高方法，直接通过类名称来访问
class ScreenAdaper {
  // 解决 Flutter 不同终端屏幕适配问题
  static init(BuildContext context) {
    ScreenUtil.init(context);
  }

  static height(double value) {
    return ScreenUtil().setHeight(value);
  }

  static width(double value) {
    return ScreenUtil().setWidth(value);
  }

  static getScreenHeight() {
    return ScreenUtil().screenHeight;
  }

  static getScreenWidth() {
    return ScreenUtil().screenWidth;
  }

  static fontSize(double value) {
    return ScreenUtil().setSp(value);
  }

}