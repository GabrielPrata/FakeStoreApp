import 'package:bloc/bloc.dart';
import 'package:fake_store_app/Repository/auth_repository.dart';
import 'package:fake_store_app/Service/bloc/auth/auth_event.dart';
import 'package:fake_store_app/Service/bloc/auth/auth_state.dart';
import 'package:get_storage/get_storage.dart';

//Preciso passar para o Bloc quais serão os eventos de entrada e os eventos de saída
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitialState()) {
    //Função recebe um evento e emite um estado
    on(_mapEventToState);
  }

  void _mapEventToState(AuthEvent event, Emitter emit) async {
    emit(AuthLoadingState());

    if (event is PostAuthUser) {
      try {
        final userAuthData = await repository.authUser(event.userAuthData);
        GetStorage box = GetStorage();
        box.write('adminLogged', true);
        emit(AuthLoadedState(userAuthData: userAuthData));
      } catch (error) {
        if (error is Exception) {
          emit(AuthErrorState(exception: error));
        } else {
          emit(AuthErrorState(exception: Exception(error.toString())));
        }
      }
    }
  }
}
