import 'package:fake_store_app/Domain/product_model.dart';
import 'package:fake_store_app/Presentation/style/app_theme.dart';
import 'package:fake_store_app/Presentation/widgets/product_details_bottomsheet.dart';
import 'package:fake_store_app/util/alerts.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final ProductModel productData;
  final List<ProductModel> cart;

  const ProductCard({
    Key? key,
    required this.productData,
    required this.cart,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double roundReview(double nota) {
    return (nota * 2).round() / 2;
  }

  addItemToCart(ProductModel product) {
    if (widget.cart.length >= 10) {
      Alerts.showInfonackBar(
          "Somente 10 produtos podem ser adicionados ao carrinho!", context);
      return;
    }
    widget.cart.add(product);
  }

  removeItemToCart(ProductModel product) {
    widget.cart.remove(product);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Theme.of(context).colorScheme.primary,
            isScrollControlled: true,
            context: context,
            enableDrag: true,
            showDragHandle: true,
            builder: (BuildContext context) {
              return ProductDetailsBottomsheet(product: widget.productData);
            });
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.productData.image,
                    width: double.infinity,
                    height: 100,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.productData.title.length > 30
                      ? widget.productData.title.substring(0, 30) + "..."
                      : widget.productData.title,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 14,
                      ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        index < roundReview(widget.productData.rate).toInt()
                            ? Icons.star
                            : (index < roundReview(widget.productData.rate)
                                ? Icons.star_half
                                : Icons.star_border),
                        color: Colors.amber,
                      );
                    }),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      roundReview(widget.productData.rate).toString(),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      " (${widget.productData.totalReviews} avaliações)",
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                    child: Center(
                  child: Text(
                    "\$${widget.productData.price.toStringAsFixed(2)}",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppTheme.primaryColor, fontSize: 24),
                  ),
                )),
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: Icon(Icons.remove, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              removeItemToCart(widget.productData);
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "${widget.cart.where((item) => item.id == widget.productData.id).length}",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.add, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              addItemToCart(widget.productData);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
