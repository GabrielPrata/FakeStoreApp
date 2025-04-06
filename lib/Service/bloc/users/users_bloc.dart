import 'package:bloc/bloc.dart';
import 'package:fake_store_app/Repository/users_repository.dart';
import 'package:fake_store_app/Service/bloc/users/users_event.dart';
import 'package:fake_store_app/Service/bloc/users/users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository repository;

  UsersBloc({required this.repository}) : super(UsersInitialState()) {
    on(_mapEventToState);
  }

  void _mapEventToState(UsersEvent event, Emitter emit) async {
    emit(UsersLoadingState());

    if (event is GetAllUsers) {
      try {
        final usersData = await repository.getAllUsers();
        emit(UsersLoadedState(sellersData: usersData));
      } catch (error) {
        if (error is Exception) {
          emit(UsersErrorState(exception: error));
        } else {
          emit(UsersErrorState(exception: Exception(error.toString())));
        }
      }
    }
  }
}
