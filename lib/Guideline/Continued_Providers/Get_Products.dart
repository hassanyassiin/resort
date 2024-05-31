import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Authentication/Providers/Authentication.dart';

import '../../../Global/Functions/Http_Exception.dart';

import '../../../Guideline/Providers/Product_Model.dart';

Future<List<Product_Model>> Cd_Get_Products({
  required int category_id,
}) async {
  final url = Get_REQUEST_URL(url: '/user/get-Products', arguments: {
    'categoryId': category_id.toString(),
  });

  try {
    final response = await http.get(
      url,
      headers: <String, String>{'Authorization': 'Bearer $Get_Token'},
    );

    final response_data = json.decode(response.body);

    if (response.statusCode != 200) {
      throw C_Http_Exception(response_data['ErrorFound'] ?? '');
    }

    List<Product_Model> received_products = [];

    for (var product in response_data['products']) {
      received_products.add(
        Product_Model(
          id: product['id'],
          title: product['title'],
          photo: Get_PHOTO_URL(
            folder: 'product',
            image: product['photo'],
          ),
        ),
      );
    }

    return received_products;
  } catch (error) {
    rethrow;
  }
}
