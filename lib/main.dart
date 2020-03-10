import 'package:flutter/material.dart';
import 'package:kacinvest/screens/app.dart';

void main() => runApp(KacinvestApp());

class KacinvestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}