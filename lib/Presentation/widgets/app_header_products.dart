import 'package:fake_store_app/Domain/product_model.dart';
import 'package:fake_store_app/Presentation/cart_screen.dart';
import 'package:fake_store_app/Presentation/home_screen.dart';
import 'package:flutter/material.dart';

class AppHeaderProducts extends StatefulWidget {
  final bool searchActive;
  final ValueChanged<String>? onSearch;
  final List<ProductModel>? productsCart;
  final String? headerTitle;
  final bool isAdmin;

  const AppHeaderProducts(
      {Key? key,
      required this.searchActive,
      this.onSearch,
      this.productsCart,
      this.isAdmin = false,
      this.headerTitle})
      : super(key: key);

  @override
  State<AppHeaderProducts> createState() => _AppHeaderProductsState();
}

class _AppHeaderProductsState extends State<AppHeaderProducts> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _controller.clear();
        widget.onSearch!('');
      }
    });
  }

  redirectToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(productsCart: widget.productsCart!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
      child: Row(
        children: [
          widget.searchActive
              ? IconButton(
                  icon: Icon(
                    _isSearching ? Icons.close : Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: toggleSearch,
                )
              : IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (!widget.isAdmin) {
                      Navigator.pop(context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen(),
                        ),
                      );
                    }
                  },
                ),
          widget.searchActive
              ? Expanded(
                  child: _isSearching
                      ? TextField(
                          controller: _controller,
                          onSubmitted: widget.onSearch,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Buscar por título ou ID...',
                            hintStyle: const TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon:
                                  const Icon(Icons.search, color: Colors.white),
                              onPressed: () {
                                final query = _controller.text.trim();
                                widget.onSearch!(query);
                              },
                            ),
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            height: 40,
                            child: Image.asset("assets/HorizontalAppLogo.png"),
                          ),
                        ),
                )
              : Expanded(
                  child: Center(
                    child: Text(
                      "${widget.headerTitle}",
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
          widget.searchActive
              ? IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {
                    redirectToCart();
                  },
                )
              : SizedBox(
                  height: 40,
                  child: Image.asset("assets/AppLogo.png"),
                ),
        ],
      ),
    );
  }
}
