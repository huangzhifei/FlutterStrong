import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_strong/provider/checkout_provider.dart';
import 'package:flutter_strong/provider/cart_provider.dart';
import 'package:flutter_strong/routers/router.dart';

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

    // 提供通知
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CheckOutProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],

      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(
          primaryColor: Colors.lightGreen,
          fontFamily: "Rubik-Medium"
        ),
      ),
    );
  }
}

