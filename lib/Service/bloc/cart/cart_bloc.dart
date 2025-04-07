import 'package:bloc/bloc.dart';
import 'package:fake_store_app/Domain/cart_model.dart';
import 'package:fake_store_app/Repository/cart_repository.dart';
import 'package:fake_store_app/Service/bloc/cart/cart_event.dart';
import 'package:fake_store_app/Service/bloc/cart/cart_state.dart';

//Preciso passar para o Bloc quais serão os eventos de entrada e os eventos de saída
class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;
  List<CartModel> _allCarts = [];

  CartBloc({required this.repository}) : super(CartInitialState()) {
    //Função recebe um evento e emite um estado
    on(_mapEventToState);
  }

  void _mapEventToState(CartEvent event, Emitter emit) async {
    emit(CartLoadingState());

    if (event is PostCart) {
      try {
        await repository.postCart(event.cartData);
        emit(CartLoadedState());
      } catch (error) {
        if (error is Exception) {
          emit(CartErrorState(exception: error));
        } else {
          emit(CartErrorState(exception: Exception(error.toString())));
        }
      }
    } else if (event is GetAllCarts) {
      try {
        _allCarts = await repository.getAllCarts();
        emit(CartAdminLoadedState(allCarts: _allCarts));
      } catch (error) {
        if (error is Exception) {
          emit(CartErrorState(exception: error));
        } else {
          emit(CartErrorState(exception: Exception(error.toString())));
        }
      }
    } else if (event is DeleteCart) {
      try {
        await repository.deleteCart(event.cartData);
        _allCarts.removeWhere((cart) => cart.id == event.cartData.id);
        emit(CartDeletedState(allCarts: _allCarts));

      } catch (error) {
        if (error is Exception) {
          emit(CartErrorState(exception: error));
        } else {
          emit(CartErrorState(exception: Exception(error.toString())));
        }
      }
    } else if (event is PutCart) {
      try {
        await repository.putCart(event.cartData);
        emit(CartLoadedState());
      } catch (error) {
        if (error is Exception) {
          emit(CartErrorState(exception: error));
        } else {
          emit(CartErrorState(exception: Exception(error.toString())));
        }
      }
    }
  }
}
