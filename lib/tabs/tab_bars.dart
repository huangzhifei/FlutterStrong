import 'package:flutter/material.dart';
import 'package:flutter_strong/home/home_page.dart';
import 'package:flutter_strong/category/category_page.dart';

class TabBars extends StatefulWidget {
  const TabBars({Key? key}) : super(key: key);

  @override
  State<TabBars> createState() => _TabBarsState();
}

class _TabBarsState extends State<TabBars> {

  int _currentIndex = 0;

  final List<Widget> _pageList = [
    const HomePageWidget(),
    const CategoryPage(),
  ];

  late final PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pageList,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // 实现页面切换
            _pageController.jumpToPage(_currentIndex);
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.purple,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "首页",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "分类",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "购物车",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "我的",
          ),
        ],
      ),
    );
  }
}
