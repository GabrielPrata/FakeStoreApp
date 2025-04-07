import 'dart:convert';
import 'package:fake_store_app/Domain/user_model.dart';
import 'package:fake_store_app/util/api_error_model.dart';
import 'package:fake_store_app/util/constants.dart';
import 'package:http/http.dart' as http;

class UsersRepository {
  Future<List<UserModel>> getAllUsers() async {
    final http.Response response = await http.get(
      Uri.parse("${Constants.apiUrl}${Constants.users}"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      final List<UserModel> users = jsonList
          .map((jsonItem) => UserModel.fromApiJson(jsonItem as Map<String, dynamic>))
          .toList();

      return users;
    } else {
      throw ApiErrorException(
        statusCode: response.statusCode,
        errorDescription: response.body,
      );
    }
  }
}