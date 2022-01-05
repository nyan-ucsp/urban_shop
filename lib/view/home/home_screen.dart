import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urban_shop/components/urban_icon.dart';
import 'package:urban_shop/view/home/dashobard_view.dart';
import 'package:urban_shop/view/home/shop_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _homeView = [const DashboardView(), const ShopView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: _pageController,
        children: _homeView,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(UrbanIcons.shop),
            label: "Shop",
          ),
        ],
      ),
    );
  }
}
