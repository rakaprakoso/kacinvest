import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:kacinvest/src/data/data.dart';
import 'package:kacinvest/src/data/datadb.dart';
import 'package:kacinvest/src/data/services.dart';
import 'package:kacinvest/src/widgets/credit_card.dart';
import 'package:kacinvest/src/widgets/credit_cardHome.dart';
import 'package:kacinvest/src/widgets/search_bar_android.dart';
import 'package:kacinvest/src/widgets/user_card.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

import 'package:kacinvest/util.dart';
import 'package:kacinvest/Tab/profile.dart';

import 'package:flutter/cupertino.dart';
import 'package:kacinvest/src/widgets/search_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MarketTab extends StatefulWidget {
  @override
  _MarketTabState createState() => _MarketTabState();
}

class _MarketTabState extends State<MarketTab>{
  double _width = 0;
  int cek = 0;
  static String _username = '';

  _panggil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    var otp = prefs.getString('OTP');
    print("$username & $otp");
    setState(() => _username = '$username');
  }

  @override
  void initState() {
    super.initState();
    //items.addAll(duplicateItems);
    //itemStock.addAll(duplicateStock);
    _panggil();
    Services.getStockProducts().then((stocksFromServer) {
      setState(() {
        stocks = stocksFromServer;
        filteredStocks = stocks;
      });
    });

  }

 
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: new Column(
          children: <Widget>[
            Container(
              height: 270.0,
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: Mclipper(),
                    child: Container(
                      height: 220.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 10.0),
                                blurRadius: 10.0)
                          ]),
                      child: Stack(
                        children: <Widget>[
                          Image.asset("assets/images/BGStock2.jpg",
                              fit: BoxFit.cover, width: double.infinity),
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  const Color(0x00000000),
                                  const Color(0xD9333333)
                                ],
                                    stops: [
                                  0.0,
                                  0.9
                                ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(0.0, 1.0))),
                            child: Padding(
                              padding: EdgeInsets.only(top: 50.0, left: 95.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "INVEST FOR YOUR FUTURE",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontFamily: "SF-Pro-Display-Bold"),
                                  ),
                                  Text(
                                    "Stock Product",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 45.0,
                                        fontFamily: "SF-Pro-Display-Bold"),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 220.0,
                    right: 0.0,
                    child: FractionalTranslation(
                      translation: Offset(0.0, -0.5),
                      child: Row(
                        children: <Widget>[
                          FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                if (cek == 0) {
                                  _width = 250;
                                  cek = 1;
                                } else {
                                  _width = 0;
                                  cek = 0;
                                }
                              });
                            },
                            child: Icon(
                              Icons.search,
                              color: Color(0xFFE52020),
                            ),
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 600),
                            width: _width,
                            curve: Curves.fastOutSlowIn,
                            child: Material(
                              elevation: 2.0,
                              shadowColor: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(30.0),
                                  bottomLeft: const Radius.circular(30.0)),
                              child: SizedBox(
                                width: 250,
                                child: TextFormField(
                                  onChanged: (string) {
                                    //filterSearchResults(value);
                                    _debouncer.run(() {
                                      setState(() {
                                        filteredStocks = stocks
                                            .where((u) => (u.name
                                                    .toLowerCase()
                                                    .contains(
                                                        string.toLowerCase()) ||
                                                u.stockID
                                                    .toLowerCase()
                                                    .contains(
                                                        string.toLowerCase())))
                                            .toList();
                                      });
                                    });
                                  },
                                  controller: editingController,
                                  decoration: new InputDecoration(
                                    hintText: "Search..",
                                    //fillColor: PaypalColors.Orange, filled: true,
                                    fillColor: Colors.white, filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        30.0, 00.0, 30.0, 00.0),
                                    //prefixIcon: Icon(Icons.search),
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(30.0),
                                          bottomLeft:
                                              const Radius.circular(30.0)),
                                      //borderSide: new BorderSide(),
                                      borderSide: BorderSide.none,
                                    ),
                                    //hintText: ,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            //HomeScreeTopPart(),

            //_search(),
            //_searchbutton(),
            //_activityList(),
            SizedBox(
              width: _media.width,
              height: _media.height-400,
              child:_activityListtt(context, _username),
              ),
            _result(),
          ],
        //), // Add search body here
      ),
    ),);
  }
/*
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new CupertinoPageScaffold(
      navigationBar: new CupertinoNavigationBar(
        middle: new IOSSearchBar(
          controller: _searchTextController,
          focusNode: _searchFocusNode,
          animation: _animation,
          onCancel: _cancelSearch,
          onClear: _clearSearch,
        ),
      ),
      child: new GestureDetector(
        onTapUp: (TapUpDetails _) {
          _searchFocusNode.unfocus();
          if (_searchTextController.text == '') {
            _animationController.reverse();
          }
        },
        child: new Container(
          margin: EdgeInsets.only(top: 50),
          //child: _activityText(),
          child: Column(
            children: <Widget>[
              HomeScreeTopPart(),
              _activityList(),
              
            ],
          ),
        ), // Add search body here
      ),
    ));
  }*/

/*
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return SingleChildScrollView(
      
      child: Column(
        children: < Widget > [
          
          _activityText(),
          _activityList(),
        ],
      ),
    );
  }*/

  final _debouncer = Debouncer(milliseconds: 500);
  List<StockProduct> stocks = List();
  List<StockProduct> filteredStocks = List();

  TextEditingController editingController = TextEditingController();

//BENARRR
  var duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        print(duplicateItems);
        print(items);
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  TextField _search() {
    return TextField(
      onChanged: (value) {
        filterSearchResults(value);
      },
      controller: editingController,
      decoration: InputDecoration(
          labelText: "Search",
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );
  }

  SingleChildScrollView _activityListtt(context, username) {
    getStocks() async {
      var response = await http
          .get("http://kacinvest.arkeyproject.com/try/SelectAllUsers.php");
      return jsonDecode(response.body);
    }

    getTransaction() async {
      var response = await http.get(
          "http://kacinvest.arkeyproject.com/try/SelectAllUsers.php");
      return jsonDecode(response.body);
    }

    //var transactions = _HomeTabState.transactions;
    final _media = MediaQuery.of(context).size;
    var amount, amountColor;

    return SingleChildScrollView(
    child: Container(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: new FutureBuilder(
          future: getStocks(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              var transactions = snapshot.data;
              // tampilkan dvarata
              return ListView.builder(
                itemCount: filteredStocks.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.all(15),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 5, top: 5),
                    decoration: _tileDecoration(),
                    child: ListTile(
                      leading:
                          Image.network(filteredStocks[index].logo, width: 60),
                      title: Text(
                        filteredStocks[index].name,
                        style: TextStyle(
                            fontFamily: "worksans",
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      subtitle: Text(
                        filteredStocks[index].name,
                        style: TextStyle(
                            fontFamily: "worksans",
                            fontWeight: FontWeight.w300),
                      ),
                      trailing: Text(
                        filteredStocks[index].priceNAB,
                        style: TextStyle(
                          fontFamily: "worksans",
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    ),);
  }

  Expanded _result() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.all(15),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${items[index]}'),
          );
        },
      ),
    );
  }

  Container _searchbutton() {
    double _width = 0;
    int cek = 0;

    return new Container(
      height: 270.0,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: Mclipper(),
            child: Container(
              height: 220.0,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 10.0),
                    blurRadius: 10.0)
              ]),
              child: Stack(
                children: <Widget>[
                  Image.asset("assets/images/BGStock2.jpg",
                      fit: BoxFit.cover, width: double.infinity),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          const Color(0x00000000),
                          const Color(0xD9333333)
                        ],
                            stops: [
                          0.0,
                          0.9
                        ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(0.0, 1.0))),
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.0, left: 95.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "INVEST FOR YOUR FUTURE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "SF-Pro-Display-Bold"),
                          ),
                          Text(
                            "Stock Product",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 45.0,
                                fontFamily: "SF-Pro-Display-Bold"),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 220.0,
            right: 0.0,
            child: FractionalTranslation(
              translation: Offset(0.0, -0.5),
              child: Row(
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        if (cek == 0) {
                          _width = 250;
                          cek = 1;
                        } else {
                          _width = 0;
                          cek = 0;
                        }
                      });
                    },
                    child: Icon(
                      Icons.search,
                      color: Color(0xFFE52020),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 600),
                    width: _width,
                    curve: Curves.fastOutSlowIn,
                    child: Material(
                      elevation: 2.0,
                      shadowColor: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(30.0),
                          bottomLeft: const Radius.circular(30.0)),
                      child: SizedBox(
                        width: 250,
                        child: TextFormField(
                          onChanged: (value) {
                            filterSearchResults(value);
                          },
                          controller: editingController,
                          decoration: new InputDecoration(
                            hintText: "Enter Email",
                            //fillColor: PaypalColors.Orange, filled: true,
                            fillColor: Colors.white, filled: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(30.0, 00.0, 30.0, 00.0),
                            //prefixIcon: Icon(Icons.search),
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(30.0),
                                  bottomLeft: const Radius.circular(30.0)),
                              //borderSide: new BorderSide(),
                              borderSide: BorderSide.none,
                            ),
                            //hintText: ,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /*ClipRRect(
                    //borderRadius: BorderRadius.circular(30.0),
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(30.0),
                        bottomLeft: const Radius.circular(30.0)),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Color(0xFFE52020),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 80.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Watch Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "SF-Pro-Display-Bold"),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          RotatedBox(
                            quarterTurns: 2,
                            child: Icon(Icons.arrow_back_ios,
                                size: 25.0, color: Colors.white),
                          )
                        ],
                      ),
                    ),*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _activityText() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: PaypalColors.LightGrey19))),
      margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Activity',
            style: TextStyle(
                fontFamily: "worksans",
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'VIEW ALL',
                style: TextStyle(
                    fontFamily: "worksans",
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: PaypalColors.Grey),
              ),
              Icon(Icons.chevron_right, color: PaypalColors.Black50),
            ],
          ),
        ],
      ),
    );
  }

  ListView _activityList() {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.all(15),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 15),
          decoration: _tileDecoration(),
          child: ListTile(
            leading: Container(
              width: 60,
              child:
                  Image.asset('assets/images/users/Bank_Syariah_Mandiri.png'),
            ),
            title: Text(
              'Mandiri Syariah Reksa Dana',
              style: TextStyle(
                  fontFamily: "worksans",
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            subtitle: Text(
              'Reksa Dana Pendapatan Tetap',
              style: TextStyle(
                  fontFamily: "worksans", fontWeight: FontWeight.w300),
            ),
            trailing: Text(
              'Return\n7%',
              textAlign: TextAlign.right,
              style: TextStyle(fontFamily: "worksans"),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          decoration: _tileDecoration(),
          child: ListTile(
            leading: Container(
              width: 60,
              child: Image.asset('assets/images/users/BNP_Paribas.jpg'),
            ),
            title: Text(
              'BNP Paribas Pesona',
              style: TextStyle(
                  fontFamily: "worksans",
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            subtitle: Text(
              'Reksa Dana Campuran',
              style: TextStyle(
                  fontFamily: "worksans", fontWeight: FontWeight.w300),
            ),
            trailing: Text(
              'Return\n3.45%',
              textAlign: TextAlign.right,
              style: TextStyle(fontFamily: "worksans"),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          decoration: _tileDecoration(),
          child: ListTile(
            leading: Container(
              width: 60,
              child: Image.asset(
                "assets/images/users/Avrist.png",
                fit: BoxFit.scaleDown,
                width: 35.0,
                height: 35.0,
              ),
            ),
            title: Text(
              'Avrist Equity - Cross Sectoral',
              style: TextStyle(
                  fontFamily: "worksans",
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            subtitle: Text(
              'Reksa Dana Saham',
              style: TextStyle(
                  fontFamily: "worksans", fontWeight: FontWeight.w300),
            ),
            trailing: Text(
              'Return\n4.5%',
              textAlign: TextAlign.right,
              style: TextStyle(fontFamily: "worksans"),
            ),
          ),
        ),
      ],
    );
  }
}

BoxDecoration _tileDecoration() {
  return BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white, width: 0, style: BorderStyle.solid),
    borderRadius: BorderRadius.all(
      Radius.circular(5.0),
    ),
    boxShadow: [
      BoxShadow(
          color: PaypalColors.LightGrey19,
          offset: Offset(0, 0),
          blurRadius: 3,
          spreadRadius: 1)
    ],
  );
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      alignment: Alignment.center,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlue.shade50,
            blurRadius: 8.0,
            spreadRadius: 4,
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Colors.blue,
            ),
            onPressed: () => print("add money"),
            iconSize: 40.0,
          ),
          Text(
            "Add Person",
            style: TextStyle(
                inherit: true,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.black45),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class HomeScreeTopPart extends StatefulWidget {
  @override
  HomeScreeTopPartState createState() {
    return new HomeScreeTopPartState();
  }
}

class HomeScreeTopPartState extends State<HomeScreeTopPart> {
  double _width = 0;
  int cek = 0;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 270.0,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: Mclipper(),
            child: Container(
              height: 220.0,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 10.0),
                    blurRadius: 10.0)
              ]),
              child: Stack(
                children: <Widget>[
                  Image.asset("assets/images/BGStock2.jpg",
                      fit: BoxFit.cover, width: double.infinity),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          const Color(0x00000000),
                          const Color(0xD9333333)
                        ],
                            stops: [
                          0.0,
                          0.9
                        ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(0.0, 1.0))),
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.0, left: 95.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "INVEST FOR YOUR FUTURE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "SF-Pro-Display-Bold"),
                          ),
                          Text(
                            "Stock Product",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 45.0,
                                fontFamily: "SF-Pro-Display-Bold"),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 220.0,
            right: 0.0,
            child: FractionalTranslation(
              translation: Offset(0.0, -0.5),
              child: Row(
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        if (cek == 0) {
                          _width = 250;
                          cek = 1;
                        } else {
                          _width = 0;
                          cek = 0;
                        }
                      });
                    },
                    child: Icon(
                      Icons.search,
                      color: Color(0xFFE52020),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 600),
                    width: _width,
                    curve: Curves.fastOutSlowIn,
                    child: Material(
                      elevation: 2.0,
                      shadowColor: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(30.0),
                          bottomLeft: const Radius.circular(30.0)),
                      child: SizedBox(
                        width: 250,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            hintText: "Search..",
                            //fillColor: PaypalColors.Orange, filled: true,
                            fillColor: Colors.white, filled: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(30.0, 00.0, 30.0, 00.0),
                            //prefixIcon: Icon(Icons.search),
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(30.0),
                                  bottomLeft: const Radius.circular(30.0)),
                              //borderSide: new BorderSide(),
                              borderSide: BorderSide.none,
                            ),
                            //hintText: ,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /*ClipRRect(
                    //borderRadius: BorderRadius.circular(30.0),
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(30.0),
                        bottomLeft: const Radius.circular(30.0)),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Color(0xFFE52020),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 80.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Watch Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "SF-Pro-Display-Bold"),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          RotatedBox(
                            quarterTurns: 2,
                            child: Icon(Icons.arrow_back_ios,
                                size: 25.0, color: Colors.white),
                          )
                        ],
                      ),
                    ),*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Mclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 100.0);

    var controlpoint = Offset(35.0, size.height);
    var endpoint = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(
        controlpoint.dx, controlpoint.dy, endpoint.dx, endpoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
