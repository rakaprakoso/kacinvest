import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:kacinvest/Tab/shop_tab.dart';
import 'package:kacinvest/src/data/data.dart';
import 'package:kacinvest/src/widgets/credit_card.dart';
import 'package:kacinvest/src/widgets/credit_cardHome.dart';
import 'package:kacinvest/src/widgets/search_bar_android.dart';
import 'package:kacinvest/src/widgets/user_card.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

import 'package:kacinvest/util.dart';
import 'package:kacinvest/Tab/profile.dart';

import 'package:flutter/cupertino.dart';
import 'package:kacinvest/src/widgets/search_bar.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class CalculatorTab extends StatefulWidget {
  @override
  _CalculatorTabState createState() => _CalculatorTabState();
}

class _CalculatorTabState extends State<CalculatorTab> {
  double totalMoney = 0.0;
  double usdCurrency = 14094.50;
  double euroCurrency = 15749.45;

  @override
  Widget build(BuildContext context) {
    //input filed to store bill amount
    TextField usdtoidr = TextField(
      decoration: InputDecoration(labelText: "Total Money - USD to IDR"),
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        try {
          totalMoney = double.parse(value);
        } catch (exception) {
          totalMoney = 0.0;
        }
      },
    );

    TextField eurotoidr = TextField(
      decoration: InputDecoration(labelText: "Total Money - Euro to IDR"),
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        try {
          totalMoney = double.parse(value);
        } catch (exception) {
          totalMoney = 0.0;
        }
      },
    );

    //Button to do calculation
    RaisedButton calculateButtonUSD = RaisedButton(
      child: Text("Calculate"),
      onPressed: () {
        //must be implemented
        double total = totalMoney * usdCurrency;

        AlertDialog dialog = AlertDialog(
          content:
              Text("Currency = $usdCurrency\n$totalMoney USD = $total IDR"),
        );

        showDialog(context: context, builder: (BuildContext context) => dialog);
      },
    );

    RaisedButton calculateButtonEURO = RaisedButton(
      child: Text("Calculate"),
      onPressed: () {
        //must be implemented
        double total = totalMoney * euroCurrency;

        AlertDialog dialog = AlertDialog(
          content:
              Text("Currency = $euroCurrency\n$totalMoney Euro = $total IDR"),
        );

        showDialog(context: context, builder: (BuildContext context) => dialog);
      },
    );

    return Container(
      child: SingleChildScrollView(
        child: Column(
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
                                    "Calculate Your Life",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontFamily: "SF-Pro-Display-Bold"),
                                  ),
                                  Text(
                                    "Calculator",
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
                  /*Positioned(
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
                                                        .contains(string
                                                            .toLowerCase()) ||
                                                    u.stockID
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
                      )*/
                ],
              ),
            ),

            //usdtoidr,
            //tipPercentageField,
            //calculateButtonUSD,
            //eurotoidr,
            //calculateButtonEURO,
            Calc(),
            Calc2(),
            //InvestCalc(),
            //CurrencyConverter2(),

            //CurrencyConverter(),
          ],
        ),
      ),
    );
  }
}

class CurrencyConverter2 extends StatefulWidget {
  @override
  _CurrencyConverterState2 createState() => _CurrencyConverterState2();
}

class _CurrencyConverterState2 extends State<CurrencyConverter2> {
  final fromTextController = TextEditingController();
  List<String> currencies;
  String fromCurrency = "Euro";
  String toCurrency = "Euro";
  String result;
  List<String> currenciesName = [];
  List<String> currenciesSymbol = [];
  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
      amount: 0,
      settings: MoneyFormatterSettings(
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 2,
      ));
  var amount;

  @override
  void initState() {
    super.initState();
    _loadCurrencies();
  }

  Future<String> _loadCurrencies() async {
    int i = 0;
    String uri =
        "https://free.currconv.com/api/v7/currencies?apiKey=14c7447be7ab853549f2";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    Map curMap = responseBody['results'];
    //Map curMap2 = curMap['ALL'];
    currencies = curMap.keys.toList();
    setState(() {});
    print(curMap);
    print(curMap.length);
    print(currencies);
    print(curMap);

    print(curMap['IDR']['currencyName']);
    while (i < curMap.length) {
      String j = currencies[i];
      currenciesName.add(curMap[j]['currencyName']);
      currenciesSymbol.add(curMap[j]['currencySymbol']);
      //print(curMap[j]['currencyName']);
      i++;
    }
    print(currenciesName);
    return "Success";
  }

  Future<String> _doConversion() async {
    //String uri = "http://api.openrates.io/latest?base=$fromCurrency&symbols=$toCurrency";
    //var i = ;
    int i = currenciesName.indexOf(fromCurrency);

    var fromCurrency1 = currencies[i];
    int j = currenciesName.indexOf(toCurrency);

    var toCurrency1 = currencies[j];
    int k = currenciesName.indexOf(toCurrency);
    var symbol = currenciesSymbol[j];

    String uri = "https://free.currconv.com/api/v7/convert?q=$fromCurrency1" +
        "_$toCurrency1&compact=ultra&apiKey=14c7447be7ab853549f2";

    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      result = (double.parse(fromTextController.text) *
              (responseBody["$fromCurrency1" + "_$toCurrency1"]))
          .toStringAsFixed(2);

      double result2 = (double.parse(fromTextController.text) *
          (responseBody["$fromCurrency1" + "_$toCurrency1"]));

      amount = fmf
          .copyWith(
            amount: result2,
          )
          .output
          .nonSymbol;

      /*result = (double.parse(fromTextController.text) *
              (responseBody["$fromCurrency1" + "_$toCurrency1"]))
          .toStringAsFixed(2)
          .toString();*/
      symbol != null
          ? result = symbol + " " + amount
          : result = toCurrency1 + " " + amount;
      //result = symbol + " " + amount;
    });
    print(result);
    return "Success";
  }

  _onFromChanged(String value) {
    setState(() {
      //int i = currenciesName.indexOf(value);

      //fromCurrency = currencies[i];
      fromCurrency = value;
    });
  }

  _onToChanged(String value) {
    setState(() {
      //int i = currenciesName.indexOf(value);

      //toCurrency = currencies[i];
      toCurrency = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: currencies == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextField(
                    controller: fromTextController,
                    decoration: new InputDecoration(
                      labelText: "Input the Amount",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "From",
                  ),
                  _buildDropDownButton(fromCurrency),
                  Text(
                    "To",
                  ),
                  _buildDropDownButton(toCurrency),
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    //heightFactor: 0.5,
                    child: MaterialButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.arrow_downward),
                          Text("Convert"),
                        ],
                      ),
                      onPressed: _doConversion,
                    ),
                  ),
                  Chip(
                    label: result != null
                        ? Text(
                            result,
                            style: Theme.of(context).textTheme.display1,
                          )
                        : Text(""),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildDropDownButton(String currencyCategory) {
    return DropdownButton(
      value: currencyCategory,
      items: currenciesName
          .map((String value) => DropdownMenuItem(
                value: value,
                child: Row(
                  children: <Widget>[
                    Text(value),
                  ],
                ),
              ))
          .toList(),
      onChanged: (String value) {
        if (currencyCategory == fromCurrency) {
          _onFromChanged(value);
        } else {
          _onToChanged(value);
        }
      },
    );
  }
}

class Calc extends StatefulWidget {
  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ExpansionPanelList(
        animationDuration: Duration(seconds: 1),
        children: [
          ExpansionPanel(
            body: CurrencyConverter2(),
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Currency Converter",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            },
            isExpanded: isExpanded,
          )
        ],
        expansionCallback: (int item, bool status) {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
      ),
    );
  }
}

class InvestCalc extends StatefulWidget {
  @override
  _InvestCalcState createState() => _InvestCalcState();
}

class _InvestCalcState extends State<InvestCalc> {
  final targetTextController = TextEditingController();
  final beginningTextController = TextEditingController();
  final durationTextController = TextEditingController();
  final returnTextController = TextEditingController();

  List<String> currencies;
  String fromCurrency = "Euro";
  String toCurrency = "Euro";
  String result;
  String msg;
  List<String> currenciesName = [];
  List<String> currenciesSymbol = [];
  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
      amount: 0,
      settings: MoneyFormatterSettings(
        symbol: 'IDR',
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
      ));
  var amount;

  @override
  void initState() {
    super.initState();
  }

  Future<String> _doConversion() async {




  

    setState(() {

      if (targetTextController.text == '' ||
          beginningTextController.text == '' ||
          durationTextController.text == '' ||
          returnTextController.text == '') {
        result = "Please, Input All Form!";
      } else {
        String nums = targetTextController.text;
    String nums2 = beginningTextController.text;
  List values = nums.split(".");
  List values2 = nums2.split(".");
  var concatenate = StringBuffer();
  var concatenate2 = StringBuffer();

  values.forEach((item){
    concatenate.write(item);
  });
  values2.forEach((item){
    concatenate2.write(item);
  });
      double B1 = double.parse(concatenate2.toString());
      double B2 = double.parse(concatenate.toString());

      double B3 = double.parse(returnTextController.text) / 100;
      double B4 = 12;
      double B5 = double.parse(durationTextController.text);

      double a = B1 * pow((1 + B3 / B4), (B4 * B5));
      double b = B2 - a;
      double c = (b / ((pow((1 + B3 / B4), (B4 * B5)) - 1) / (B3 / B4)));

      amount = fmf
          .copyWith(
            amount: c,
          )
          .output
          .symbolOnLeft;

      /*result = (double.parse(fromTextController.text) *
              (responseBody["$fromCurrency1" + "_$toCurrency1"]))
          .toStringAsFixed(2)
          .toString();*/

      result = amount;
}
      //result = symbol + " " + amount;
    });
    print(result);
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextField(
              controller: targetTextController,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                // Fit the validating format.
                //fazer o formater para dinheiro
                new CurrencyInputFormatter()
              ],
              decoration: new InputDecoration(
                labelText: "Target Money",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  borderSide: new BorderSide(),
                ),

                //fillColor: Colors.green
              ),
              style: TextStyle(fontSize: 15.0, color: Colors.black),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            TextField(
              controller: beginningTextController,
                            inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                // Fit the validating format.
                //fazer o formater para dinheiro
                new CurrencyInputFormatter()
              ],
              decoration: new InputDecoration(
                labelText: "Beginning Money",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              style: TextStyle(fontSize: 15.0, color: Colors.black),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            TextField(
              controller: durationTextController,
              decoration: new InputDecoration(
                labelText: "Duration (Years)",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              style: TextStyle(fontSize: 15.0, color: Colors.black),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            TextField(
              controller: returnTextController,
              decoration: new InputDecoration(
                labelText: "Return % / Year",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              style: TextStyle(fontSize: 15.0, color: Colors.black),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 15),
            FractionallySizedBox(
              widthFactor: 0.5,
              //heightFactor: 0.5,
              child: MaterialButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.arrow_downward),
                    Text("Calculate"),
                  ],
                ),
                onPressed: _doConversion,
              ),
            ),
            Text(
              "Money should invest each month",
            ),
            Chip(
              label: result != null
                  ? Text(
                      result,
                      style: Theme.of(context).textTheme.display1,
                    )
                  : Text(""),
            ),
          ],
        ),
      ),
    );
  }
}

class Calc2 extends StatefulWidget {
  @override
  _CalcState2 createState() => _CalcState2();
}

class _CalcState2 extends State<Calc2> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ExpansionPanelList(
        animationDuration: Duration(seconds: 1),
        children: [
          ExpansionPanel(
            body: InvestCalc(),
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Investment Calculator",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            },
            isExpanded: isExpanded,
          )
        ],
        expansionCallback: (int item, bool status) {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
      ),
    );
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
