import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
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


class CalculatorTab extends StatefulWidget {
  
  @override
  _CalculatorTabState createState() => _CalculatorTabState();
}

class _CalculatorTabState extends State < CalculatorTab >{
  double totalMoney = 0.0;
  double usdCurrency = 14094.50;
  double euroCurrency = 15749.45;

  @override
  Widget build(BuildContext context){
    //input filed to store bill amount
    TextField usdtoidr = TextField(
      decoration: InputDecoration(labelText: "Total Money - USD to IDR"),
      keyboardType: TextInputType.number,
      onChanged: (String value){
        try {
          totalMoney = double.parse(value);
        } catch (exception){
          totalMoney = 0.0;
        }
      },
    );

    TextField eurotoidr = TextField(
      decoration: InputDecoration(labelText: "Total Money - Euro to IDR"),
      keyboardType: TextInputType.number,
      onChanged: (String value){
        try {
          totalMoney = double.parse(value);
        } catch (exception){
          totalMoney = 0.0;
        }
      },
    );

    //Button to do calculation
    RaisedButton calculateButtonUSD = RaisedButton(
      child: Text("Calculate"),
      onPressed: (){  //must be implemented
          double total = totalMoney * usdCurrency;

          AlertDialog dialog = AlertDialog(
            content: Text("Currency = $usdCurrency\n$totalMoney USD = $total IDR"),
          );

          showDialog(context: context,
            builder: (BuildContext context) => dialog);
      },
    );

        RaisedButton calculateButtonEURO = RaisedButton(
      child: Text("Calculate"),
      onPressed: (){  //must be implemented
          double total = totalMoney * euroCurrency;

          AlertDialog dialog = AlertDialog(
            content: Text("Currency = $euroCurrency\n$totalMoney Euro = $total IDR"),
          );

          showDialog(context: context,
            builder: (BuildContext context) => dialog);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Currency Converter"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            usdtoidr,
            //tipPercentageField,
            calculateButtonUSD,
            eurotoidr,
            calculateButtonEURO,
          ],
        ),
      ),
    );
  }
}