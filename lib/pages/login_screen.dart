import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kacinvest/screens/app.dart';
import 'package:kacinvest/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String username = '';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  var _isSecured = true;
  String msg = '';


  final TextEditingController usernameSignupController =
      new TextEditingController();
  final TextEditingController emailSignupController =
      new TextEditingController();
  final TextEditingController passwordSignupController =
      new TextEditingController();
  final TextEditingController confirmpasswordSignupController =
      new TextEditingController();

  String _email;
  Future<List> _login() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://kacinvest.arkeyproject.com/try/Login.php?username=${usernameController.text}&password=${passwordController.text}"),
        headers: {"Accept": "application/json"});

    print(response.body);

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } else {
      if (datauser[0]['username'] == usernameController.text) {
        var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
                //new App(idUser: data[0]['user_id'],firstname: data[0]['first_name'],lastname: data[0]['last_name'],username: data[0]['username'],),
                //new App());

                new MenuDashboardPage());
        Navigator.of(context).pushReplacement(route);

        _simpan() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var _text = "Raka2";
          await prefs.setString('username', datauser[0]['username']);
          await prefs.setString('OTP', datauser[0]['OTP']);
        }

        setState(() {
          _simpan();
        });
      }

      setState(() {
        username = datauser[0]['username'];
      });
    }

    return datauser;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool _autoValidate = false;
  bool _termsChecked = false;

    String emailvalid = '';
  String usernamevalid = '';
  String passwordvalid = '';
  String confirmpasswordvalid = '';

  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  void _validateInputss(value) {
    final form = _formKey.currentState;
    var msg = '';

    if (value.isEmpty) {
      // The form is empty
      msg = "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    msg = 'Email is not valid';

    if (regExp.hasMatch(value)) {
      msg = '';
    }

    setState(() {
      _autoValidate = true;
      emailvalid = msg;
    });
  }

  void _validateUsername(value) async {
    //final form = _formKey.currentState;
    var msg = '';
    var response = await http.get(
        Uri.encodeFull(
            "http://kacinvest.arkeyproject.com/try/usernamelist.php?username=${value}"),
        headers: {"Accept": "application/json"});

    print(response.body);

    var user = json.decode(response.body);
    var len = value.length;
    if (len < 6 || len > 20) {
      msg = 'Input at least 6 characters and maximum 20 characters';
    } else {
      msg = '';
      if (user.length > 0) {
        setState(() {
          msg = "Username has been used";
        });
      }
    }
    if (value.isEmpty) {
      // The form is empty
      msg = "Enter Username";
    }

    setState(() {
      _autoValidate = true;
      usernamevalid = msg;
    });
  }

  void _validatePassword(value) {
    final form = _formKey.currentState;
    var msg = '';
    if (value.isEmpty) {
      msg = "Enter password";
    }

    var len = value.length;
    if (len < 6) {
      msg = 'Input at least 6 characters';
    }

    setState(() {
      _autoValidate = true;
      passwordvalid = msg;
    });
  }

  void _validateConfirmPassword(value) {
    var msg = '';
    if (value.isEmpty) {
      msg = "Enter confirm password";
    }

    

    var match = passwordSignupController.text;
    if ( value != match) {
      msg = 'Wrong password';
    } else {
      msg = '';
    }



    setState(() {
      _autoValidate = true;
      confirmpasswordvalid = msg;
    });
  }

  @override
  void initState() {
    super.initState();
    //_simpan();
  }

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Widget HomePage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: PaypalColors.LightBlue,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.3), BlendMode.dstATop),
          image: AssetImage('assets/images/BGStock.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 200.0),
            child:
                new Image.asset('assets/images/KacinvestLogo.png', height: 150),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    color: PaypalColors.Orange,
                    onPressed: () => gotoSignup(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    color: PaypalColors.Orange,
                    onPressed: () => gotoLogin(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget LoginPage() {
    return new Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.05), BlendMode.dstATop),
            image: AssetImage('assets/images/BGStock2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              Container(
                child:
                    new Image.asset('assets/images/KacinvestLogo', height: 100),
                padding: EdgeInsets.all(120.0),
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: new Text(
                        "EMAIL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: PaypalColors.Orange,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: PaypalColors.Orange,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: TextFormField(
                        controller: usernameController,
                        //obscureText: true,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Input your email',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 24.0,
                color: Color.fromRGBO(255, 255, 255, 0),
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: new Text(
                        "PASSWORD",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: PaypalColors.Orange,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: PaypalColors.Orange,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: _isSecured,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          suffixIcon: new IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isSecured = !_isSecured;
                                });
                              }),
                          border: InputBorder.none,
                          hintText: '*********',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 24.0,
                color: Color.fromRGBO(255, 255, 255, 0),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: new FlatButton(
                      child: new Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: PaypalColors.Orange,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      onPressed: () => {},
                    ),
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new FlatButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: PaypalColors.Orange,
                        onPressed: () {
                          /*getLogin(usernameController.text);
                          VerifData(usernameController.text,
                              passwordController.text, data);*/
                          _login();
                        },
                        child: new Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: Text(
                                  "LOGIN",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                msg,
                style: TextStyle(fontSize: 20.0, color: Colors.red),
              ),
              Divider(
                height: 24.0,
                color: Color.fromRGBO(255, 255, 255, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget SignupPage() {
    return new Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.05), BlendMode.dstATop),
            image: AssetImage('assets/images/BGStock2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: new SingleChildScrollView(
          child: new Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: new Column(
              children: <Widget>[
                Container(
                  child:
                      Image.asset('assets/images/PayPal-logo.png', height: 100),
                  padding: EdgeInsets.all(120.0),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: new Text(
                          "EMAIL",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: PaypalColors.Orange,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    new Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: PaypalColors.Orange,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              onSaved: (String value) {
                                email = value;
                              },
                              onChanged: (string) {
                                _validateInputss(string);
                              },
                              //validator: _validateEmail,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailSignupController,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type your email',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(emailvalid, style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 16.0,
                  color: Color.fromRGBO(255, 255, 255, 0),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: new Text(
                          "USERNAME",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: PaypalColors.Orange,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: PaypalColors.Orange,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Expanded(
                        child: TextFormField(
                          onChanged: (string) {
                            _validateUsername(string);
                          },
                          controller: usernameSignupController,
                          //obscureText: true,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type your username',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(usernamevalid, style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
                Divider(
                  height: 16.0,
                  color: Color.fromRGBO(255, 255, 255, 0),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: new Text(
                          "PASSWORD",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: PaypalColors.Orange,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: PaypalColors.Orange,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Expanded(
                        child: TextFormField(
                        onChanged: (string) {
                                _validatePassword(string);
                              },
                          controller: passwordSignupController,
                          obscureText: true,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type your password',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(passwordvalid, style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                Divider(
                  height: 24.0,
                  color: Color.fromRGBO(255, 255, 255, 0),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: new Text(
                          "CONFIRM PASSWORD",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: PaypalColors.Orange,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: PaypalColors.Orange,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Expanded(
                        child: TextFormField(
                                                        onChanged: (string) {
                                _validateConfirmPassword(string);
                              },
                          controller: confirmpasswordSignupController,
                          obscureText: true,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Re-Type your password',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(confirmpasswordvalid, style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: new CheckboxListTile(
                            title: new Text('I  Agree to the Terms and Conditions'),
                            value: _termsChecked,
                            onChanged: (bool value) =>
                                setState(() => _termsChecked = value)),
                      ),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: new FlatButton(
                        onPressed: () => gotoLogin(),
                        child: new Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: PaypalColors.Orange,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
                new Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
                  alignment: Alignment.center,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new FlatButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          color: PaypalColors.Orange,
                          onPressed: () => {},
                          child: new Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: Text(
                                    "SIGN UP",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 24.0,
                  color: Color.fromRGBO(255, 255, 255, 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  PageController _controller =
      new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: PageView(
          controller: _controller,
          physics: new AlwaysScrollableScrollPhysics(),
          children: <Widget>[LoginPage(), HomePage(), SignupPage()],
          scrollDirection: Axis.horizontal,
        ));
  }
}
