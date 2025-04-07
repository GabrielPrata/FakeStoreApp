import 'package:flutter/material.dart';
import 'package:fake_store_app/Domain/product_model.dart';
import 'package:fake_store_app/Presentation/style/app_theme.dart';

class CartProductListView extends StatelessWidget {
  final Map<ProductModel, int> groupedProducts;

  const CartProductListView({Key? key, required this.groupedProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: groupedProducts.length,
        itemBuilder: (context, index) {
          final product = groupedProducts.keys.elementAt(index);
          final quantity = groupedProducts[product] ?? 1;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${product.id} - ",
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                            TextSpan(
                              text: "${product.title.length > 25 ? product.title.substring(0, 25) + "..." : product.title}",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "R\$ ${product.price.toStringAsFixed(2)}",
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: AppTheme.primaryColor,
                                ),
                          ),
                          const Spacer(),
                          Text(
                            "x$quantity",
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: AppTheme.primaryColor,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.image,
                    height: 60,
                    width: 60,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
