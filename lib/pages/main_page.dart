import 'dart:convert';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kacinvest/Tab/home_tab.dart';
import 'package:kacinvest/Tab/shop_tab%20copy.dart';
import 'package:kacinvest/screens/app.dart';
import 'package:kacinvest/util.dart';
import 'shop_items_page.dart';
import '../custom_icon/spin_icons.dart';
import '../custom_icon/kacinvest_icon_icons.dart';
import 'package:kacinvest/StockCard/awesome_card.dart';
import 'dart:math' as math;
import 'dart:ui';
import 'package:http/http.dart' as http;

class MyInvestment extends StatefulWidget {
  @override
  _MyInvestmentState createState() => _MyInvestmentState();
  static var chartss = _MyInvestmentState.chartss;
  static var charts = _MyInvestmentState.charts22;
  static var charts2 = _MyInvestmentState.charts2;
}

class _MyInvestmentState extends State<MyInvestment> {
  static var charts2 =MenuDashboardPage.charts;
  static var charts22 =MenuDashboardPage.charts2;
  //static var charts23 =MenuDashboardPage.chartsss3;
  static List<List<double>> charts = [
    [
      1.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      5.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4
    ],
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
    ],
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4
    ]
  ];

  var _isLoading = false;

  static final List<String> chartDropdownItems = [
    'Last 7 days',
    'Last month',
    'Last year'
  ];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;
  var chart;
  static List<double> chartss = [];
  var data = [0.0, 1.0, 10.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  var percentage = HomeTab.returnbalance / HomeTab.currentbalancestart * 100;
  var balance = HomeTab.balance;
  var stock = MenuDashboardPage.dataa;
  var tmpchat = MenuDashboardPage.charttemp2;


  chartModel() async {
    final url = "http://kacinvest.arkeyproject.com/try/ViewReturn.php";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final profiles = json.decode(response.body);

      setState(() {
        chart = profiles;
        print(chart);
        print(chart.length);
        chartss.clear();
        int i = 0;
        while (i < chart.length) {
          double j = double.parse(chart[i]['PriceNAB_after']);
          chartss.add(j);

          i++;
        }
        ;
        print(chartss);
        print(chartss.length);
        _isLoading = true;
        data = chartss;
      });
    }
  }

  //-----------------------------------------
  var charttemp;
  static List<double> chartss2 = [];
  static List<List<double>> chartsss2 = [];

  chartModel2() async {
    int j = 0;
    while (j < stock.length) {
      var stockid = stock[j]['stockID'];
      final url =
          "http://kacinvest.arkeyproject.com/try/ViewReturn.php?stockid=${stockid}";
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final profiles = json.decode(response.body);

        setState(() {
          chart = profiles;
          print(chart);
          print(chart.length);
          chartss2.clear();
          int i = 0;
          while (i < chart.length) {
            double j = double.parse(chart[i]['PriceNAB_after']);
            chartss2.add(j);

            i++;
          }
          ;
        });
      }
      setState(() {
        //chartsss2[j] = chartss2;
        chartsss2.add(chartss2);
        print(chartsss2);
        print(chartsss2.length);
        //_isLoading = true;
        //data = chartss;
      });
      j++;
    }
  }
//------------------------------------------------------------------

  //-----------------------------------------
  var charttemp2;
  var charttemp23;
  static List<double> chartss3 = [2, 2, 2, 3];
  static List<double> chartss4 = [2, 252, 3];
  static List<List<double>> chartsss3 = [];

  static List<double> doubletemp = [];

  chartModel3() async {
    chartsss3.clear();
    
    int i = 0;

    while (i < stock.length) {

      var stockid = stock[i]['stockID'];
      final url =
          "http://kacinvest.arkeyproject.com/try/ViewReturn.php?stockid=${stockid}";
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final profiles = json.decode(response.body);

        charttemp2 = profiles;
      }

for (var i = 0; i < charttemp2.length; i++) {
  double x = double.parse(charttemp2[i]['PriceNAB_after']);
        doubletemp.add(x);
}
      /*int j = 0;
      while (j < charttemp2.length) {
        double x = double.parse(chart[j]['PriceNAB_after']);
        doubletemp.add(x);
        j++;
      };*/

      chartsss2.add(doubletemp);

      //     chartsss3.add(chartss3);
      //     chartsss3.add(chartss4);
      //print(chartsss2);
      //print(chartsss2.length);
      //charttemp23.add(charttemp2);
      //charttemp23= charttemp2.take(3).toList();
      i++;
    }
  }
//------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    //chartModel();
    //chartModel2();
    //chartModel3();
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PaypalColors.Orange,
      body: Container(
        height: _media.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _balance(_media),
              Text('${charts2}'),
              Text('${tmpchat}'),
              /*Sparkline(
                  //data: chartsss[cardIndex],
                  data: charts22,
                  lineWidth: 5.0,
                  pointsMode: PointsMode.last,
                  pointSize: 6.0,
                  pointColor: Colors.blueGrey,
                  fillMode: FillMode.below,
                  fillColor: Colors.lightGreen,
                  lineColor: Colors.lightGreen,
                ),
                Sparkline(
                  //data: chartsss[cardIndex],
                  data: charts2[0],
                  lineWidth: 5.0,
                  pointsMode: PointsMode.last,
                  pointSize: 6.0,
                  pointColor: Colors.blueGrey,
                  fillMode: FillMode.below,
                  fillColor: Colors.lightGreen,
                  lineColor: Colors.lightGreen,
                ),*/
              //Text('${chartsss3}'),
              //Text('${chartsss3.length}'),
              _invest(),

              /*StockCard(),
              SlidingCardsView(),
              
              HomeScreenBottomPart(),*/
            ],
          ),
        ),
      ),
    );
  }

  getBalance() async {
    var response = await http.get(
        "http://kacinvest.arkeyproject.com/try/Balance.php?username=rakadprakoso");
    return jsonDecode(response.body);
  }

  FutureBuilder balanceList() {
    return FutureBuilder(
      future: getBalance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          var balance = snapshot.data;
          // tampilkan dvarata
          return ListView.builder(
            itemCount: balance.length,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return FadeAnimation(1.5, StockCard(bal: balance, index:index));
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        //shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }

  Widget _balance(_media) {
    return Container(
      height: _media.height * 0.3,
      decoration: BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('Return',
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Montserrat',
                        fontSize: 13.0,
                      )),
                  Text(percentage.toStringAsFixed(2) + ' %',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0)),
                ],
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Icon(KacinvestIcon.angle_double_up,
                    color: Colors.white, size: 40.0),
                //Icon(Icons.arrow_upward, color: Colors.white, size: 40.0),
              )),
              VerticalDivider(
                indent: 20,
                endIndent: 20,
                thickness: 1,
                color: Colors.white,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Balance',
                              style: TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Montserrat',
                                fontSize: 18.0,
                              )),
                          Text(HomeTab.currentbalance.toStringAsFixed(0),
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40.0)),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.white,
                    height: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Return',
                              style: TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Montserrat',
                                fontSize: 14.0,
                              )),
                          Text(HomeTab.returnbalance.toStringAsFixed(0),
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0)),
                          Text('Start Invest',
                              style: TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Montserrat',
                                fontSize: 14.0,
                              )),
                          Text(HomeTab.currentbalancestart.toStringAsFixed(0),
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  Widget _invest() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(30.0),
            topRight: const Radius.circular(30.0)),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 24, 24, 0),
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Reksa Dana \nProducts',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28.0))
                        ],
                      ),
                      Material(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(24.0),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('3',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.0)),
                          )))
                    ]),
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: getbalance()),
        ],
      ),
    );
  }

  ListView getbalance() {
    return ListView.builder(
      itemCount: balance.length,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        var balance2 = balance[index];
        return FadeAnimation(1.5, StockCard(bal: balance2, index:index));
      },
    );
  }
}

class HomeScreenBottomPart extends StatelessWidget {
  List<String> images = [
    "assets/images/if_1_avatar_2754574.png",
    "assets/images/if_1_avatar_2754574.png",
    "assets/images/if_1_avatar_2754574.png"
  ];

  List<String> titles = ["Runaways", "Avengers: infinity war", "Black Panther"];

  List<Widget> movies() {
    List<Widget> movieList = new List();

    for (int i = 0; i < 3; i++) {
      var movieitem = Padding(
        padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 12.0),
        child: Container(
          height: 220.0,
          width: 135.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0))
              ]),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                child: Image.asset(
                  images[i],
                  width: double.infinity,
                  height: 130.0,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
                child: Text(titles[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.0, fontFamily: "SF-Pro-Display-Bold")),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.0),
                child: Text(i == 0 ? "Season 2" : ""),
              )
            ],
          ),
        ),
      );
      movieList.add(movieitem);
    }
    return movieList;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 360.0,
      margin: EdgeInsets.only(left: 65.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Watch now",
                  style: TextStyle(
                      fontSize: 22.0, fontFamily: "SF-Pro-Display-Bold"),
                ),
                FlatButton(
                  child: Text("View more"),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Container(
            height: 250.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: movies(),
            ),
          )
        ],
      ),
    );
  }
}

class SlidingCardsView extends StatefulWidget {
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  int bottomSelectedIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PageView(
              pageSnapping: false,
              controller: pageController,
              onPageChanged: (index) {
                pageChanged(index);
              },
              children: <Widget>[
                Balance(),
                SlidingCard(
                  name: 'Shenzhen GLOBAL DESIGN AWARD 2018',
                  date: '4.20-30',
                  //assetName: 'steve-johnson.jpeg',
                ),
                SlidingCard(
                  name: 'Dawan District, Guangdong Hong Kong and Macao',
                  date: '4.28-31',
                  //assetName: 'rodion-kutsaev.jpeg',
                ),
                SlidingCard(
                  name: 'Dawan District, Guangdong Hong Kong and Macao',
                  date: '4.28-31',
                  //assetName: 'rodion-kutsaev.jpeg',
                ),
              ],
            ),
          ),
        ),
        Row(
          children: <Widget>[
            KeyboardNumber(
              n: 1,
              onPressed: () {
                bottomTapped(0);
              },
            ),
            KeyboardNumber(
              n: 2,
              onPressed: () {
                bottomTapped(1);
              },
            ),
            KeyboardNumber(
              n: 3,
              onPressed: () {
                bottomTapped(2);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name; //<-- title of the event
  final String date; //<-- date of the event
  // final String assetName; //<-- name of the image to be displayed

  const SlidingCard({
    Key key,
    @required this.name,
    @required this.date,
    //@required this.assetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
      elevation: 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32)), //<--custom shape
      child: Column(
        children: <Widget>[
          ClipRRect(
            //<--clipping image
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            child: Image.asset(
              //<-- main image
              //'assets/$assetName',
              "assets/images/BGStock2.jpg",
              height: MediaQuery.of(context).size.height * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: CardContent(
              //<--replace the Container with CardContent
              name: name,
              date: date,
            ), //<-- will be replaced soon :)
          ),
        ],
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;

  const CardContent({Key key, @required this.name, @required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name, style: TextStyle(fontSize: 20)),
          SizedBox(height: 8),
          Text(date, style: TextStyle(color: Colors.grey)),
          Spacer(),
          Row(
            children: <Widget>[
              RaisedButton(
                color: Color(0xFF162A49),
                child: Text('Reserve'),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                onPressed: () {},
              ),
              Spacer(),
              Text(
                '0.00 \$',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 16),
            ],
          )
        ],
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

class StockCard extends StatefulWidget {
  final bal;
  final int index;
  const StockCard({Key key, this.bal, this.index}) : super(key: key);

  @override
  _StockCardState createState() => _StockCardState();
}

class _StockCardState extends State<StockCard> {
  String cardNumber = "INI BALANCE";
  String cardHolderName = "RETURN";
  String expiryDate = "";
  String cvv = "";
  bool showBack = false;
  
  static FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            CreditCard(
              cardIndex: widget.index,
              cardNumber: widget.bal['balanceStart'],
              cardExpiry: "expiryDate",
              cardHolderName: widget.bal['username'],
              cvv: widget.bal['stockID'],
              bankName: widget.bal['Name'],
              bankLogo: widget.bal['logo'],
              showBackSide: showBack,
              frontBackground: CardBackgrounds.white,
              backBackground: CardBackgrounds.gray,
              showShadow: true,
            ),
            SizedBox(
              height: 40,
            ),
            /*
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Card Number"),
                    maxLength: 19,
                    onChanged: (value) {
                      setState(() {
                        cardNumber = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Card Expiry"),
                    maxLength: 5,
                    onChanged: (value) {
                      setState(() {
                        expiryDate = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Card Holder Name"),
                    onChanged: (value) {
                      setState(() {
                        cardHolderName = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "CVV"),
                    maxLength: 3,
                    onChanged: (value) {
                      setState(() {
                        cvv = value;
                      });
                    },
                    focusNode: _focusNode,
                  ),
                ),
              ],
            )*/
          ],
        ),
      ),
    );
  }
}

class Balance extends StatelessWidget {
  Widget _balance(_media) {
    return Card(
      child: Container(
        height: _media.height * 0.3,
        width: _media.width,
        decoration: BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('Return',
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Montserrat',
                          fontSize: 13.0,
                        )),
                    Text('2%',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24.0)),
                  ],
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Icon(KacinvestIcon.angle_double_up,
                      color: Colors.white, size: 40.0),
                  //Icon(Icons.arrow_upward, color: Colors.white, size: 40.0),
                )),
                VerticalDivider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                  color: Colors.white,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Balance',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: 'Montserrat',
                                  fontSize: 18.0,
                                )),
                            Text('2.120.000 IDR',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 40.0)),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.white,
                      height: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('Return',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: 'Montserrat',
                                  fontSize: 14.0,
                                )),
                            Text('2.120.000 IDR',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0)),
                            Text('Start Invest',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: 'Montserrat',
                                  fontSize: 14.0,
                                )),
                            Text('2.120.000 IDR',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Container(
      child: _balance(_media),
    );
  }
}
