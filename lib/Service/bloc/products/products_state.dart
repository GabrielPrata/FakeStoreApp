import 'package:fake_store_app/Domain/product_model.dart';

abstract class ProductsState {
  final List<ProductModel> productsData;

  ProductsState({required this.productsData});
}

class ProductsInitialState extends ProductsState {
  ProductsInitialState() : super(productsData: []);
}

class ProductsLoadingState extends ProductsState {
  ProductsLoadingState() : super(productsData: []);
}

class ProductsLoadedState extends ProductsState {
  ProductsLoadedState({required List<ProductModel> productsData})
      : super(productsData: productsData);
}
class ProductsErrorState extends ProductsState {
  final Exception exception;
  ProductsErrorState({required this.exception}) : super(productsData: []);
}
