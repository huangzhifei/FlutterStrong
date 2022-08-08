import 'package:flutter/material.dart';
import 'package:flutter_strong/config/config.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/services/fsstorage.dart';
import 'package:flutter_strong/uikit/fs_button.dart';
import 'package:flutter_strong/uikit/fs_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 登陆
  String _password = "";
  String _username = "";

  doLogin() async {
    // 验证手机号码是否正确
    RegExp reg = RegExp(r"^1\d{10}$");
    if (!reg.hasMatch(_username)) {
      Fluttertoast.showToast(msg: "用户名格式不正确", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
    } else if (_password.length < 6) {
      Fluttertoast.showToast(msg: "密码格式  不正确", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
    } else {
      var result = """{"username": "$_username", "password": "$_password"}""";
      FSStorage.setString(kUserInfoKey, result);
      Navigator.pop(context);
    }
  }

  // 从子页面Login回到上级页面User，不会刷新User
  // 监听登陆页面销毁的事件
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    // 广播：登陆页面退出的时候，通知用户中心刷新页面
    eventBus.fire(UserEvent("登陆成功..."));
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("客服"),
          ),
        ],
      ),

      // ListView：当键盘放不下的时候可以滑动页面
      body: Container(
        padding: EdgeInsets.all(ScreenAdaper.width(20)),
        child: ListView(
          children: <Widget>[
            // 方框图
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                height: ScreenAdaper.height(160),
                width: ScreenAdaper.width(160),
                child: Image.network(
                  "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            FSText(
              text: "请输入用户名",
              onChanged: (value) {
                _username = value;
              },
            ),

            const SizedBox(
              height: 10,
            ),

            FSText(
              text: "请输入密码",
              onChanged: (value) {
                _password = value;
              },
            ),

            const SizedBox(
              height: 20,
            ),

            // 登陆按钮
            FSButton(buttonColor: Colors.red, buttonTitle: "登录", height: 44, tapEvent: doLogin),
          ],
        ),
      ),
    );
  }
}
