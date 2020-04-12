import 'dart:convert';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kacinvest/Tab/home_tab.dart';
import 'package:kacinvest/Tab/shop_tab%20copy.dart';
import 'package:kacinvest/custom_icon/kacinvest_icon2_icons.dart';
import 'package:kacinvest/data/account.dart';
import 'package:kacinvest/data/main_data.dart';
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
  static var charts2 = MenuDashboardPage.charts;
  static var charts22 = MenuDashboardPage.charts2;
  //static var charts23 =MenuDashboardPage.chartsss3;

  var _isLoading = false;

  int actualChart = 0;
  var chart;
  static List<double> chartss = [];
  var data = [0.0, 1.0, 10.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

  var percentage; 
  var balance;
  var stock; 
  var tmpchat;

  load(){
    setState(() {
      percentage = HomeTab.returnbalance / HomeTab.currentbalancestart * 100;
      balance = HomeTab.balance;
      stock = MenuDashboardPage.dataa;
      tmpchat = MenuDashboardPage.charttemp2;
    });
  }

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
      }      chartsss2.add(doubletemp);
      i++;
    }
  }
//------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    load();
    //chartModel();
    //chartModel2();
    //chartModel3();
  }

    @override
  void dispose() {
    super.dispose();
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
              //Text('${mainBloc.username}'),
              //Text('${tmpchat}'),
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
                      Text(accountBloc.returnpercentageS,
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
                    child: Icon(accountBloc.returnIcon,
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
                          Text(accountBloc.currentbalanceS,
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
                          Text(accountBloc.returnbalanceS,
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
                          Text(accountBloc.currentbalancestartS,
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
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Icon(KacinvestIcon2.chart_area,
                      color: Colors.orange, size: 60.0),
                      SizedBox(width: 5),
                          Text('Stock\nProducts',
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
                            child: Text('${accountBloc.balance.length}',
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
            height:300,
            width: MediaQuery.of(context).size.width,
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
      itemCount: accountBloc.balance.length,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        var balance = accountBloc.balance[index];
        return FadeAnimation(0.8, StockCard(bal: balance, index: index));
      },
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            CreditCard(
              width:MediaQuery.of(context).size.width-50,
              height: 200,
              cardIndex: widget.index,
              cardNumber: widget.bal['balanceStart'],
              cardExpiry: widget.bal['balanceStart'],
              balancestart: widget.bal['balanceStart'],
              priceNAB: widget.bal['priceNAB'],
              unitNAB: widget.bal['stockNABunit'],
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
          ],
        ),
      ),
    );
  }
}