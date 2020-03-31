import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imgUrl;
  final String name;
  //final int color;

  ProductCard({this.name, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: Container(
        width: 165,
        height: 170,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          offset: Offset(0, 10),
                          blurRadius: 12,
                        )
                      ]),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Image.network(
                imgUrl,
                width: 130,
                height: 100,
                fit: BoxFit.contain,
              ),
              
            ),
            Positioned(
              left: 30,
              bottom: 20,
              //top:100,
              child: Container(
                width: 105,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      //overflow: TextOverflow.fade, /*style: productTitleStyle*/
                    ),
                    Text(
                      "Return 5%",
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
