import 'package:fake_store_app/Domain/auth_model.dart';

abstract class HomeScreenState {
  final AuthModel userAuthData;

  HomeScreenState({required this.userAuthData});
}

class HomeScreenInitialState extends HomeScreenState {
  HomeScreenInitialState() : super(userAuthData: AuthModel.empty());
}

class HomeScreenLoadingState extends HomeScreenState {
  HomeScreenLoadingState() : super(userAuthData: AuthModel.empty());
}

class HomeScreenLoadedState extends HomeScreenState {
  HomeScreenLoadedState({required AuthModel userAuthData})
    : super(userAuthData: userAuthData);
}

class HomeScreenErrorState extends HomeScreenState {
  final Exception exception;
  HomeScreenErrorState({required this.exception}) : super(userAuthData: AuthModel.empty()); 
}
