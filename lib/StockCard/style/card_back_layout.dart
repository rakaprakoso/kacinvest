import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class CardBackLayout {
  String cvv;
  double width;
  double height;
  Color color;
  var data = [0.0, 1.0, 10.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

  CardBackLayout({this.cvv, this.width, this.height, this.color});

  Widget layout1() {
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
          child : Container(
            child: new Sparkline(
              data: data,
            ),
          ),
        ),
      ],
    );
  }
}
