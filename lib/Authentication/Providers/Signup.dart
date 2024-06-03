import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resort/Notification_Center.dart';

import '../../../Authentication/Providers/Authentication.dart';

import '../../../Global/Functions/Http_Exception.dart';

Future<String> Cd_Signup({
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
  final url = Get_REQUEST_URL(url: '/user/Signup');

  var fcm_token = await FirebaseApi().Get_FCM_Token();

  try {
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode({
          'firstName': first_name,
          'lastName': last_name,
          'email': email,
          'lat': latitude,
          'lon': longitude,
          'region': region,
          'username': username,
          'password': password,
          'fcmToken': fcm_token,
          'phoneNumber': phone_number,
        }));

    final response_data = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw C_Http_Exception(response_data['ErrorFound'] ?? '');
    }

    return response_data['token'];
  } catch (error) {
    rethrow;
  }
}
