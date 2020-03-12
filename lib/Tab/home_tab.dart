import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:kacinvest/src/data/data.dart';
import 'package:kacinvest/src/widgets/credit_card.dart';
import 'package:kacinvest/src/widgets/credit_cardHome.dart';
import 'package:kacinvest/src/widgets/user_card.dart';


import 'package:kacinvest/util.dart';
import 'package:kacinvest/Tab/profile.dart';


class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class CardData {
  static double topPositioned = 700;
  static double height = 0;
  static double width = 0;
  static bool showBackOfCard = false;
  static String oneAsString = topPositioned.toString();
  static double widthScreen = MediaQuery.of(context).size.width;

  static BuildContext context;
}

class _HomeTabState extends State < HomeTab > {
  var height = CardData.height;
  var topPositioned = CardData.topPositioned;
  var width = CardData.width;
  var showBackOfCard = CardData.showBackOfCard;
  var oneAsString = CardData.oneAsString;


  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: < Widget > [
          _headerCard(context),
          //_paypalCard(context),
          _choiceText(),
          _carousel(context),
          _activityText(),
          //_activityList(),
        ],
      ),
    );
  }
}

Container _headerCard(context){
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
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowGlow();
                      },
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 10),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: getCreditCards().length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              /*onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OverviewPage())),*/
                              child: CreditCardHome(
                                card: getCreditCards()[index],
                              ),
                            ),
                          );
                        },
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
                              "Overview",
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
                  "MR.RAKA D PRAKOSO",
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
      children: < Widget > [
        Text(
          'Transactions',
          style: TextStyle(
            fontFamily: "worksans",
            fontSize: 15,
            fontWeight: FontWeight.w600),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: < Widget > [
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

ListView _activityList() {
  return ListView(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    padding: EdgeInsets.all(15),
    children: < Widget > [
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
            '- 30,000',
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
  final List < int > numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];
  final _media = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(left: 25),
    height: screenAwareSize(
      _media.longestSide <= 775 ? 110 : 80, context),
    child: NotificationListener < OverscrollIndicatorNotification > (
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
              padding: EdgeInsets.only(right: 10),
              child: AddButton());
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
      children: < Widget > [
        Text(
          'The Product of Choice For You',
          style: TextStyle(
            fontFamily: "worksans",
            fontSize: 15,
            fontWeight: FontWeight.w600),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: < Widget > [
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