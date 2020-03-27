import 'package:flutter/material.dart';
import 'package:kacinvest/Tab/home_tab.dart';
import 'package:kacinvest/Tab/profile.dart';
import 'package:kacinvest/src/models/credit_card_model.dart';
import 'package:kacinvest/src/models/profile_model.dart';

import '../../util.dart';

class CreditCardHome extends StatelessWidget {
  var profile = HomeTab.profile;
  //final CreditCardModel card;
  @override
  void initState() {
    // TODO: implement initState


        print(profile);
        print(profile.length);

  }

  



  @override
  Widget build(BuildContext context) {
    var profile = HomeTab.profile;
    final _media = MediaQuery.of(context).size;
    return Material(
      elevation: 1,
      shadowColor: Colors.grey.shade300,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: < Widget > [
          Container(
            width: _media.width - 40,
            //height: 284,
            padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30,),
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
              children: < Widget > [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: < Widget > [
                    Row(
                      children: < Widget > [
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
                  children: < Widget > [
                    Image.asset('assets/images/chip_thumb.png'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: < Widget > [
                        Row(
                          children: < Widget > [
                            Text(
                              '\IDR',
                              style: TextStyle(fontFamily: "vistolsans", fontSize: 25),
                            ),
                            SizedBox(width: 13),
                            Text(
                              '2.120.000',
                              style: TextStyle(fontFamily: "sfprotext", fontSize: 35),
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
                  children: < Widget > [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: < Widget > [
                        Row(
                          children: < Widget > [
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
                  children: < Widget > [
                    SizedBox(
                      height: 25,
                      child: FlatButton(
                        color: PaypalColors.LightGrey,
                        textColor: PaypalColors.DarkBlue,
                        child: Text(
                          //"Rala",
                          profile,
                          style: TextStyle(
                            fontFamily: "worksans",
                            color: PaypalColors.DarkBlue,
                            fontSize: 12),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute < Null > (
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
          ),
        ],
      ),
    );
  }
}