import 'package:bloc/bloc.dart';
import 'package:fake_store_app/Domain/product_model.dart';
import 'package:fake_store_app/Repository/products_repository.dart';
import 'package:fake_store_app/Service/bloc/products/products_event.dart';
import 'package:fake_store_app/Service/bloc/products/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository repository;
  List<ProductModel> _allProducts = [];

  String _selectedCategory = 'Todos';
  String _searchQuery = '';

  ProductsBloc({required this.repository}) : super(ProductsInitialState()) {
    on<GetAllProducts>(_onGetAllProducts);
    on<FilterProductsByCategory>(_onFilterProductsByCategory);
    on<SearchProducts>(_onSearchProducts);
  }

  void _onGetAllProducts(GetAllProducts event, Emitter emit) async {
    emit(ProductsLoadingState());
    try {
      final productsData = await repository.getAllProducts();
      _allProducts = productsData;
      emit(ProductsLoadedState(productsData: _applyFilters()));
    } catch (error) {
      emit(ProductsErrorState(exception: Exception(error.toString())));
    }
  }

  void _onFilterProductsByCategory(
      FilterProductsByCategory event, Emitter emit) {
    _selectedCategory = event.category;
    emit(ProductsLoadedState(productsData: _applyFilters()));
  }

  void _onSearchProducts(SearchProducts event, Emitter emit) {
    _searchQuery = event.query;
    emit(ProductsLoadedState(productsData: _applyFilters()));
  }

  List<ProductModel> _applyFilters() {
    return _allProducts.where((product) {
      final matchesCategory =
          _selectedCategory == 'Todos' || product.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          product.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.id.toString().contains(_searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();
  }
}
