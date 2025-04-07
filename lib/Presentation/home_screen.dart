import 'package:fake_store_app/Presentation/admin_screen.dart';
import 'package:fake_store_app/Presentation/select_seller_screen.dart';
import 'package:fake_store_app/Repository/auth_repository.dart';
import 'package:fake_store_app/Service/bloc/auth/auth_bloc.dart';
import 'package:fake_store_app/Service/bloc/auth/auth_state.dart';
import 'package:fake_store_app/util/alerts.dart';
import 'package:fake_store_app/util/api_error_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  String? errorText;
  bool passIsEnabled = false;
  late final AuthBloc _authBloc;
  late final AuthRepository _authBlocRepository;

  @override
  void initState() {
    super.initState();
    _userController.clear();
    _passController.clear();
    _authBlocRepository = AuthRepository();
    _authBloc = AuthBloc(repository: _authBlocRepository);
  }

  @override
  Widget build(BuildContext context) {
    validaLogin() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminScreen()),
      );

      // if (_userController.text.isEmpty || _passController.text.isEmpty) {
      //   Alerts.showErrorSnackBar(
      //       "Preencha os campos de usuário e senha!", context);
      //   return;
      // }

      // _authBloc.add(PostAuthUser(
      //     userAuthData: AuthModel(
      //         username: _userController.text, password: _passController.text,)));
    }

    selectSellerRedirect() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SelectSellerScreen(),
        ),
      );
    }

    showPass() {
      setState(() {
        passIsEnabled = !passIsEnabled;
      });
    }

    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        bloc: _authBloc,
        builder: (context, state) {
          if (state is AuthErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state.exception is ApiErrorException) {
                final error = state.exception as ApiErrorException;
                Alerts.showErrorSnackBar(
                    "Erro ao autenticar-se: ${error.statusCode} - ${error.errorDescription}",
                    context);
              } else {
                Alerts.showErrorSnackBar(
                    "Erro ao autenticar-se: ${state.exception.toString()}",
                    context);
              }
            });
          } else if (state is AuthLoadedState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Alerts.showSuccessSnackBar("Você entrou no sistema!", context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AdminScreen()),
              );
            });
          }
          return Container(
            color: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.06,
              left: MediaQuery.of(context).size.width * 0.08,
              right: MediaQuery.of(context).size.width * 0.08,
            ),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                SizedBox(
                  height: 300,
                  child: Image.asset("assets/AppLogoWithText.png"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                TextField(
                  controller: _userController,
                  style: Theme.of(context).textTheme.labelSmall,
                  cursorColor: Theme.of(context).colorScheme.surface,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Theme.of(context)
                            .primaryColor,
                      ),
                    ),
                    labelText: "Usuário",
                    labelStyle: Theme.of(context).textTheme.labelSmall,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextField(
                  style: Theme.of(context).textTheme.labelSmall,
                  controller: _passController,
                  cursorColor: Theme.of(context).colorScheme.surface,
                  keyboardType: TextInputType.text,
                  obscureText: !passIsEnabled,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        showPass();
                      },
                      icon: Icon(
                        passIsEnabled ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Theme.of(context)
                            .primaryColor,
                      ),
                    ),
                    labelText: "Senha",
                    labelStyle: Theme.of(context).textTheme.labelSmall,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                Container(
                  height: 120,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: Theme.of(context).filledButtonTheme.style,
                        onPressed: state is AuthLoadingState
                            ? null
                            : () => validaLogin(),
                        child: state is AuthLoadingState
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth: 2.0,
                                ),
                              )
                            : Text(
                                "LOGIN ADMIN",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OutlinedButton(
                        onPressed: () => selectSellerRedirect(),
                        child: Text(
                          "CONTINUAR COMO VENDEDOR",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }
}
