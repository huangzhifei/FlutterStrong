import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 1;

  Counter() {
    _count = 10;
  }

  int get count => _count;

  initCount() {
    _count ++;
    notifyListeners();
  }
}