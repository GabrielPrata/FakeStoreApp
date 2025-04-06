import 'dart:convert';

import 'package:fake_store_app/util/api_error_model.dart';
import 'package:fake_store_app/util/constants.dart';
import 'package:http/http.dart' as http;
import 'package:fake_store_app/Domain/auth_model.dart';

class AuthRepository {
  // final AuthModel userAuthData = AuthModel.empty();

  Future<AuthModel> authUser(AuthModel userAuthData) async {
    final body = jsonEncode({
      "username": userAuthData.username,
      "password": userAuthData.password,
    });

    final http.Response response = await http.post(
      Uri.parse("${Constants.apiUrl}${Constants.login}"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      userAuthData.setToken(jsonDecode(response.body));
      return userAuthData;
    } else {
      throw ApiErrorException(
        statusCode: response.statusCode,
        errorDescription: response.body,
      );
    }
  }
}
