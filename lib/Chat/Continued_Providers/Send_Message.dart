import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Authentication/Providers/Authentication.dart';

import '../../../Global/Functions/Http_Exception.dart';

Future<void> Cd_Send_Message({required String text}) async {
  final url = Get_REQUEST_URL(url: 'user/send-Message');

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $Get_Token'
      },
      body: json.encode({
        'text': text,
      }),
    );

    final response_data = json.decode(response.body);

    if (response.statusCode != 200) {
      throw C_Http_Exception(response_data['ErrorFound'] ?? '');
    }
  } catch (error) {
    rethrow;
  }
}
