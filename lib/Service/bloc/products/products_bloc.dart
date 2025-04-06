import 'package:bloc/bloc.dart';
import 'package:fake_store_app/Repository/products_repository.dart';
import 'package:fake_store_app/Service/bloc/products/products_event.dart';
import 'package:fake_store_app/Service/bloc/products/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository repository;

  ProductsBloc({required this.repository}) : super(ProductsInitialState()) {
    on(_mapEventToState);
  }

  void _mapEventToState(ProductsEvent event, Emitter emit) async {
    emit(ProductsLoadingState());

    if (event is GetAllProducts) {
      try {
        final productsData = await repository.getAllProducts();
        emit(ProductsLoadedState(productsData: productsData));
      } catch (error) {
        if (error is Exception) {
          emit(ProductsErrorState(exception: error));
        } else {
          emit(ProductsErrorState(exception: Exception(error.toString())));
        }
      }
    }
  }
}
