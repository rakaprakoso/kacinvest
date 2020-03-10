import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'search_bar.dart';

class SearchPageKacinvest extends StatefulWidget {
  SearchPageKacinvest();

  createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPageKacinvest> with SingleTickerProviderStateMixin {
  SearchPageState();

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
        child: new Container(), // Add search body here
      ),
    ));
  }
}