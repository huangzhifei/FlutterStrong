import 'package:flutter/material.dart';

class ProductContentRatePage extends StatefulWidget {
  const ProductContentRatePage({Key? key}) : super(key: key);

  @override
  State<ProductContentRatePage> createState() => _ProductContentRatePageState();
}

class _ProductContentRatePageState extends State<ProductContentRatePage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("第$index条数据"),
        );
      },
    );
  }
}
