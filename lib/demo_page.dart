import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_strong/demo_item.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FlutterStrong"),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return const DemoItem();
          }
      ),
      backgroundColor: Colors.lightGreen,
    );
  }
}
