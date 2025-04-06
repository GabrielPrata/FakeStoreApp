import 'package:fake_store_app/Domain/auth_model.dart';

abstract class AuthEvent {}

class PostAuthUser extends AuthEvent {
  final AuthModel userAuthData;

  PostAuthUser({required this.userAuthData});
}
