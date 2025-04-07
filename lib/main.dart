import 'package:fake_store_app/Presentation/home_screen.dart';
import 'package:fake_store_app/Presentation/style/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
   await GetStorage.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Instanciar o tema com base no contexto.
    final appTheme = AppTheme(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme.mainTheme, // Passar o tema criado diretamente
      home: const HomeScreen(),
    );
  }
}
