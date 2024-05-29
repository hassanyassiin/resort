import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Global/Functions/Http_Exception.dart';

const _server_url = 'localhost:8080';
get Get_Server_Url => _server_url;

dynamic Get_REQUEST_URL({
  required String url,
  bool is_form_data = false,
  Map<String, dynamic>? arguments,
}) {
  if (is_form_data) {
    return Uri.parse('http://$Get_Server_Url$url');
  } else {
    return Uri.http(_server_url, url, arguments);
  }
}

String Get_PHOTO_URL({
  required String folder,
  required String image,
}) {
  return "http://$Get_Server_Url/resources/uploads/$folder/$image";
}

String? _token;
get Get_Token => _token;

String? _username;
get Get_Username => _username;

class Authentication extends ChangeNotifier {
  bool get Is_Auth => _token != null;

  Future<void> Login({required Map<String, String> credentials}) async {
    final url = Get_REQUEST_URL(url: '/admin/Login');

    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: json.encode({
            'username': credentials['account'],
            'password': credentials['password'],
          }));

      final response_data = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        throw C_Http_Exception(response_data['ErrorFound'] ?? '');
      }

      _token = response_data['token'];
      _username = response_data['username'];

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
          'userData',
          json.encode({
            'Token': _token,
            'Username': _username,
          }));

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> Try_Auto_Login() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (!prefs.containsKey('userData')) {
        return false;
      }

      final user_details =
          json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

      _token = user_details['Token'];
      _username = user_details['Username'];

      notifyListeners();
      return true;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> Logout() async {
    try {
      _token = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
