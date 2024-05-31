import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Authentication/Providers/Authentication.dart';

import '../../../Global/Functions/Http_Exception.dart';

Future<void> Cd_Update_Status({
  required String status,
}) async {
  final url = Get_REQUEST_URL(url: '/user-schedules/update-Status');

  try {
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $Get_Token',
        },
        body: json.encode({
          'status': status,
        }));

    final response_data = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw C_Http_Exception(response_data['ErrorFound'] ?? '');
    }
  } catch (error) {
    rethrow;
  }
}
