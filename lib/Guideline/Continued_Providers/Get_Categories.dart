import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Authentication/Providers/Authentication.dart';

import '../../../Global/Functions/Http_Exception.dart';

import '../../../Guideline/Providers/Category_Model.dart';

Future<List<Category_Model>> Cd_Get_Categories() async {
  final url = Get_REQUEST_URL(url: '/user/get-Categories');

  try {
    final response = await http.get(
      url,
      headers: <String, String>{'Authorization': 'Bearer $Get_Token'},
    );

    final response_data = json.decode(response.body);

    if (response.statusCode != 200) {
      throw C_Http_Exception(response_data['ErrorFound'] ?? '');
    }

    List<Category_Model> received_categories = [];

    for (var category in response_data['categories']) {
      received_categories.add(
        Category_Model(
          id: category['id'],
          title: category['title'],
          photo: Get_PHOTO_URL(
            folder: 'category',
            image: category['photo'],
          ),
        ),
      );
    }

    return received_categories;
  } catch (error) {
    rethrow;
  }
}
