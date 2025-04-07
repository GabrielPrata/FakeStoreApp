import 'package:fake_store_app/Domain/cart_model.dart';
import 'package:fake_store_app/Presentation/all_products_screen.dart';
import 'package:fake_store_app/Presentation/style/app_theme.dart';
import 'package:fake_store_app/Presentation/widgets/app_header_products.dart';
import 'package:fake_store_app/Presentation/widgets/cart_card.dart';
import 'package:fake_store_app/Repository/cart_repository.dart';
import 'package:fake_store_app/Service/bloc/cart/cart_bloc.dart';
import 'package:fake_store_app/Service/bloc/cart/cart_event.dart';
import 'package:fake_store_app/Service/bloc/cart/cart_state.dart';
import 'package:fake_store_app/util/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late final CartRepository _cartRepository;
  late final CartBloc _cartBloc;

  @override
  void initState() {
    super.initState();
    _cartRepository = CartRepository();
    _cartBloc = CartBloc(repository: _cartRepository);
    _cartBloc.add(GetAllCarts());
  }

  @override
  void dispose() {
    _cartBloc.close();
    super.dispose();
  }

  deleteCart(CartModel cartData, BuildContext context) {
    _cartBloc.add(DeleteCart(cartData: cartData));
  }

  redirectToProductsScreen(CartModel cartData) {
    GetStorage box = GetStorage();
    box.write('cartId', cartData.id);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) =>
                AllProductsScreen(productsCartWidget: cartData.products)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(children: [
          AppHeaderProducts(
            searchActive: false,
            headerTitle: "Painel Administrativo",
            isAdmin: true,
          ),
          Container(
            height: 2,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: AppTheme.primaryColor,
          ),
          Expanded(
            child: BlocProvider.value(
              value: _cartBloc,
              child: BlocConsumer<CartBloc, CartState>(
                listener: (context, state) {
                  if (state is CartDeletedState) {
                    Alerts.showSuccessSnackBar(
                        "Carrinho excluído com sucesso!", context);
                  } else if (state is CartErrorState) {
                    Alerts.showErrorSnackBar(
                        "Erro! ${state.exception}", context);
                  }
                },
                builder: (context, state) {
                  if (state is CartLoadingState) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  } else if (state is CartAdminLoadedState ||
                      state is CartDeletedState) {
                    final carts = state.allCarts ?? [];
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: carts.length,
                      itemBuilder: (context, index) {
                        final cart = carts[index];
                        return CartCard(
                          cartData: cart,
                          onDelete: () => deleteCart(cart, context),
                          onEdit: () {
                            redirectToProductsScreen(cart);
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("Estado desconhecido"));
                  }
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
