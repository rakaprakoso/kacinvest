import 'package:flutter/material.dart';

import '../../util.dart';

class CardFrontLayout {
  String bankName;
  String bankLogo;
  String cardNumber;
  String cardExpiry;
  String cardHolderName;
  Widget cardTypeIcon;
  double cardWidth;
  double cardHeight;
  Color textColor;

  CardFrontLayout(
      {this.bankName = "",
      this.bankLogo = "",
      this.cardNumber = "",
      this.cardExpiry = "",
      this.cardHolderName = "",
      this.cardTypeIcon,
      this.cardWidth = 0,
      this.cardHeight = 0,
      this.textColor});

  Widget layout2(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      /*child: Container(
              decoration: BoxDecoration(
        color: Colors.blue,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.3), BlendMode.dstATop),
          image: AssetImage('assets/images/worldmap.png'),
          fit: BoxFit.cover,
        ),
      ),*/
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 60,
                child: Center(
                  child: Image.network(
                    bankLogo,
                    height: 50,
                    width: 90,
                  ),
                ),
              ),
              Container(
                height: 30,
                child: Center(
                  child: Text(
                    bankName,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: textColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              /*Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: new Image.asset(
                    'assets/images/bg2.jpg',
                    fit: BoxFit.fitHeight,
                    width: 30.0,
                    height: 30.0,
                    color: textColor,
                    package: 'awesome_card',
                  ),
                ),
              ),*/
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          cardNumber == null || cardNumber.isEmpty
                              ? 'XXXX XXXX XXXX XXXX'
                              : cardNumber,
                          style: TextStyle(
                              package: 'awesome_card',
                              color: textColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: "MavenPro",
                              fontSize: 22),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Exp. Date",
                              style: TextStyle(
                                  package: 'awesome_card',
                                  color: textColor,
                                  fontFamily: "MavenPro",
                                  fontSize: 15),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              cardExpiry == null || cardExpiry.isEmpty
                                  ? "MM/YY"
                                  : cardExpiry,
                              style: TextStyle(
                                  package: 'awesome_card',
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "MavenPro",
                                  fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    cardTypeIcon
                  ],
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  cardHolderName == null || cardHolderName.isEmpty
                      ? "Card Holder"
                      : cardHolderName,
                  style: TextStyle(
                      package: 'awesome_card',
                      color: textColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "MavenPro",
                      fontSize: 17),
                ),
              ),
              Container(
                height: 25,
                child: FlatButton(
                  color: PaypalColors.LightGrey,
                  textColor: PaypalColors.DarkBlue,
                  child: Text(
                    //"$name",
                    "Graph",
                    style: TextStyle(
                        fontFamily: "worksans",
                        color: PaypalColors.DarkBlue,
                        fontSize: 12),
                  ),
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget layout1(context) {
    final _media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset('assets/images/Paypal-logo.png',
                                height: 30),
                            SizedBox(width: 20),
                            Text(
                              'BALANCE',
                              style: TextStyle(
                                  color: Colors.black,
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
                                  style: TextStyle(
                                      fontFamily: "vistolsans", fontSize: 25),
                                ),
                                SizedBox(width: 13),
                                Text(
                                  // "$amount",
                                  //oCcy.format(currentbalance),
                                  //"$currentbalance",
                                  "Duit",
                                  style: TextStyle(
                                      fontFamily: "sfprotext", fontSize: 35),
                                ),
                                SizedBox(width: 0),
                              ],
                            ),
                            Text(
                              'My Investation',
                              style: TextStyle(
                                  fontFamily: "worksans",
                                  //color: Colors.Gray,
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
                                      fontFamily: "vistolsans", fontSize: 15),
                                ),
                                SizedBox(width: 13),
                                Text(
                                  "DUITT",
                                  //oCcy.format(j),
                                  //'$returnbalance',
                                  //"$amount2",
                                  style: TextStyle(
                                      fontFamily: "sfprotext", fontSize: 30),
                                ),
                                SizedBox(width: 0),
                              ],
                            ),
                            Text(
                              'Return',
                              style: TextStyle(
                                  fontFamily: "worksans",
                                  //color: PaypalColors.Grey,
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
                            //color: PaypalColors.LightGrey,
                            //textColor: PaypalColors.DarkBlue,
                            child: Text(
                              //"$name",
                              "Rala",
                              //profile[0]["firstName"] +
                              // " " +
                              //  profile[0]["lastName"],
                              //profile[0]["firstName"],
                              style: TextStyle(
                                  fontFamily: "worksans",
                                  //color: PaypalColors.DarkBlue,
                                  fontSize: 12),
                            ),
                            onPressed: () {
                              /*  Navigator.of(context).push(
                                                MaterialPageRoute<Null>(
                                                  builder:
                                                      (BuildContext context) {
                                                    return Profile();
                                                  },
                                                  fullscreenDialog: true,
                                                ),
                                              );*/
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
