import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:kacinvest/src/data/data.dart';
import 'package:kacinvest/src/widgets/credit_card.dart';
import 'package:kacinvest/src/widgets/credit_cardHome.dart';
import 'package:kacinvest/src/widgets/search_bar_android.dart';
import 'package:kacinvest/src/widgets/user_card.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

import 'package:kacinvest/util.dart';
import 'package:kacinvest/Tab/profile.dart';

import 'package:flutter/cupertino.dart';
import 'package:kacinvest/src/widgets/search_bar.dart';


class MarketTab extends StatefulWidget {
  
  @override
  _MarketTabState createState() => _MarketTabState();
}

class _MarketTabState extends State < MarketTab > with SingleTickerProviderStateMixin{
  _MarketTabState();

TextEditingController _searchTextController = new TextEditingController();
  FocusNode _searchFocusNode = new FocusNode();
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });
  }

  void _cancelSearch() {
    _searchTextController.clear();
    _searchFocusNode.unfocus();
    _animationController.reverse();
  }

  void _clearSearch() {
    _searchTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return  new Scaffold(body: new CupertinoPageScaffold(
      navigationBar: new CupertinoNavigationBar(
        middle: new IOSSearchBar(
          controller: _searchTextController,
          focusNode: _searchFocusNode,
          animation: _animation,
          onCancel: _cancelSearch,
          onClear: _clearSearch,
        ),
      ),
      child: new GestureDetector(
        onTapUp: (TapUpDetails _) {
          _searchFocusNode.unfocus();
          if (_searchTextController.text == '') {
            _animationController.reverse();
          }
        },
        child: new Container(
          margin: EdgeInsets.only(top: 50),
          //child: _activityText(),
          child: _activityList(),
          
        ), // Add search body here
      ),
    ));
  }
/*
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return SingleChildScrollView(
      
      child: Column(
        children: < Widget > [
          
          _activityText(),
          _activityList(),
        ],
      ),
    );
  }*/
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
          'Activity',
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
          
          leading: Container(
            width: 60,
            child :Image.asset('assets/images/users/Bank_Syariah_Mandiri.png'),
          ),
          title: Text(
            'Mandiri Syariah Reksa Dana',
            style: TextStyle(
              fontFamily: "worksans",
              fontWeight: FontWeight.w500,
              color: Colors.black),
          ),
          subtitle: Text(
            'Reksa Dana Pendapatan Tetap',
            style:
            TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            'Return\n7%',
            textAlign: TextAlign.right,
            style: TextStyle(fontFamily: "worksans"),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: _tileDecoration(),
        child: ListTile(
          leading: Container(
            width: 60,
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
            'Reksa Dana Campuran',
            style:
            TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            'Return\n3.45%',
            textAlign: TextAlign.right,
            style: TextStyle(fontFamily: "worksans"),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: _tileDecoration(),
        child: ListTile(
          leading: Container(
            
              width: 60,
              child: Image.asset(
                "assets/images/users/Avrist.png",
                fit: BoxFit.scaleDown,
                width: 35.0,
                height: 35.0,
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
            'Reksa Dana Saham',
            style:
            TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            'Return\n4.5%',
            textAlign: TextAlign.right,
            style: TextStyle(fontFamily: "worksans"),
          ),
        ),
      ),
    ],
  );
}



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
          leading: Image.asset('assets/images/Nike.png'),
          title: Text(
            'Nike Medieval',
            style: TextStyle(
              fontFamily: "worksans",
              fontWeight: FontWeight.w500,
              color: Colors.black),
          ),
          subtitle: Text(
            'Jan 21, 2019',
            style:
            TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            '-249,99 USD',
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
            child: Image.asset('assets/images/if_9_avatar_2754584.png'),
          ),
          title: Text(
            'Lagertha Lothbrok',
            style: TextStyle(
              fontFamily: "worksans",
              fontWeight: FontWeight.w500,
              color: Colors.black),
          ),
          subtitle: Text(
            'Jan 18, 2019',
            style:
            TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            '+102,00 USD',
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
                "assets/images/icon_shop.png",
                fit: BoxFit.scaleDown,
                width: 35.0,
                height: 35.0,
              ),
            ),
          ),
          title: Text(
            'Spotify Finance Limited',
            style: TextStyle(
              fontFamily: "worksans",
              fontWeight: FontWeight.w500,
              color: Colors.black),
          ),
          subtitle: Text(
            'Jan 11, 2019',
            style:
            TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: Text(
            '-9,99 USD',
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
      child: Column(
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
      ),
    );
  }
}