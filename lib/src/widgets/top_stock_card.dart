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
        //width: 165,
        //height: 180,
        child: Column(
          //fit: StackFit.expand,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                child: Container(
                  width: 160,
                  height: 170,
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
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.network(
                          imgUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 60,
                          width: 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
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

                      ],
                    ),
                  ),
                ),
              ),
            ),

            /*Positioned(
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
            ),*/
          ],
        ),
      ),
    );
  }
}
