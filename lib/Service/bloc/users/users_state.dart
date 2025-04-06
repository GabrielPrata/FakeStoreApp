import 'package:fake_store_app/Domain/user_model.dart';

abstract class UsersState {
  final List<UserModel> sellersData;

  UsersState({required this.sellersData});
}

class UsersInitialState extends UsersState {
  UsersInitialState() : super(sellersData: []);
}

class UsersLoadingState extends UsersState {
  UsersLoadingState() : super(sellersData: []);
}

class UsersLoadedState extends UsersState {
  UsersLoadedState({required List<UserModel> sellersData})
    : super(sellersData: sellersData);
}

class UsersErrorState extends UsersState {
  final Exception exception;
  UsersErrorState({required this.exception}) : super(sellersData: []); 
}
