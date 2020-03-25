import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:kacinvest/Tab/calculator_tab.dart';
import 'package:kacinvest/Tab/profile.dart';
import 'package:kacinvest/pages/login_screen.dart';
import 'package:kacinvest/screens/first_tab.dart';
import 'package:kacinvest/screens/account.dart';
import 'package:kacinvest/pages/main_page.dart';
import 'package:kacinvest/Tab/home_tab.dart';
import 'package:kacinvest/Tab/market_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util.dart';

class App extends StatefulWidget {
  App({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<App> {
  int _currentIndex = 0;
  PageController _pageController;

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

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('username');
    return stringValue;
  }

  Logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');

    var route = new MaterialPageRoute(
        builder: (BuildContext context) =>
            //new App(idUser: data[0]['user_id'],firstname: data[0]['first_name'],lastname: data[0]['last_name'],username: data[0]['username'],),
            new LoginScreen());
    Navigator.of(context).pushReplacement(route);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        Scaffold(
          //appBar: AppBar(title: Text("Nav Bar")),
          appBar: _mainAppBar(),
          //backgroundColor: PaypalColors.LightOrange,
          body: DoubleBackToCloseApp(
            child: SizedBox.expand(
              child: buildPageView(),
            ),
            snackBar: const SnackBar(
              duration: Duration(seconds: 1),
              content: Text('Tap back again to leave'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
          ),

          bottomNavigationBar: BottomNavyBar(
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              bottomTapped(index);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                  activeColor: PaypalColors.Orange,
                  inactiveColor: PaypalColors.Black50,
                  title: Text('Home'),
                  icon: Icon(Icons.home)),
              BottomNavyBarItem(
                  activeColor: PaypalColors.Orange,
                  inactiveColor: PaypalColors.Black50,
                  title: Text('Market'),
                  icon: Icon(Icons.shopping_cart)),
              BottomNavyBarItem(
                  activeColor: PaypalColors.Orange,
                  inactiveColor: PaypalColors.Black50,
                  title: Text('My Investation'),
                  icon: Icon(Icons.attach_money)),
              BottomNavyBarItem(
                  activeColor: PaypalColors.Orange,
                  inactiveColor: PaypalColors.Black50,
                  title: Text('Calculator'),
                  icon: Icon(Icons.show_chart)),
              BottomNavyBarItem(
                  activeColor: PaypalColors.Orange,
                  inactiveColor: PaypalColors.Black50,
                  title: Text('Account'),
                  icon: Icon(Icons.account_circle)),
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
      actions: <Widget>[
        /*Image.asset(
          'assets/images/icon_school-bell.png',
          color: PaypalColors.Orange,
        )*/
        new IconButton(
          icon: new Icon(Icons.cancel),
          color: PaypalColors.Orange,
          onPressed: () {
            Logout();
          },
        ),
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
      children: <Widget>[
        HomeTab(),
        MarketTab(),
        MyInvestment(),
        CalculatorTab(),
        Profile(),
      ],
    );
  }
}
