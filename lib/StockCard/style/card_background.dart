import 'package:flutter/material.dart';

class CardBackgrounds {
  CardBackgrounds._();

  static Widget black = new Container(
    width: double.maxFinite,
    height: double.maxFinite,
    color: Color(0xff0B0B0F),
  );

  static Widget white = new Container(
    width: double.maxFinite,
    height: double.maxFinite,
    //color: Color(0xffF9F9FA),
    decoration: BoxDecoration(
      color: Colors.grey,
      image: DecorationImage(
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.3), BlendMode.dstATop),
        image: AssetImage('assets/images/worldmap.png'),
        fit: BoxFit.cover,
      ),
    ),
  );

  static Widget gray = new Container(
    width: double.maxFinite,
    height: double.maxFinite,
    color: Color(0xffF9F9FA),
  );

}
