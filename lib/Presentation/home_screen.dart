import 'package:fake_store_app/Domain/auth_model.dart';
import 'package:fake_store_app/Repository/home_screen_repository.dart';
import 'package:fake_store_app/Service/bloc/home_screen/home_screen_bloc.dart';
import 'package:fake_store_app/Service/bloc/home_screen/home_screen_event.dart';
import 'package:fake_store_app/Service/bloc/home_screen/home_screen_state.dart';
import 'package:fake_store_app/util/alerts.dart';
import 'package:fake_store_app/util/api_error_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TextEditingController userController = TextEditingController();
TextEditingController passController = TextEditingController();
// AuthController authController = Get.put(AuthController());
String? errorText;
bool passIsEnabled = false;

class _HomeScreenState extends State<HomeScreen> {
  late final HomeScreenBloc _homeScreenBloc;
  late final HomeScreenRepository _homeScreenRepository;

  @override
  void initState() {
    super.initState();
    userController.clear();
    passController.clear();
    _homeScreenRepository = HomeScreenRepository();
    _homeScreenBloc = HomeScreenBloc(repository: _homeScreenRepository);
  }

  @override
  Widget build(BuildContext context) {
    validaLogin() {
      if (userController.text.isEmpty || passController.text.isEmpty) {
        Alerts.showErrorSnackBar(
            "Preencha os campos de usuário e senha!", context);
        return;
      }

      _homeScreenBloc.add(PostAuthUser(
          userAuthData: AuthModel(
              username: userController.text, password: passController.text)));

      print("FEZ LOGIN PORRAAAAAAAAAAAAA");
    }

    realizaCadastro() {}

    showPass() {
      setState(() {
        passIsEnabled = !passIsEnabled;
      });
    }

    return Scaffold(
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        bloc: _homeScreenBloc,
        builder: (context, state) {
          if (state is HomeScreenErrorState) {
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
                  controller: userController,
                  style: Theme.of(context).textTheme.labelSmall,
                  cursorColor: Theme.of(context).colorScheme.surface,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Theme.of(context)
                            .primaryColor, // Mantém a cor vermelha quando focado
                      ),
                    ),
                    labelText: "Usuário",
                    labelStyle: Theme.of(context).textTheme.labelSmall,
                    filled: true,
                    // fillColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextField(
                  style: Theme.of(context).textTheme.labelSmall,
                  controller: passController,
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
                            .primaryColor, // Mantém a cor vermelha quando focado
                      ),
                    ),
                    labelText: "Senha",
                    labelStyle: Theme.of(context).textTheme.labelSmall,
                    filled: true,
                    // fillColor: Theme.of(context).colorScheme.onPrimary,
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
                        onPressed: state is HomeScreenLoadingState
                            ? null
                            : () => validaLogin(),
                        child: state is HomeScreenLoadingState
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
                        onPressed: () => realizaCadastro(),
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
    _homeScreenBloc.close();
    super.dispose();
  }
}
