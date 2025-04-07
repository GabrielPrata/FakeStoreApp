import 'package:fake_store_app/Domain/auth_model.dart';

class UserModel extends AuthModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required String username,
    required String password,
  }) : super(username: username, password: password);

  factory UserModel.fromApiJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['name'] != null ? json['name']['firstname'] : '',
      lastName: json['name'] != null ? json['name']['lastname'] : '',
      username: json['username'],
      password: json['password'],
    );
  }

  factory UserModel.fromGetXJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['name'],
      lastName: json['lastname'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': firstName,
      'lastname': lastName,
      'username': username,
      'password': password,
    };
  }
}
