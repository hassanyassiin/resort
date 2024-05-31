import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Authentication/Providers/Signup.dart';

import '../../../Global/Functions/Http_Exception.dart';

const _server_url = 'localhost:8080';
get Get_Server_Url => _server_url;

var _is_first_time = true;
get Get_Is_First_Time => _is_first_time;

var is_try_auto_login = false;
get Get_Is_Try_Auto_Login => is_try_auto_login;

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

String? _first_name;
get Get_First_Name => _first_name;

String? _last_name;
get Get_Last_Name => _last_name;

String? _region;
get Get_Region => _region;

class Authentication extends ChangeNotifier {
  bool get Is_Auth => _token != null;

  Future<void> Signup({
    required String first_name,
    required String last_name,
    required String email,
    required String phone_number,
    required double latitude,
    required double longitude,
    required String region,
    required String username,
    required String password,
  }) async {
    try {
      var received_token = await Cd_Signup(
        first_name: first_name,
        last_name: last_name,
        email: email,
        phone_number: phone_number,
        latitude: latitude,
        longitude: longitude,
        region: region,
        username: username,
        password: password,
      );

      _token = received_token;
      _username = username;
      _first_name = first_name;
      _last_name = last_name;
      _region = region;

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
          'userData',
          json.encode({
            'Token': _token,
            'Username': _username,
            'FirstName': _first_name,
            'LastName': _last_name,
            'Region': _region,
          }));

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> Login({required Map<String, String> credentials}) async {
    final url = Get_REQUEST_URL(url: '/user/Login');

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
      _first_name = response_data['firstName'];
      _last_name = response_data['lastName'];
      _region = response_data['region'];

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
          'userData',
          json.encode({
            'Token': _token,
            'Username': _username,
            'FirstName': _first_name,
            'LastName': _last_name,
            'Region': _region,
          }));

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> Try_Auto_Login() async {
    try {
      is_try_auto_login = true;
      final prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey('Attempt')) {
        _is_first_time = false;
      }

      if (!prefs.containsKey('userData')) {
        return false;
      }

      final user_details =
          json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

      _token = user_details['Token'];
      _username = user_details['Username'];
      _first_name = user_details['FirstName'];
      _last_name = user_details['LastName'];
      _region = user_details['Region'];

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
      await prefs.remove('userData');

      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
