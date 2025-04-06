class AuthModel {
  String username;
  String password;
  String? token;

  AuthModel({required this.username, required this.password, this.token});

  AuthModel.empty()
      : username = '',
        password = '',
        token = "";

  setToken(Map<String, dynamic> json) {
    token = json["token"];
  }
}
