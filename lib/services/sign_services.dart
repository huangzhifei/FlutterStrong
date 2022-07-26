import 'dart:convert';
import 'package:crypto/crypto.dart';

class SignServices {
  static getSign(json) {
    List attrKeys = json.keys.toList();
    attrKeys.sort();

    String str = "";
    for (var item in attrKeys) {
      str += "$item${json[item]}";
    }

    return md5.convert(utf8.encode(str)).toString();
  }

}