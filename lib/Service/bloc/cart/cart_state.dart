import 'package:fake_store_app/Domain/cart_model.dart';

abstract class CartState {
  final CartModel? cartData;
  final List<CartModel>? allCarts;

  CartState({this.cartData, this.allCarts});
}

class CartInitialState extends CartState {
  CartInitialState() : super(cartData: CartModel.empty());
}

class CartLoadingState extends CartState {
  CartLoadingState() : super(cartData: CartModel.empty());
}

class CartLoadedState extends CartState {
  CartLoadedState() : super(cartData: CartModel.empty());
}

class CartAdminLoadedState extends CartState {
  CartAdminLoadedState({required List<CartModel> allCarts}) : super(allCarts: allCarts);
}

class CartDeletedState extends CartState {
  CartDeletedState({required List<CartModel> allCarts}) : super(allCarts: allCarts);
}

class CartErrorState extends CartState {
  final Exception exception;
  CartErrorState({required this.exception}) : super(cartData: CartModel.empty()); 
}
