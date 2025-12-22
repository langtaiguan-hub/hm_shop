import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 定义数据。根据数据进行渲染
  final List<Map<String, String>> _tabList = [
    {
      'icon': "lib/assets/tab/home.png",
      'selectedIcon': "lib/assets/tab/home_0.png",
      'label': '主页',
    },
    {
      'icon': "lib/assets/tab/order.png",
      'selectedIcon': "lib/assets/tab/order_0.png",
      'label': '分类',
    },
    {
      'icon': "lib/assets/tab/select_3.png",
      'selectedIcon': "lib/assets/tab/select_2.png",
      'label': '购物车',
    },
    {
      'icon': "lib/assets/tab/user.png",
      'selectedIcon': "lib/assets/tab/user_1.png",
      'label': '我的',
    },
  ];
  int _currentIndex = 0;
  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('主页'),
      // ),
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getChildren()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.red,
        selectedFontSize: 12,
        showSelectedLabels: true,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        items: _tabList
            .map(
              (item) => BottomNavigationBarItem(
                icon: Image.asset(
                  item['icon'] as String,
                  width: 30,
                  height: 30,
                ),
                label: item['label'] as String,
                activeIcon: Image.asset(
                  item['selectedIcon'] as String,
                  width: 30,
                  height: 30,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
