import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'datadb.dart';
 
class Services {
  static const ROOT = 'http://kacinvest.arkeyproject.com/try/SelectAllUsers.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';
 
  // Method to create the table StockProducts.
  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
 
  static Future<List<StockProduct>> getStockProducts() async {
      //var map = Map<String, dynamic>();
      //map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT);
      print('getStockProducts Response: ${response.body}');
      if (200 == response.statusCode) {
        List<StockProduct> list = parseResponse(response.body);
        return list;
      }
  }
 
  static List<StockProduct> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<StockProduct>((json) => StockProduct.fromJson(json)).toList();
  }
 
  // Method to add StockProduct to the database...
  static Future<String> addStockProduct(String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT, body: map);
      print('addStockProduct Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
 
  // Method to update an StockProduct in Database...
  static Future<String> updateStockProduct(
      String empId, String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empId;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT, body: map);
      print('updateStockProduct Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
 
  // Method to Delete an StockProduct from Database...
  static Future<String> deleteStockProduct(String empId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empId;
      final response = await http.post(ROOT, body: map);
      print('deleteStockProduct Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}