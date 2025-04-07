import 'dart:convert';
import 'package:fake_store_app/Domain/cart_model.dart';
import 'package:fake_store_app/Domain/product_model.dart';
import 'package:fake_store_app/util/api_error_model.dart';
import 'package:fake_store_app/util/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CartRepository {
  Future postCart(CartModel cartData) async {
    final body = jsonEncode({
      "id": cartData.id,
      "userId": cartData.userId,
      "products": cartData.products
          .map((product) => {
                "id": product.id,
                "title": product.title,
                "price": product.price,
                "category": product.category,
                "image": product.image,
              })
          .toList(),
    });

    final http.Response response = await http.post(
      Uri.parse("${Constants.apiUrl}${Constants.carts}"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode != 200) {
      throw ApiErrorException(
        statusCode: response.statusCode,
        errorDescription: response.body,
      );
    }
  }

  Future putCart(CartModel cartData) async {
    final body = jsonEncode({
      "id": cartData.id,
      "userId": cartData.userId,
      "products": cartData.products
          .map((product) => {
                "id": product.id,
                "title": product.title,
                "price": product.price,
                "category": product.category,
                "image": product.image,
              })
          .toList(),
    });
    GetStorage box = GetStorage();
    final http.Response response = await http.put(
      Uri.parse("${Constants.apiUrl}${Constants.carts}/${box.read('cartId')}"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode != 200) {
      throw ApiErrorException(
        statusCode: response.statusCode,
        errorDescription: response.body,
      );
    }
  }

  Future<List<CartModel>> getAllCarts() async {
    final http.Response response = await http.get(
      Uri.parse("${Constants.apiUrl}${Constants.carts}"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonListCarts = jsonDecode(response.body);
      List<CartModel> carts = [];

      for (var cartJson in jsonListCarts) {
        int cartId = cartJson['id'];
        int userId = cartJson['userId'];
        List<ProductModel> products = [];

        for (var item in cartJson['products']) {
          final productId = item['productId'];
          final quantity = item['quantity'];

          final productResponse = await http.get(
            Uri.parse("${Constants.apiUrl}${Constants.products}/$productId"),
            headers: {
              'Content-Type': 'application/json',
            },
          );

          if (productResponse.statusCode == 200) {
            final productJson = jsonDecode(productResponse.body);
            final product = ProductModel.fromJson(productJson);

            for (int i = 0; i < quantity; i++) {
              products.add(product);
            }
          } else {
            throw Exception("Erro ao buscar produto $productId");
          }
        }

        carts.add(CartModel(
          id: cartId,
          userId: userId,
          products: products,
        ));
      }

      return carts;
    } else {
      throw ApiErrorException(
        statusCode: response.statusCode,
        errorDescription: response.body,
      );
    }
  }

  Future deleteCart(CartModel cartData) async {
    final http.Response response = await http.delete(
      Uri.parse("${Constants.apiUrl}${Constants.carts}/${cartData.id}"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw ApiErrorException(
        statusCode: response.statusCode,
        errorDescription: response.body,
      );
    }
  }
}
