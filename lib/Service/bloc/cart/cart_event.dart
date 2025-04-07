import 'package:fake_store_app/Domain/cart_model.dart';

abstract class CartEvent {}

class PostCart extends CartEvent {
  final CartModel cartData;
  
  PostCart({required this.cartData});
}

class PutCart extends CartEvent {
  final CartModel cartData;
  
  PutCart({required this.cartData});
}

class DeleteCart extends CartEvent {
  final CartModel cartData;

  DeleteCart({required this.cartData});
}

class GetAllCarts extends CartEvent {}
