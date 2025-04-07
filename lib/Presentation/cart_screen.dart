import 'package:fake_store_app/Presentation/payment_screen.dart';
import 'package:fake_store_app/Presentation/style/app_theme.dart';
import 'package:fake_store_app/Presentation/widgets/app_header_products.dart';
import 'package:fake_store_app/Presentation/widgets/cart_product_listview.dart';
import 'package:fake_store_app/util/alerts.dart';
import 'package:flutter/material.dart';
import 'package:fake_store_app/Domain/product_model.dart';

class CartScreen extends StatelessWidget {
  final List<ProductModel> productsCart;

  const CartScreen({Key? key, required this.productsCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<ProductModel, int> groupedProducts = {};
    for (var product in productsCart) {
      groupedProducts[product] = (groupedProducts[product] ?? 0) + 1;
    }

    final totalPrice = productsCart.fold<double>(
      0,
      (sum, item) => sum + item.price,
    );

    redirectToPaymentScreen() {
      if(productsCart.length == 0){
        Alerts.showInfonackBar("Adicone pelo menos 1 produto ao carrinho!", context);
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(totalPrice: totalPrice, productsCart: productsCart,),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AppHeaderProducts(
                searchActive: false,
                productsCart: productsCart,
                headerTitle: "Fechar Venda",
              ),
              Container(
                height: 2,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                color: AppTheme.primaryColor,
              ),
              SizedBox(
                height: 20,
              ),
              CartProductListView(groupedProducts: groupedProducts),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Total: ",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextSpan(
                      text: "R\$ ${totalPrice.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: Theme.of(context).filledButtonTheme.style,
                  onPressed: () {redirectToPaymentScreen();},
                  child: Text(
                    "PROSSEGUIR PARA O PAGAMENTO",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
