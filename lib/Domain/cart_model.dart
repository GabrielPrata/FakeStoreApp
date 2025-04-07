import 'package:fake_store_app/Domain/product_model.dart';

class CartModel {
  int id;
  int userId;
  List<ProductModel> products;

  CartModel({
    required this.id,
    required this.userId,
    required this.products,
  });
  CartModel.empty()
      : id = 0,
        userId = 0,
        products = [];

}
