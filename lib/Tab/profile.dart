import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:kacinvest/util.dart';
import 'package:community_material_icon/community_material_icon.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var index = 0;
  bool isExpanded = false;
  double _width = 0;
  int cek = 0;
  double size = 0;
  double _opacity = 0;
  bool _isVisible = true;
  Timer _timer;

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size2 = MediaQuery.of(context).size.height;
    var title = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 20,
      color: Colors.white,
      //fontWeight: FontWeight.w700,
    );
    var subtitle = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      color: Colors.white,
    );
    return Container(
      decoration: BoxDecoration(
        color: PaypalColors.Orange,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Material(
              elevation: 10,
              borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(50.0),
                  bottomRight: const Radius.circular(50.0)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(50.0),
                      bottomRight: const Radius.circular(50.0)),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Image.asset('assets/images/if_1_avatar_2754574.png',
                        scale: 2.2),
                    Text(
                      'Raka D. Prakoso',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: PaypalColors.Orange),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: FlatButton(
                        color: PaypalColors.LightGrey,
                        textColor: PaypalColors.DarkBlue,
                        child: Text(
                          'Referral Code :\nKC1602',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "worksans",
                              color: PaypalColors.DarkBlue,
                              fontSize: 14),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<Null>(
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
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        if (cek == 0) {
                          _width = size2 * 0.7;
                          cek = 1;
                        } else {
                          _opacity = 0;
                          cek = 0;
                        }
                      });
                      _timer = new Timer(const Duration(milliseconds: 400), () {
                        setState(() {
                          if (cek == 0) {
                            _width = 0;
                          } else {
                            _opacity = 1;
                          }
                        });
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "View",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                                    MaterialButton(
                    onPressed: () {
                      setState(() {
                        if (cek == 0) {
                          _width = size2 * 0.7;
                          cek = 1;
                        } else {
                          _opacity = 0;
                          cek = 0;
                        }
                      });
                      _timer = new Timer(const Duration(milliseconds: 400), () {
                        setState(() {
                          if (cek == 0) {
                            _width = 0;
                          } else {
                            _opacity = 1;
                          }
                        });
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 600),
              height: _width,
              curve: Curves.fastOutSlowIn,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 550),
                opacity: _opacity,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Date of Birth",
                        style: title,
                      ),
                      Text(
                        "Jepara, 16 February 2000",
                        style: subtitle,
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Phone Number",
                        style: title,
                      ),
                      Text(
                        "081 225 775 222",
                        style: subtitle,
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Email",
                        style: title,
                      ),
                      Text(
                        "rakaprakoso@kacinvest.com",
                        style: subtitle,
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Address",
                        style: title,
                      ),
                      Text(
                        "Cikarang Utara",
                        style: subtitle,
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Bank Account",
                        style: title,
                      ),
                      Text(
                        "12312312312",
                        style: subtitle,
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "E-Mail",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      // contentPadding: EdgeInsets.only(top: 40, bottom: 20),
                      suffixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 18, start: 50),
                        child: Icon(Icons.chevron_right, color: Colors.white),
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: "worksans",
                        color: Colors.white,
                        fontSize: 18),
                    initialValue: "rakaprakoso@kacinvest.com",
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Account Numbers",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      // contentPadding: EdgeInsets.only(top: 40, bottom: 20),
                      suffixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 18, start: 50),
                        child: Icon(Icons.chevron_right, color: Colors.white),
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: "worksans",
                        color: Colors.white,
                        fontSize: 18),
                    initialValue: "1602 7877 5554",
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Addresses",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      // contentPadding: EdgeInsets.only(top: 40, bottom: 20),
                      suffixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 18, start: 50),
                        child: Icon(Icons.chevron_right, color: Colors.white),
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: "worksans",
                        color: Colors.white,
                        fontSize: 18),
                    initialValue: "Cikarang, Bekasi",
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 140,
              child: FlatButton(
                color: PaypalColors.LightGrey,
                textColor: PaypalColors.DarkBlue,
                child: Text(
                  "Log Out",
                  style: TextStyle(
                      fontFamily: "worksans",
                      color: PaypalColors.DarkBlue,
                      fontSize: 18),
                ),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding profileInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ExpansionPanelList(
        animationDuration: Duration(seconds: 1),
        children: [
          ExpansionPanel(
            body: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
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
                        onPressed: null, //_doConversion,
                      ),
                    ),
                    Text(
                      "Money should invest each month",
                    ),
                    Chip(
                      label: Text(
                        "Cek",
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
