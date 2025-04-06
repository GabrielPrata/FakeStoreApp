import 'package:fake_store_app/Domain/auth_model.dart';

abstract class HomeScreenEvent {}

class PostAuthUser extends HomeScreenEvent {
  final AuthModel userAuthData;

  PostAuthUser({required this.userAuthData});
}
