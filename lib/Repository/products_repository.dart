import 'dart:convert';
import 'package:fake_store_app/Domain/product_model.dart';
import 'package:fake_store_app/util/api_error_model.dart';
import 'package:fake_store_app/util/constants.dart';
import 'package:http/http.dart' as http;

class ProductsRepository {
  // final AuthModel userAuthData = AuthModel.empty();

 Future<List<ProductModel>> getAllProducts() async {
    final http.Response response = await http.get(
      Uri.parse("${Constants.apiUrl}${Constants.products}"),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(1);

    if (response.statusCode == 200) {
      print(2);
      // Decodifica a resposta JSON que é uma lista
      final List<dynamic> jsonList = jsonDecode(response.body);
print(3);
      final List<ProductModel> products = jsonList
          .map((jsonItem) => ProductModel.fromJson(jsonItem as Map<String, dynamic>))
          .toList();
print(4);
      return products;
    } else {
      print(5);
      throw ApiErrorException(
        statusCode: response.statusCode,
        errorDescription: response.body,
      );
    }
  }
}
