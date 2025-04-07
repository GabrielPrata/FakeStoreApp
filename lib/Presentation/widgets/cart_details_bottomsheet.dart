import 'package:fake_store_app/Domain/cart_model.dart';
import 'package:fake_store_app/Domain/product_model.dart';
import 'package:fake_store_app/Presentation/widgets/cart_product_listview.dart';
import 'package:flutter/material.dart';

class CartDetailsBottomsheet extends StatelessWidget {
  final CartModel cartData;

  const CartDetailsBottomsheet({Key? key, required this.cartData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

     final Map<ProductModel, int> groupedProducts = {};
     print(cartData.products.length);
    for (var product in cartData.products) {
      groupedProducts[product] = (groupedProducts[product] ?? 0) + 1;
    }

    return FractionallySizedBox(
      heightFactor: 0.8, 
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Detalhes do Carrinho',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Flexible(
              child: CartProductListView(groupedProducts: groupedProducts)
            ),
          ],
        ),
      ),
    );
  }
}
