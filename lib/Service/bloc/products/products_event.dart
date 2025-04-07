abstract class ProductsEvent {}

class GetAllProducts extends ProductsEvent {}

class FilterProductsByCategory extends ProductsEvent {
  final String category;

  FilterProductsByCategory({required this.category});
}

class SearchProducts extends ProductsEvent {
  final String query;

  SearchProducts({required this.query});
}

