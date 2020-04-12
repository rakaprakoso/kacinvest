import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:kacinvest/custom_icon/kacinvest_icon2_icons.dart';

import 'setting.dart';
import 'main_data.dart';

class AccountBloc extends BloCSetting {
  String username = '';
  double currentbalance, currentbalancestart, returnbalance, returnpercentage;
  String currentbalanceS, currentbalancestartS, returnbalanceS, returnpercentageS;
  var returnIcon;

  var balance;
  var transactions;

  List<List<double>> productChart = [];
  //List<double> doubletemp = [];

  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
      amount: 0,
      settings: MoneyFormatterSettings(
        symbol: 'IDR',
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
      ));

  loadBalance(state, _balance) {
    rebuildWidgets(
      setStates: () {
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
        returnpercentage=returnbalance/currentbalancestart*100;
        returnpercentageS =returnpercentage.toStringAsFixed(2) + " %";
        currentbalanceS = fmf.copyWith(amount: currentbalance,).output.symbolOnLeft;
        currentbalancestartS = fmf.copyWith(amount: currentbalancestart,).output.symbolOnLeft;
        returnbalanceS = fmf.copyWith(amount: returnbalance,).output.symbolOnLeft;
        if(returnpercentage>0)
        returnIcon = KacinvestIcon2.angle_double_up;
        else
        returnIcon = KacinvestIcon2.angle_double_down;
      },
      states: [state],
    );
    //mainBloc.username = username;
  }

    loadTransactions(state, _transactions) {
    rebuildWidgets(
      setStates: () {
        transactions = _transactions;
      },
      states: [state],
    );
    //mainBloc.username = username;
  }

    addGraphic(state, _temp) {
    rebuildWidgets(
      setStates: () {
        productChart.add(_temp);
      },
      states: [state],
    );
    //mainBloc.username = username;
  }


      

  incrementCounter(state, _username) {
    rebuildWidgets(
      setStates: () {
        username = _username;
      },
      states: [state],
    );
    mainBloc.username = username;
  }
}

AccountBloc accountBloc;
