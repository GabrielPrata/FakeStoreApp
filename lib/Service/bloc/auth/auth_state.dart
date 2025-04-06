import 'package:fake_store_app/Domain/auth_model.dart';

abstract class AuthState {
  final AuthModel userAuthData;

  AuthState({required this.userAuthData});
}

class AuthInitialState extends AuthState {
  AuthInitialState() : super(userAuthData: AuthModel.empty());
}

class AuthLoadingState extends AuthState {
  AuthLoadingState() : super(userAuthData: AuthModel.empty());
}

class AuthLoadedState extends AuthState {
  AuthLoadedState({required AuthModel userAuthData})
    : super(userAuthData: userAuthData);
}

class AuthErrorState extends AuthState {
  final Exception exception;
  AuthErrorState({required this.exception}) : super(userAuthData: AuthModel.empty()); 
}
