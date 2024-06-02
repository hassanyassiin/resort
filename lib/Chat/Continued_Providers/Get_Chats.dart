import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Authentication/Providers/Authentication.dart';

import '../../../Global/Functions/Http_Exception.dart';

import '../../../Chat/Providers/Chat_Model.dart';

Future<List<Chat_Model>> Cd_Get_Chats() async {
  final url = Get_REQUEST_URL(url: '/user/get-Chats');

  try {
    final response = await http.get(url,
        headers: <String, String>{'Authorization': 'Bearer $Get_Token'});

    final response_data = json.decode(response.body);

    if (response.statusCode != 200) {
      throw C_Http_Exception(response_data['ErrorFound'] ?? '');
    }

    List<Chat_Model> received_chats = [];

    for (var chat in response_data['chats']) {
      received_chats.add(
        Chat_Model(
          id: chat['id'],
          text: chat['text'],
          is_admin: chat['isAdmin'],
        ),
      );
    }

    return received_chats;
  } catch (error) {
    rethrow;
  }
}
