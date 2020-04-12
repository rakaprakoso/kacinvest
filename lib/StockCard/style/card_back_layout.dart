import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:kacinvest/data/account.dart';
import 'package:kacinvest/pages/main_page.dart';
import 'package:kacinvest/screens/app.dart';

class CardBackLayout {
  int cardIndex;
  String cvv;
  double width;
  double height;
  Color color;
  List<double> charts;
  List<List<double>> chartsss;

  List<double> doubleList;

  var data = [0.0, 1.0, 10.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  var chartFIX = accountBloc.productChart;
  var stock=MenuDashboardPage.listStock;
  var chartss = MyInvestment.chartss;
  var chart = MyInvestment.charts;
  var chart2 = MyInvestment.charts2;
  CardBackLayout({this.cardIndex, this.cvv, this.width, this.height, this.color, this.charts});




  Widget layout1() {
    int index = stock.indexOf('${cvv}');

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /*SizedBox(
          height: 30,
        ),
        Container(
          color: Colors.black,
          height: 50,
          width: width,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: (width / 4) * 3,
              height: 50,
              color: Colors.grey,
            ),
            Container(
              height: 50,
              width: width / 4,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  cvv.toString(),
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                    color: color
                  ),
                ),
              ),
            ),
          ],
        ),*/
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                child: Sparkline(
                  //data: chartsss[cardIndex],
                  data: chartFIX[index],
                  lineWidth: 5.0,
                  pointsMode: PointsMode.last,
                  pointSize: 6.0,
                  pointColor: Colors.blueGrey,
                  fillMode: FillMode.below,
                  fillColor: Colors.lightGreen,
                  lineColor: Colors.lightGreen,
                ),
              ),
              Text('${cvv}'),
              Text('${stock}'),
               Text('${cardIndex}'),
              //Text('${chartsss[0]}'),
              //Text(chartsss[1]),
            ],
          ),
        ),
      ],
    );
  }
}
