import 'package:flutter/material.dart';
import 'package:flutter_strong/demo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // 在 main 函数中,运行的组件的根组件必须是 MaterialApp
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Rubik-Regular',
      ),
      home: DemoPage(),
    );
  }
}

