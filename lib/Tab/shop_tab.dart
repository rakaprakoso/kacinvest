import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:kacinvest/Tab/shop_tab%20copy.dart';
import 'package:kacinvest/screens/app.dart';
import 'package:kacinvest/src/data/API.dart';
import 'package:kacinvest/src/data/data.dart';
import 'package:kacinvest/src/data/datadb.dart';
import 'package:kacinvest/src/data/services.dart';
import 'package:kacinvest/src/models/topstock_model.dart';
import 'package:kacinvest/src/models/user_model.dart';
import 'package:kacinvest/src/widgets/credit_card.dart';
import 'package:kacinvest/src/widgets/credit_cardHome.dart';
import 'package:kacinvest/src/widgets/top_stock_card.dart';
import 'package:kacinvest/src/widgets/user_card.dart';

import 'package:kacinvest/util.dart';
import 'package:kacinvest/Tab/profile.dart';

import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopTab extends StatefulWidget {
  @override
  _ShopTabState createState() => _ShopTabState();
}

class _ShopTabState extends State<ShopTab> {
  static var _isLoading = false;
  static var data;
  static var profile;
  static var transactions;
  static var balance;
  static var currentbalance, currentbalancestart, returnbalance;
  static String _username = '';
  double _width = 0;
  int cek = 0;

  _panggil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    var otp = prefs.getString('OTP');
    print("$username & $otp");
    setState(() => _username = '$username');
  }

  FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
      amount: 12345678.9012345,
      settings: MoneyFormatterSettings(
        symbol: 'IDR',
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 3,
      ));

  _gettingdata() async {
    var profiles;
    var transaction;
    var _balance;
    var users;

    //ProfileModel
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    final url =
        "http://kacinvest.arkeyproject.com/try/Profile.php?username=$username";
    final response = await http.get(url);
    if (response.statusCode == 200) profiles = json.decode(response.body);

    //Transaction Model
    final url1 =
        "http://kacinvest.arkeyproject.com/try/Transactions.php?username=$username";
    final response1 = await http.get(url1);
    if (response1.statusCode == 200) transaction = json.decode(response1.body);

    //Balance Model
    final url2 =
        "http://kacinvest.arkeyproject.com/try/Balance.php?username=$username";
    final response2 = await http.get(url2);
    if (response2.statusCode == 200) _balance = json.decode(response2.body);
/*
//Get Data
    final url3 = "http://kacinvest.arkeyproject.com/try/SelectAllUsers.php";
    final response3 = await http.get(url3);
    if (response3.statusCode == 200) final users = json.decode(response.body);

//Get Stock Product
    Services.getStockProducts().then((StockProduct) {
      setState(() {
        _stockproducts = StockProduct;
        //profilemodel
        profile = profiles;
        print(profile);
        print(profile.length);
        //Transaction
        transactions = transaction;
        //Balance
        balance = _balance;
        //Stock

        data = users;
        _isLoading = true;
      }); // Reset the title...
      print("Length ${StockProduct.length}");
      print("ISI ${StockProduct}");
    });*/
    setState(() {
      //_stockproducts = StockProduct;
      //profilemodel
      profile = profiles;
      print(profile);
      print(profile.length);
      //Transaction
      transactions = transaction;
      print(transactions);
      print(transactions.length);
      //Balance
      balance = _balance;
      currentbalancestart = returnbalance = currentbalance = 0;
      int i = 0;

      while (i < balance.length) {
        double j = double.parse(balance[i]["stockNABunit"]);
        double k = double.parse(balance[i]["priceNAB"]);
        currentbalancestart += double.parse(balance[i]["balanceStart"]);
        currentbalance += (j * k);
        returnbalance = currentbalance - currentbalancestart;
        i++;
      }

      print("Current balance start : $currentbalancestart");
      print("Current balance : $currentbalance");
      print("Current return balance : $returnbalance");
      /*//Stock

        data = users;*/
      _isLoading = true;
    }); // Reset the title...
  }

  _profileModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    final url =
        "http://kacinvest.arkeyproject.com/try/Profile.php?username=$username";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final profiles = json.decode(response.body);

      setState(() {
        _isLoading = true;
        profile = profiles;
        print(profile);
        print(profile.length);
      });
    }
  }

  _transactionModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    final url =
        "http://kacinvest.arkeyproject.com/try/Transactions.php?username=$username";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final transaction = json.decode(response.body);

      setState(() {
        _isLoading = true;
        transactions = transaction;
        //print(transactions);
        //print(transactions.length);
      });
    }
  }

  _balanceModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    final url =
        "http://kacinvest.arkeyproject.com/try/Balance.php?username=$username";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final _balance = json.decode(response.body);

      setState(() {
        _isLoading = true;
        balance = _balance;
        print(balance);
        print(balance.length);
        currentbalancestart = returnbalance = currentbalance = 0;
        int i = 0;
        int j = int.parse(balance[i]["stockNABunit"]);
        int k = int.parse(balance[i]["priceNAB"]);

        while (i < balance.length) {
          currentbalancestart += int.parse(balance[i]["balanceStart"]);
          currentbalance += (j * k);
          returnbalance = currentbalance - currentbalancestart;
          i++;
        }

        print("Current balance start : $currentbalancestart");
        print("Current balance : $currentbalance");
        print("Current return balance : $returnbalance");
      });
    }
  }

  _balanceCalc() async {
    setState(() {
      currentbalancestart = returnbalance = currentbalance = 0;
      int i = 0;

      while (i < balance.length) {
        currentbalancestart += balance[i]["balanceStart"];
        currentbalance += (balance[i]["stockNABunit"] * balance[i]["priceNAB"]);
        returnbalance = currentbalance - currentbalancestart;
        i++;
      }

      print("Current balance start : $currentbalancestart");
      print("Current balance : $currentbalance");
      print("Current return balance : $returnbalance");
    });
  }

  static List<StockProduct> _stockproducts;

  _getStockProducts() {
    Services.getStockProducts().then((StockProduct) {
      setState(() {
        _stockproducts = StockProduct;
      }); // Reset the title...
      print("Length ${StockProduct.length}");
      print("ISI ${StockProduct}");
    });
  }

  _getData() async {
    final url = "http://kacinvest.arkeyproject.com/try/SelectAllUsers.php";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final users = json.decode(response.body);

      setState(() {
        _isLoading = true;
        data = users;
        //print(data);
        //print(data.length);
      });
    }
  }

  getSeafood() async {
    var response = await http
        .get("https://www.themealdb.com/api/json/v1/1/filter.php?c=Vegetarian");
    return jsonDecode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data22();
    _getData();
    _getStockProducts();
    _stockproducts = [];
    _panggil();
    //_profileModel();
    //_transactionModel();
    //_balanceModel();
    //_balanceCalc();
    //_panggil();
    //_balanceModel();
    //_gettingdata();
    data2();

    Services.getStockProducts().then((stocksFromServer) {
      setState(() {
        stocks = stocksFromServer;
        filteredStocks = stocks;
      });
    });
  }

  static var dataaa;

  data22() async {
    setState(() {
      dataaa = MenuDashboardPage.dataa;
      print('asdasdasdas');
      print('${dataaa}');
      //print(transactions.length);
    });
  }

  final _debouncer = Debouncer(milliseconds: 500);
  List<StockProduct> stocks = List();
  List<StockProduct> filteredStocks = List();
  TextEditingController editingController = TextEditingController();

  var stocks2;
  var filteredStocks2;

  getStocks() async {
    var response = await http
        .get("http://kacinvest.arkeyproject.com/try/SelectAllUsers.php");
    return jsonDecode(response.body);
  }

  static var dataa = MenuDashboardPage.dataa;

  data2() async {
    setState(() {
      stocks2 = MenuDashboardPage.dataa;
      filteredStocks2 = stocks2;
      dataa = MenuDashboardPage.dataa;
      print('dataaass');
      print('ISINYA ${filteredStocks}');
      //print(transactions.length);
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final _media = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: !_isLoading
          ? new CircularProgressIndicator()
          : Column(
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
                                  padding:
                                      EdgeInsets.only(top: 50.0, left: 95.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "INVEST FOR YOUR FUTURE",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                            fontFamily: "Montserrat"),
                                      ),
                                      Text(
                                        "Stock Product",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 45.0,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w700,
                                        ),
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
                                            filteredStocks2 = stocks2
                                                .where((u) => (u['Name']
                                                        .toLowerCase()
                                                        .contains(string
                                                            .toLowerCase()) ||
                                                    u['stockID']
                                                        .toLowerCase()
                                                        .contains(string
                                                            .toLowerCase()) ||
                                                    u['category']
                                                        .toLowerCase()
                                                        .contains(string
                                                            .toLowerCase())))
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
                                              topLeft:
                                                  const Radius.circular(30.0),
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
                //category(),

                //FadeAnimation(1.5, makeItem(image: 'assets/images/BGStock2.jpg', tag: 'red', context: context)),
                //BuyPage(),
                stocklist(),
                //stocklist2(),
                /*Container(
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
                                  leading: Image.network(
                                      filteredStocks[index].logo,
                                      width: 60),
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
                ),
              */
              ],
            ),
    );
  }

  Container stocklist() {
    int x = -1;
    return Container(
      child: ListView.builder(
          itemCount: filteredStocks2.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.all(15),
          itemBuilder: (BuildContext context, int index) {
            var textStyle = TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            );
            String risk;
            if (filteredStocks2[index]['risk'] == '1') {
              risk = 'Low Risk';
            } else if (filteredStocks2[index]['risk'] == '2') {
              risk = 'Medium Risk';
            } else {
              risk = 'High Risk';
            }
            ;
            if (index == 0) {
              return FadeAnimation(
                  1.5,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '$risk',
                        style: textStyle,
                      ),
                      SizedBox(height: 10),
                      makeItem(
                          image: filteredStocks2[index]['logo'],
                          tag: filteredStocks2[index]['stockID'],
                          name: filteredStocks2[index]['Name'],
                          stockid: filteredStocks2[index]['stockID'],
                          category: filteredStocks2[index]['category'],
                          price: filteredStocks2[index]['priceNAB'],
                          context: context),
                    ],
                  ));
            }
            ;
            if (filteredStocks2[index]['risk'] ==
                filteredStocks2[index - 1]['risk']) {
              return FadeAnimation(
                  1.5,
                  Column(
                    children: <Widget>[
                      makeItem(
                          image: filteredStocks2[index]['logo'],
                          tag: filteredStocks2[index]['stockID'],
                          name: filteredStocks2[index]['Name'],
                          stockid: filteredStocks2[index]['stockID'],
                          category: filteredStocks2[index]['category'],
                          price: filteredStocks2[index]['priceNAB'],
                          context: context),
                    ],
                  ));
            }
            ;
            if (filteredStocks2[index]['risk'] !=
                filteredStocks2[index - 1]['risk']) {
              return FadeAnimation(
                  1.5,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        '$risk',
                        style: textStyle,
                      ),
                      SizedBox(height: 10),
                      makeItem(
                          image: filteredStocks2[index]['logo'],
                          tag: filteredStocks2[index]['stockID'],
                          name: filteredStocks2[index]['Name'],
                          stockid: filteredStocks2[index]['stockID'],
                          category: filteredStocks2[index]['category'],
                          price: filteredStocks2[index]['priceNAB'],
                          context: context),
                    ],
                  ));
            }
            ;
          }),
    );
  }

  Container stocklist2() {
    return Container(
      child: FutureBuilder(
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
                return FadeAnimation(
                    1.5,
                    makeItem(
                        image: filteredStocks[index].logo,
                        tag: filteredStocks[index].stockID,
                        name: filteredStocks[index].name,
                        context: context));
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget makeItem({image, tag, name, stockid, category, price, context}) {
    return Hero(
      tag: tag,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Stocks(
                        name: name,
                        image: image,
                        stockid: stockid,
                        price: price,
                      )));
        },
        child: Container(
          height: 80,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              /*image: DecorationImage(
              //image: AssetImage(image),
              fit: BoxFit.cover
            ),*/
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 10,
                    offset: Offset(0, 2))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Image.network(image, fit: BoxFit.contain),
                    flex: 2,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: FadeAnimation(
                        1.2,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              name,
                              //stockid,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              category,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )),
                    flex: 8,
                  ),
                  Expanded(
                    child: FadeAnimation(
                        1.2,
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                            child: Icon(
                              Icons.favorite_border,
                              size: 20,
                            ),
                          ),
                        )),
                    flex: 1,
                  ),

                  /*Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(1, Text("Sneakers", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),)),
                        SizedBox(height: 10,),
                        FadeAnimation(1.1, Text("Nike", style: TextStyle(color: Colors.black, fontSize: 20),)),

                      ],
                    ),
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding category() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 2.2 / 1,
              child: FadeAnimation(
                  1,
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "All",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )),
            ),
            AspectRatio(
              aspectRatio: 2.2 / 1,
              child: FadeAnimation(
                  1.1,
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        editingController.text = '';
                        editingController.text = '1';
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Center(
                        child: Text(
                          "Low Risk",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  )),
            ),
            AspectRatio(
              aspectRatio: 2.2 / 1,
              child: FadeAnimation(
                  1.2,
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Center(
                      child: Text(
                        "Stocks",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  )),
            ),
            AspectRatio(
              aspectRatio: 2.2 / 1,
              child: FadeAnimation(
                  1.3,
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Center(
                      child: Text(
                        "Saham",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  )),
            ),
            AspectRatio(
              aspectRatio: 2.2 / 1,
              child: FadeAnimation(
                  1.4,
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Center(
                      child: Text(
                        "Mix",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
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

class Stocks extends StatefulWidget {
  final String image;
  final String stockid;
  final String price;
  final String name;

  const Stocks({Key key, this.name, this.image, this.stockid, this.price})
      : super(key: key);

  @override
  _StocksState createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  final amountTextController = TextEditingController();
  String result='0';
  String _username;
  String amount;
  String productprice= '';

  _panggil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    print("$username");
    setState(() => _username = '$username');
  }

  _convert() async {
    double price = double.parse(widget.price);
  productprice= 'Product Price  IDR ' + price.toStringAsFixed(2);
  }

   _doConversion() async {
    setState(() {
      String nums = amountTextController.text;

      List values = nums.split(".");

      var concatenate = StringBuffer();

      values.forEach((item) {
        concatenate.write(item);
      });

      double moneyamount = double.parse(concatenate.toString());
      double price = double.parse(widget.price);
      double unit = moneyamount / price;

      amount = concatenate.toString();

      /*result = (double.parse(fromTextController.text) *
              (responseBody["$fromCurrency1" + "_$toCurrency1"]))
          .toStringAsFixed(2)
          .toString();*/

      result = unit.toStringAsFixed(2);

      //result = symbol + " " + amount;
    });
    print(result);
  }

     _doConversion2(string) async {
    setState(() {
      String nums = amountTextController.text;

      List values = nums.split(".");

      var concatenate = StringBuffer();

      values.forEach((item) {
        concatenate.write(item);
      });

      double moneyamount = double.parse(concatenate.toString());
      double price = double.parse(widget.price);
      double unit = moneyamount / price;

      amount = concatenate.toString();

      /*result = (double.parse(fromTextController.text) *
              (responseBody["$fromCurrency1" + "_$toCurrency1"]))
          .toStringAsFixed(2)
          .toString();*/

      result = unit.toStringAsFixed(2);

      //result = symbol + " " + amount;
    });
    print(result);
  }
  _buysell(type) async {

      String nums = amountTextController.text;
      List values = nums.split(".");
      var concatenate = StringBuffer();
      values.forEach((item) {
        concatenate.write(item);
      });
      amount = concatenate.toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    final url =
        "http://kacinvest.arkeyproject.com/try/buysell.php?username=${username}&stockid=${widget.stockid}&amount=${amount}&type=${type}";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final transaction = json.decode(response.body);

      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _panggil();
  _convert();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Hero(
        tag: 'red',
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.image), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 10,
                    offset: Offset(0, 10))
              ]),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Center(
                        child: Icon(
                          Icons.favorite_border,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                width: MediaQuery.of(context).size.width,
                child:
                    FadeAnimation(
                      1.2,Container(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                              Colors.black.withOpacity(.9),
                              Colors.black.withOpacity(.0),
                            ])),
                        child: Material(
                          elevation: 10,
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FadeAnimation(
                                    1.3,
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex:3,
                                          child: Text(
                                            "${widget.name}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: Image.network(
                                            widget.image
                                          ),
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  height: 30,
                                ),
                                TextField(
                                  onChanged: (string) {_doConversion2(string);},
                                  cursorColor: Colors.orange,
                                  controller: amountTextController,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    // Fit the validating format.
                                    //fazer o formater para dinheiro
                                    new CurrencyInputFormatter()
                                  ],
                                  decoration: new InputDecoration(
                                    prefixText:"IDR ",
                                    labelText: "Amount",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0),
                                      borderSide: new BorderSide(
                                        color: Colors.orange,
                                      ),
                                    ),

                                    //fillColor: Colors.green
                                  ),
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FadeAnimation(
                                    1.4,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          productprice,
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 14),
                                        ),
                                      ],
                                    )),
                                FadeAnimation(
                                    1.4,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          'Will get ${result} Unit',
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 14),
                                        ),
                                      ],
                                    )),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
  
                                        Expanded(
                                          flex:1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: MaterialButton(
                                              color:Colors.orange,
                                              child: Text('Sell', style:TextStyle(
                                                color:Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                              )),
                                              onPressed: () {
                                                _buysell('0');
                                                _onAlertWithCustomContentPressed(
                                                    context);
                                              },
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          flex:1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: MaterialButton(
                                              color:Colors.orange,
                                              child: Text('Buy', style:TextStyle(
                                                color:Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                              )),
                                              onPressed: () {
                                                _buysell('1');
                                                _onAlertWithCustomContentPressed(
                                                    context);
                                              },
                                            ),
                                          ),
                                        ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              )
            ],
          ),
        ),
      )),
    );
  }

  _onAlertWithCustomContentPressed(context) {
    Alert(
        context: context,
        title: "LOGIN",
        content: Column(
          children: <Widget>[
            Icon(Icons.check_circle),
            Text('Success!'),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = new NumberFormat("###,###.###", "pt-br");

    String newText = formatter.format(value);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
