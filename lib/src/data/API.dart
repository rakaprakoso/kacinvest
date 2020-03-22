import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://kacinvest.arkeyproject.com/try";

class API {
  static Future getUsers() {
    var url = baseUrl + "/SelectAllUsers.php";
    return http.get(url);
  }
}