import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fake_store_app/Domain/auth_model.dart';
import 'package:fake_store_app/Repository/home_screen_repository.dart';
import 'package:fake_store_app/Service/bloc/home_screen/home_screen_event.dart';
import 'package:fake_store_app/Service/bloc/home_screen/home_screen_state.dart';

//Preciso passar para o Bloc quais serão os eventos de entrada e os eventos de saída
class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final HomeScreenRepository repository;

  HomeScreenBloc({required this.repository}) : super(HomeScreenInitialState()) {
    //Função recebe um evento e emite um estado
    on(_mapEventToState);
  }

  void _mapEventToState(HomeScreenEvent event, Emitter emit) async {
    emit(HomeScreenLoadingState());

    if (event is PostAuthUser) {
      try {
        final userAuthData = await repository.authUser(event.userAuthData);
        emit(HomeScreenLoadedState(userAuthData: userAuthData));
      } catch (error) {
        emit(HomeScreenErrorState(exception: error as Exception));
      }
    }
  }
}
