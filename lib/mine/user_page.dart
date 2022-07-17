import 'package:flutter/material.dart';
import 'package:flutter_strong/provider/cart_provider.dart';
import 'package:flutter_strong/services/events_bus.dart';
import 'package:flutter_strong/services/screen_adaper.dart';
import 'package:flutter_strong/services/user_services.dart';
import 'package:flutter_strong/uikit/fs_button.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // 判断用户是否登陆
  bool _isLogin = false;
  List _userInfo = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getUserInfo();

    // 监听登陆界面的广播事件
    eventBus.on<UserEvent>().listen((event) {
      print("object " + event.content);
      // 重新获取用户信息，因为子页面返回不会触发 init
      _getUserInfo();
    });
  }

  _getUserInfo() async {
    var isLogin = await UserServices.getUserState();
    var userInfo = await UserServices.getUserInfo();
    setState(() {
      print("refresh " + userInfo.toString() + isLogin.toString());
      _userInfo = userInfo;
      _isLogin = isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 获取通知提供的值，全局按钮
    var counterProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: ScreenAdaper.height(220),
            width: double.infinity,
            // 背景图片
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/beach.jpeg"),
                  fit: BoxFit.cover,
                )),
            child: Row(
              children: <Widget>[
                // 头像
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ClipOval(
                    child: Image.network(
                      "https://cdn-fusionwork.sf-express.com/v1.2/AUTH_FS-BASE-SERVER-PRD-DR/sfosspublic001/mics/2022/04/02/8ae2321350f452505150b4e178859168.png",
                      fit: BoxFit.cover,
                      width: ScreenAdaper.width(100),
                      height: ScreenAdaper.height(86),
                    ),
                  ),
                ),
                _getWidgetOfLogin(),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.assessment, color: Colors.red),
            title: const Text("全部订单"),
            onTap: () {
              Navigator.pushNamed(context, "/order");
            },
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.local_car_wash, color: Colors.orange),
            title: Text("待收货"),
          ),
          Container(
            width: double.infinity,
            height: 10,
            color: const Color.fromRGBO(242, 242, 242, 0.9),
          ),
          const ListTile(
            leading: Icon(Icons.favorite, color: Colors.lightGreen),
            title: Text("我的收藏"),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.people, color: Colors.black54),
            title: Text("在线客服"),
          ),
          const Divider(),
          _isLogin ? FSButton(
            buttonTitle: "退出登陆",
            buttonColor: Colors.red,
            tapEvent: () {
              UserServices.loginOut();
              _getUserInfo();
            },
          ) : const Text(""),
        ],
      ),
    );
  }

  Widget _getWidgetOfLogin() {
    return _isLogin ? Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("用户名: ${_userInfo[0]}",
            style: TextStyle(
                color: Colors.black54,
                fontSize: ScreenAdaper.fontSize(18),
                fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "普通会员",
            style: TextStyle(
                color: Colors.black54,
                fontSize: ScreenAdaper.fontSize(18)
            ),
          ),
        ],
      ),
    ) : Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/login");
        },
        child: Text("登陆/注册",
          style: TextStyle(
              color: Colors.black54,
              fontSize: ScreenAdaper.fontSize(18),
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
