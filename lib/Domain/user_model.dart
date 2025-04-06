import 'package:fake_store_app/Domain/auth_model.dart';

class UserModel extends AuthModel {
  int id;
  String email;

  UserModel({
    required this.id,
    required this.email, required super.username, required super.password,
  });
}
