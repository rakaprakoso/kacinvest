import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:kacinvest/src/data/API.dart';
import 'package:kacinvest/src/data/data.dart';
import 'package:kacinvest/src/data/datadb.dart';
import 'package:kacinvest/src/data/services.dart';
import 'package:kacinvest/src/models/user_model.dart';
import 'package:kacinvest/src/widgets/credit_card.dart';
import 'package:kacinvest/src/widgets/credit_cardHome.dart';
import 'package:kacinvest/src/widgets/user_card.dart';

import 'package:kacinvest/util.dart';
import 'package:kacinvest/Tab/profile.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
  static var profile = _HomeTabState.profile;
}

class _HomeTabState extends State<HomeTab> {
  static var _isLoading = false;
  static var data;
  static var profile;
  static var transactions;
  static var balance;
  static var currentbalance, currentbalancestart, returnbalance;
  static String _username = '';

  _panggil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    print(username);
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

/* Future<List> ProfileModel async {

    var data = await http.get("http://kacinvest.arkeyproject.com/try/Profile.php");

    var jsonData = json.decode(data.body);

    List<ProfileModel> profiles = [];

    for(var u in jsonData){

      ProfileModel profile = ProfileModel(u["username"], u["referralCode"], u["firstName"], u["lastName"], u["bornDate"], u["email"], u["phoneNumber"], u["address"], u["bankAccountNumber"]);

      profiles.add(profile);

    }

    print(profiles.length);

    return profiles;

  }*/
  _profileModel() async {
    final url = "http://kacinvest.arkeyproject.com/try/Profile.php";
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
        print(transactions);
        print(transactions.length);
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

  Future<String> _ShowDialog(String msg) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Info '),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                _getData();
              },
            ),
          ],
        );
      },
    );
  }

  List<StockProduct> _stockproducts;

  _getStockProducts() {
    Services.getStockProducts().then((StockProduct) {
      setState(() {
        _stockproducts = StockProduct;
      }); // Reset the title...
      print("Length ${StockProduct.length}");
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
        print(data);
        print(data.length);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
    _getStockProducts();
    _stockproducts = [];
    _panggil();
    _profileModel();
    _transactionModel();
    _balanceModel();
    _balanceCalc();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final _media = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _headerCard(context),
          //_paypalCard(context),
          _choiceText(),
          _carousel(context),
          _activityText(),
          _activityList(context),
        ],
      ),
    );
  }
}

Container _headerCard(context) {
  var balance = _HomeTabState.balance;

  var currentbalance, currentbalancestart, returnbalance;
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

  var _username = _HomeTabState._username;
  var profile = _HomeTabState.profile;
  final oCcy = new NumberFormat("#,##0", "en_US");

  final _media = MediaQuery.of(context).size;
  return Container(
    color: Colors.grey.shade50,
    height: _media.height / 1.7,
    child: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Stack(
                children: <Widget>[
                  Material(
                    elevation: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/bg2.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.3,
                    child: Container(
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(
              left: 20,
            ),
            height: _media.longestSide <= 775
                ? _media.height / 2.3
                : _media.height / 2.3,
            width: _media.width,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: GestureDetector(
                  /*onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OverviewPage())),*/
                  child: Material(
                    elevation: 1,
                    shadowColor: Colors.grey.shade300,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: _media.width - 40,
                          //height: 284,
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 30,
                            bottom: 30,
                          ),
                          /*child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Card no.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  card.cardNo,
                  style: Theme.of(context).textTheme.headline.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Expires",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(card.expiryDate,
                        style: Theme.of(context).textTheme.headline.copyWith(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                            ))
                  ],
                )
              ],
            ),*/
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                          'assets/images/Paypal-logo.png',
                                          height: 30),
                                      SizedBox(width: 20),
                                      Text(
                                        'BALANCE',
                                        style: TextStyle(
                                            color: PaypalColors.DarkBlue,
                                            fontFamily: "worksans",
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.info_outline, size: 18)
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Image.asset('assets/images/chip_thumb.png'),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            '\IDR',
                                            style: TextStyle(
                                                fontFamily: "vistolsans",
                                                fontSize: 25),
                                          ),
                                          SizedBox(width: 13),
                                          Text(
                                            oCcy.format(currentbalance),
                                            //"$currentbalance",
                                            style: TextStyle(
                                                fontFamily: "sfprotext",
                                                fontSize: 35),
                                          ),
                                          SizedBox(width: 0),
                                        ],
                                      ),
                                      Text(
                                        'My Investation',
                                        style: TextStyle(
                                            fontFamily: "worksans",
                                            color: PaypalColors.Grey,
                                            fontSize: 17),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'IDR',
                                            style: TextStyle(
                                                fontFamily: "vistolsans",
                                                fontSize: 15),
                                          ),
                                          SizedBox(width: 13),
                                          Text(
                                            '$returnbalance',
                                            style: TextStyle(
                                                fontFamily: "sfprotext",
                                                fontSize: 30),
                                          ),
                                          SizedBox(width: 0),
                                        ],
                                      ),
                                      Text(
                                        'Return',
                                        style: TextStyle(
                                            fontFamily: "worksans",
                                            color: PaypalColors.Grey,
                                            fontSize: 17),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    height: 25,
                                    child: FlatButton(
                                      color: PaypalColors.LightGrey,
                                      textColor: PaypalColors.DarkBlue,
                                      child: Text(
                                        //"Rala",
                                        profile[0]["firstName"] +
                                            " " +
                                            profile[0]["lastName"],
                                        style: TextStyle(
                                            fontFamily: "worksans",
                                            color: PaypalColors.DarkBlue,
                                            fontSize: 12),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute<Null>(
                                            builder: (BuildContext context) {
                                              return Profile();
                                            },
                                            fullscreenDialog: true,
                                          ),
                                        );
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: _media.longestSide <= 775
              ? screenAwareSize(20, context)
              : screenAwareSize(35, context),
          left: 10,
          right: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Hi, "+_username,
                      style: TextStyle(
                          fontSize: _media.longestSide <= 775 ? 35 : 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Varela"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Container _paypalCard(context) {
  var _username = _HomeTabState._username;
  return Container(
    margin: EdgeInsets.all(15),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
    decoration: BoxDecoration(
      color: Colors.white,
      border:
          Border.all(color: Colors.white, width: 0, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
      boxShadow: [
        BoxShadow(
            color: PaypalColors.LightGrey19,
            offset: Offset(0, 3),
            blurRadius: 6,
            spreadRadius: 1)
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset('assets/images/Paypal-logo.png', height: 30),
                SizedBox(width: 20),
                Text(
                  'BALANCE',
                  style: TextStyle(
                      color: PaypalColors.DarkBlue,
                      fontFamily: "worksans",
                      fontSize: 12),
                ),
              ],
            ),
            Icon(Icons.info_outline, size: 18)
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset('assets/images/chip_thumb.png'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '\IDR',
                      style: TextStyle(fontFamily: "vistolsans", fontSize: 25),
                    ),
                    SizedBox(width: 13),
                    Text(
                      '2.120.000',
                      style: TextStyle(fontFamily: "sfprotext", fontSize: 45),
                    ),
                    SizedBox(width: 0),
                  ],
                ),
                Text(
                  'My Investation',
                  style: TextStyle(
                      fontFamily: "worksans",
                      color: PaypalColors.Grey,
                      fontSize: 17),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'IDR',
                      style: TextStyle(fontFamily: "vistolsans", fontSize: 15),
                    ),
                    SizedBox(width: 13),
                    Text(
                      '300.000',
                      style: TextStyle(fontFamily: "sfprotext", fontSize: 30),
                    ),
                    SizedBox(width: 0),
                  ],
                ),
                Text(
                  'Return',
                  style: TextStyle(
                      fontFamily: "worksans",
                      color: PaypalColors.Grey,
                      fontSize: 17),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            SizedBox(
              height: 25,
              child: FlatButton(
                color: PaypalColors.LightGrey,
                textColor: PaypalColors.DarkBlue,
                child: Text(
                  _username,
                  style: TextStyle(
                      fontFamily: "worksans",
                      color: PaypalColors.DarkBlue,
                      fontSize: 12),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return Profile();
                      },
                      fullscreenDialog: true,
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            Spacer()
          ],
        ),
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
          'Transactions',
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

Container _activityList(context) {
  var transactions = _HomeTabState.transactions;
  var _isLoading = _HomeTabState._isLoading;
  final _media = MediaQuery.of(context).size;
  var amount, amountColor;

  return Container(
    child: NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
      },
      child: !_isLoading
          ? new CircularProgressIndicator()
          : ListView.builder(
              itemCount: transactions.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.all(15),
              itemBuilder: (BuildContext context, int index) {
                if (transactions[index]["typeTransaction"] == '1') {
                  //amount = "+ " + transactions[index]["Debit"];
                  var long2 = double.parse(transactions[index]["Debit"]);
                  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
                      amount: long2,
                      settings: MoneyFormatterSettings(
                        symbol: 'IDR',
                        thousandSeparator: '.',
                        decimalSeparator: ',',
                        symbolAndNumberSeparator: ' ',
                        fractionDigits: 0,
                      ));
                  MoneyFormatterOutput fo = fmf.output;
                  amount = "+ " + fo.symbolOnLeft;
                  amountColor = Colors.green;
                } else {
                  //amount = "- " + transactions[index]["Credit"];
                  var long2 = double.parse(transactions[index]["Credit"]);
                  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
                      amount: long2,
                      settings: MoneyFormatterSettings(
                        symbol: 'IDR',
                        thousandSeparator: '.',
                        decimalSeparator: ',',
                        symbolAndNumberSeparator: ' ',
                        fractionDigits: 0,
                      ));
                  MoneyFormatterOutput fo = fmf.output;
                  amount = "- " + fo.symbolOnLeft;
                  amountColor = Colors.red;
                }

                return Container(
                  margin: EdgeInsets.only(bottom: 5, top: 5),
                  decoration: _tileDecoration(),
                  child: ListTile(
                    leading:
                        Image.network(transactions[index]["logo"], width: 60),
                    title: Text(
                      transactions[index]["Name"],
                      style: TextStyle(
                          fontFamily: "worksans",
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    subtitle: Text(
                      transactions[index]["date2"],
                      style: TextStyle(
                          fontFamily: "worksans", fontWeight: FontWeight.w300),
                    ),
                    trailing: Text(
                      amount,
                      style:
                          TextStyle(fontFamily: "worksans", color: amountColor),
                    ),
                  ),
                );
              },

              /*children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 5, top: 5),
        decoration: _tileDecoration(),
        child: ListTile(
          leading: Image.asset('assets/images/users/Bank_Syariah_Mandiri.png',
              width: 60),
          title: Text(
            'Mandiri Syariah',
            style: TextStyle(
                fontFamily: "worksans",
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          subtitle: Text(
            'Mar 24, 2020',
            style:
                TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            '+200.000 IDR',
            style: TextStyle(fontFamily: "worksans"),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 5),
        decoration: _tileDecoration(),
        child: ListTile(
          leading: Container(
            width: 60,
            child: Image.asset('assets/images/users/Avrist.png'),
          ),
          title: Text(
            'Avrist Equity - Cross Sectoral',
            style: TextStyle(
                fontFamily: "worksans",
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          subtitle: Text(
            'Mar 16, 2020',
            style:
                TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            '+150.000 IDR',
            style: TextStyle(fontFamily: "worksans"),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: _tileDecoration(),
        child: ListTile(
          leading: Image.asset('assets/images/users/Bank_Syariah_Mandiri.png',
              width: 60),
          title: Text(
            'Mandiri Syariah',
            style: TextStyle(
                fontFamily: "worksans",
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          subtitle: Text(
            'Feb 16, 2020',
            style:
                TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            '-50.000 IDR',
            style: TextStyle(fontFamily: "worksans"),
          ),
        ),
      ),
    ],*/
            ),
    ),
  );
}

ListView _activityList2() {
  return ListView(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    padding: EdgeInsets.all(15),
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: _tileDecoration(),
        child: ListTile(
          leading: Image.asset('assets/images/users/Bank_Syariah_Mandiri.png'),
          title: Text(
            'Mandiri Syariah Reksa Dana',
            style: TextStyle(
                fontFamily: "worksans",
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          subtitle: Text(
            'Mar 10, 2020',
            style:
                TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            '-30,000',
            style: TextStyle(fontFamily: "worksans"),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: _tileDecoration(),
        child: ListTile(
          leading: Container(
            width: 42,
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
            'Feb 18, 2020',
            style:
                TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            '+50,000',
            style: TextStyle(fontFamily: "worksans"),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: _tileDecoration(),
        child: ListTile(
          leading: ClipOval(
            child: Container(
              color: PaypalColors.LightBlue,
              child: Image.asset(
                "assets/images/users/Avrist.png",
                fit: BoxFit.scaleDown,
                width: 35.0,
                height: 35.0,
              ),
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
            'Jan 11, 2020',
            style:
                TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            '-40,000',
            style: TextStyle(fontFamily: "worksans"),
          ),
        ),
      ),
    ],
  );
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
      /*child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: < Widget > [
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
      ),*/
    );
  }
}

Container _carousel(context) {
  var _isLoading = _HomeTabState._isLoading;
  var data = _HomeTabState.data;
  var users = getUsersCard();
  List<StockProduct> _stockproducts;

  final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];
  final _media = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(left: 25),
    height: screenAwareSize(_media.longestSide <= 775 ? 110 : 80, context),
    child: NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
      },
      child: !_isLoading
          ? new CircularProgressIndicator()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final stock = data[index];
                return Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Container(
                    alignment: Alignment.center,
                    width: 200.0,
                    height: 120.0,
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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.network(stock["logo"], height: 40),
                        /*CircleAvatar(
            backgroundImage: AssetImage(user.profilePic),
            radius: 25,
            backgroundColor: Color(0xfff1f3f5),
          ),*/
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            stock["Name"],
                            style: TextStyle(
                                inherit: true,
                                fontWeight: FontWeight.w500,
                                fontSize: 9.0,
                                color: Colors.grey),
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Text(
                            "Return " + stock["priceNAB"],
                            style: TextStyle(
                                inherit: true,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: Colors.green),
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    ),
  );
}

Container _carousel2(context) {
  final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];
  final _media = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(left: 25),
    height: screenAwareSize(_media.longestSide <= 775 ? 110 : 80, context),
    child: NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
      },
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: getUsersCard().length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
                padding: EdgeInsets.only(right: 10), child: AddButton());
          }

          return Padding(
            padding: EdgeInsets.only(right: 20),
            child: UserCardWidget(
              user: getUsersCard()[index - 1],
            ),
          );
        },
      ),
    ),
  );
}

Container _choiceText() {
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
          'The Product of Choice For You',
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

//KOMENTAR-PARTIAL-WIDGET

/*@override
Widget build(BuildContext context) {
  return Scaffold(
    
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () {
        setState(() {
          height = 300;
          width = MediaQuery.of(context).size.width - 15 * 2;
          topPositioned = -10;
        });
      },
      icon: Icon(Icons.payment),
      label: Text("$topPositioned"),
    ),
    body: Stack(
      children: <Widget>[
        AnimatedPositioned(
          curve: Curves.elasticOut,
          duration: Duration(milliseconds: 2800),
          child: AnimatedContainer(
            alignment: Alignment.center,
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            width: width,
            height: height,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showBackOfCard = !showBackOfCard;
                });
              },
              child: CreditCardWidget(
                cardNumber: "5124 8084 4590 3194",
                expiryDate: "01/25",
                cardHolderName: "Ayush Bherwani",
                cvvCode: "565",
                showBackView: showBackOfCard,
                cardBgColor: Colors.white,
                height: 175,
                textStyle: TextStyle(color: Colors.black),
                animationDuration: Duration(seconds: 1),
              ),
            ),
          ),
          top: topPositioned,
        )
      ],
    ),
  );
}*/
