import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:kacinvest/Tab/calculator_tab.dart';
import 'package:kacinvest/Tab/profile.dart';
import 'package:kacinvest/Tab/shop_tab.dart';
import 'package:kacinvest/Tab/sidebar.dart';
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
          appBar: PreferredSize(
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(0, 1.0),
                  blurRadius: 10.0,
                )
              ]),
              child: _mainAppBar(),
            ),
            preferredSize: Size.fromHeight(kToolbarHeight),
          ),
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
      backgroundColor: Colors.white,
      elevation: 10.0,
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
        //MenuDashboardPage(),
        ShopTab(),
        //OtpScreen(),
        //MarketTab(),
        MyInvestment(),
        CalculatorTab(),
        Profile(),
      ],
    );
  }
}

final Color backgroundColor = Color(0xFF4A4A58);

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  PageController _pageController;

  /* @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }*/

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

  //---------------------------------------------------------------------
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard2(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset('assets/images/PayPal-logo.png', width: 150),
                Text("Published 2020",
                    style: TextStyle(color: Colors.orange, fontSize: 12, fontFamily: 'Montserrat')),
                    SizedBox(height: 100),
                Text("Settings",
                    style: TextStyle(color: Colors.orange, fontSize: 22, fontFamily: 'Montserrat')),
                SizedBox(height: 10),
                Text("About Us",
                    style: TextStyle(color: Colors.orange, fontSize: 22, fontFamily: 'Montserrat')),
                SizedBox(height: 10),
                Text("Logout",
                    style: TextStyle(color: Colors.orange, fontSize: 22, fontFamily: 'Montserrat')),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPageView() {
    return PageView(
      physics:new NeverScrollableScrollPhysics(),
      controller: _pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomeTab(),
        //MenuDashboardPage(),
        ShopTab(),
        //OtpScreen(),
        //MarketTab(),
        MyInvestment(),
        CalculatorTab(),
        Profile(),
      ],
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          //borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 48, bottom: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Icon(Icons.menu, color: Colors.white),
                          onTap: () {
                            setState(() {
                              if (isCollapsed)
                                _controller.forward();
                              else
                                _controller.reverse();

                              isCollapsed = !isCollapsed;
                            });
                          },
                        ),
                        Image.asset('assets/images/Paypal-logo-header.png',
                            height: 25),
                        //Text("My Cards", style: TextStyle(fontSize: 24, color: Colors.white)),
                        Icon(Icons.settings, color: Colors.white),
                      ],
                    ),
                  ),
                  Container(
                    width: 400,
                    height: 900,
                    child: SizedBox.expand(
                      child: buildPageView(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard2(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.4 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: PageView(
      children: <Widget>[
        Scaffold(
          //appBar: AppBar(title: Text("Nav Bar")),
          appBar: PreferredSize(
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(0, 1.0),
                  blurRadius: 10.0,
                )
              ]),
              child: _mainAppBar(),
            ),
            preferredSize: Size.fromHeight(kToolbarHeight),
          ),
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
    ),
        ),
      ),
    );
  
  }

  AppBar _mainAppBar() {
    return AppBar(
      leading: IconButton(
          icon: new Icon(Icons.settings),
          color: PaypalColors.Orange,
          onPressed: () {
            //Logout();
                                        setState(() {
                              if (isCollapsed)
                                _controller.forward();
                              else
                                _controller.reverse();

                              isCollapsed = !isCollapsed;
                            });
          },
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
      backgroundColor: Colors.white,
      elevation: 10.0,
    );
  }
}

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<String> currentPin = ["", "", "", ""];
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.transparent),
  );

  int pinIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          buildExitButton(),
          Expanded(
            child: Container(
              alignment: Alignment(0, 0.5),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  buildSecurityText(),
                  SizedBox(height: 40.0),
                  buildPinRow(),
                ],
              ),
            ),
          ),
          buildNumberPad(),
        ],
      ),
    );
  }

  buildNumberPad() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    KeyboardNumber(
                      n: 1,
                      onPressed: () {
                        pinIndexSetup("1");
                      },
                    ),
                    KeyboardNumber(
                      n: 2,
                      onPressed: () {
                        pinIndexSetup("2");
                      },
                    ),
                    KeyboardNumber(
                      n: 3,
                      onPressed: () {
                        pinIndexSetup("3");
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    KeyboardNumber(
                      n: 4,
                      onPressed: () {
                        pinIndexSetup("4");
                      },
                    ),
                    KeyboardNumber(
                      n: 5,
                      onPressed: () {
                        pinIndexSetup("5");
                      },
                    ),
                    KeyboardNumber(
                      n: 6,
                      onPressed: () {
                        pinIndexSetup("6");
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    KeyboardNumber(
                      n: 7,
                      onPressed: () {
                        pinIndexSetup("7");
                      },
                    ),
                    KeyboardNumber(
                      n: 8,
                      onPressed: () {
                        pinIndexSetup("8");
                      },
                    ),
                    KeyboardNumber(
                      n: 9,
                      onPressed: () {
                        pinIndexSetup("9");
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 60.0,
                      child: MaterialButton(
                        onPressed: null,
                        child: SizedBox(),
                      ),
                    ),
                    KeyboardNumber(
                      n: 0,
                      onPressed: () {
                        pinIndexSetup("0");
                      },
                    ),
                    Container(
                      width: 60.0,
                      child: MaterialButton(
                        height: 60.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        onPressed: () {
                          clearPin();
                        },
                        child: Icon(
                          Icons.backspace,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }

  clearPin() {
    if (pinIndex == 0)
      pinIndex = 0;
    else if (pinIndex == 4) {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    } else {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    }
  }

  pinIndexSetup(String text) async {
    if (pinIndex == 0)
      pinIndex = 1;
    else if (pinIndex < 4) pinIndex++;
    setPin(pinIndex, text);
    currentPin[pinIndex - 1] = text;
    String strPin = "";
    currentPin.forEach((e) {
      strPin += e;
    });
    if (pinIndex == 4) {
      print(strPin);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var otp = prefs.getString('OTP');

      if (strPin == otp) {
        var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
                //new App(idUser: data[0]['user_id'],firstname: data[0]['first_name'],lastname: data[0]['last_name'],username: data[0]['username'],),
                //new App());
                new MenuDashboardPage());
        Navigator.of(context).pushReplacement(route);
      }
    }
  }

  setPin(int n, String text) {
    switch (n) {
      case 1:
        pinOneController.text = text;
        break;
      case 2:
        pinTwoController.text = text;
        break;
      case 3:
        pinThreeController.text = text;
        break;
      case 4:
        pinFourController.text = text;
        break;
    }
  }

  buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinOneController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinTwoController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinThreeController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinFourController,
        ),
      ],
    );
  }

  buildSecurityText() {
    return Text(
      "Security PIN",
      style: TextStyle(
        color: Colors.white,
        fontSize: 21.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  buildExitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () {},
            height: 50.0,
            minWidth: 50.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class PINNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;
  PINNumber({this.textEditingController, this.outlineInputBorder});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          border: outlineInputBorder,
          filled: true,
          fillColor: Colors.white30,
        ),
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 21.0, color: Colors.white),
      ),
    );
  }
}

class KeyboardNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;
  KeyboardNumber({this.n, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.1),
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: EdgeInsets.all(8.0),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        height: 90.0,
        child: Text(
          "$n",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24 * MediaQuery.of(context).textScaleFactor,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class OTPScreenCheck extends StatefulWidget {
  @override
  _OTPScreenCheckState createState() => _OTPScreenCheckState();
}

class _OTPScreenCheckState extends State<OTPScreenCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.deepOrangeAccent,
            Colors.deepOrange,
          ],
          begin: Alignment.topRight,
        )),
        child: OtpScreen(),
      ),
    );
  }
}
