import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:kacinvest/pages/login_screen.dart';
import 'package:kacinvest/screens/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/main_data.dart';

//void main() => runApp(KacinvestApp());

  Future<void> main() async {

    
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var username = prefs.getString('username');
      print(username);
      runApp(username == null ? KacinvestAppLogin() : KacinvestApp());
    }

class KacinvestAppLogin extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<KacinvestAppLogin> {
      @override
  void initState() {
    super.initState();
    mainBloc = MainBloc();
  }
@override
  void dispose() {
    mainBloc = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: App(),
      theme: ThemeData(
          //primarySwatch: Colors.amber,
          fontFamily: 'Montserrat',
            
          ),
          
      home:  Scaffold(
        body : DoubleBackToCloseApp(
          child: new LoginScreen(),
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
        ),
        
        ),
    ),
    );
  }
}


class KacinvestApp extends StatefulWidget {
  @override
  _MyAppState2 createState() => _MyAppState2();
}
class _MyAppState2 extends State<KacinvestApp> {
    @override
  void initState() {
    super.initState();
    mainBloc = MainBloc();
  }
@override
  void dispose() {
    mainBloc = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
            theme: ThemeData(
          //primarySwatch: Colors.amber,
          fontFamily: 'Montserrat',
            
          ),
      //home: App(),
      home:  Scaffold(
        body : DoubleBackToCloseApp(
          //child: new App(),
          child: new OTPScreenCheck(),
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
        ),
        
        ),
    ),
    );
  }
}