import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ProductContentDetailPage extends StatefulWidget {
  final List _productContentList;
  const ProductContentDetailPage(this._productContentList, {Key? key}) : super(key: key);

  @override
  State<ProductContentDetailPage> createState() => _ProductContentDetailPageState();
}

class _ProductContentDetailPageState extends State<ProductContentDetailPage> with AutomaticKeepAliveClientMixin {

  late InAppWebViewController webView;
  late Uri url;
  double progress = 0;
  var _id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _id = widget._productContentList[0].sId;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.https("https://www.baidu.com", "")),
              initialOptions: InAppWebViewGroupOptions(),
              onWebViewCreated: (InAppWebViewController controller){
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, Uri? url){
                setState(() {
                  url = url;
                });
              },
              onLoadStop: (InAppWebViewController controller, Uri? url) async {
                setState(() {
                  url = url;
                });
              },
              onProgressChanged: (InAppWebViewController controller, int progress) {
                setState(() {
                  progress = (progress * 1.0 / 100) as int;
                });
              }
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();
}
