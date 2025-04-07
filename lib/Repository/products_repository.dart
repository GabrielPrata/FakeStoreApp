import 'dart:convert';
import 'package:fake_store_app/Domain/product_model.dart';
import 'package:fake_store_app/util/api_error_model.dart';
import 'package:fake_store_app/util/constants.dart';
import 'package:http/http.dart' as http;

class ProductsRepository {

 Future<List<ProductModel>> getAllProducts() async {
    final http.Response response = await http.get(
      Uri.parse("${Constants.apiUrl}${Constants.products}"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      final List<ProductModel> products = jsonList
          .map((jsonItem) => ProductModel.fromJson(jsonItem as Map<String, dynamic>))
          .toList();
      return products;
    } else {
      throw ApiErrorException(
        statusCode: response.statusCode,
        errorDescription: response.body,
      );
    }
  }
}
