import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Authentication/Providers/Authentication.dart';

import '../../../Global/Functions/Http_Exception.dart';

Future<Map<String, dynamic>> Cd_Get_Available_Schedules() async {
  final url = Get_REQUEST_URL(url: '/user-schedules/get-Available-Schedules');

  try {
    final response = await http.get(
      url,
      headers: <String, String>{'Authorization': 'Bearer $Get_Token'},
    );

    final response_data = json.decode(response.body);

    if (response.statusCode != 200) {
      throw C_Http_Exception(response_data['ErrorFound'] ?? '');
    }

    if ((response_data as Map<String, dynamic>).containsKey('status')) {
      return {
        'Region': 'Not Available',
        'Date': '',
      };
    }
    return {
      'Region': response_data['Schedule']['region'],
      'Date': response_data['Schedule']['date'],
    };
  } catch (error) {
    rethrow;
  }
}
