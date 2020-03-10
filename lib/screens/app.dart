import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:kacinvest/Tab/calculator_tab.dart';
import 'package:kacinvest/Tab/profile.dart';
import 'package:kacinvest/screens/first_tab.dart';
import 'package:kacinvest/screens/account.dart';
import 'package:kacinvest/pages/main_page.dart';
import 'package:kacinvest/Tab/home_tab.dart';
import 'package:kacinvest/Tab/market_tab.dart';

import '../util.dart';


class App extends StatefulWidget {
  App({
    Key key,
    this.title
  }): super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State < App > {
  int _currentIndex = 0;
  PageController _pageController;

  var height = CardData.height;
  var topPositioned = CardData.topPositioned;
  var width = CardData.width;
  var showBackOfCard = CardData.showBackOfCard;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void pageChanged(int index) {
    setState(() {
      this._currentIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      this._currentIndex = index;
      _pageController.animateToPage(index,
        duration: Duration(milliseconds: 1000), curve: Curves.ease);
  });
  }

  void creditcardTapped(int index) {
    setState(() {
      this._currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: < Widget > [
        Scaffold(
          //appBar: AppBar(title: Text("Nav Bar")),
          appBar: _mainAppBar(),
          //backgroundColor: PaypalColors.LightOrange,
          body: SizedBox.expand(
            child: buildPageView(),
          ),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              bottomTapped(index);
            },
            items: < BottomNavyBarItem > [
              BottomNavyBarItem(activeColor: PaypalColors.Orange, inactiveColor: PaypalColors.Black50,
                title: Text('Home'), icon: Icon(Icons.home)),
              BottomNavyBarItem(activeColor: PaypalColors.Orange, inactiveColor: PaypalColors.Black50,
                title: Text('Market'), icon: Icon(Icons.shopping_cart)),
              BottomNavyBarItem( activeColor: PaypalColors.Orange, inactiveColor: PaypalColors.Black50,
                title: Text('My Investation'), icon: Icon(Icons.attach_money)),
              BottomNavyBarItem( activeColor: PaypalColors.Orange,inactiveColor: PaypalColors.Black50,
                title: Text('Calculator'), icon: Icon(Icons.show_chart)),
              BottomNavyBarItem( activeColor: PaypalColors.Orange,inactiveColor: PaypalColors.Black50,
                title: Text('Account'), icon: Icon(Icons.account_circle)),
            ],
          ),
        ),
      ],
    );
  }

  AppBar _mainAppBar() {
    return AppBar(
      leading: Image.asset(
        'assets/images/icon_settings.png',
        color: PaypalColors.Orange,
      ),
      title: Image.asset('assets/images/Paypal-logo-header.png', height: 25),
      centerTitle: true,
      actions: < Widget > [
        Image.asset('assets/images/icon_school-bell.png', color: PaypalColors.Orange,)
      ],
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  Widget buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: < Widget > [
        HomeTab(),
        MarketTab(),
        MyInvestment(),
        CalculatorTab(),
        Profile(),
      ],
    );
  }
}