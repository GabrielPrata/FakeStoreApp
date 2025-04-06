import 'package:flutter/material.dart';

class AppHeaderProducts extends StatefulWidget {
  const AppHeaderProducts({
    Key? key,
  }) : super(key: key);

  @override
  State<AppHeaderProducts> createState() => _AppHeaderProductsState();
}

class _AppHeaderProductsState extends State<AppHeaderProducts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              Expanded(
                child: Center(
                  child: SizedBox(
                    height: 40,
                    child: Image.asset("assets/HorizontalAppLogo.png"),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.shopping_cart, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
