import 'package:fake_store_app/Domain/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final ProductModel productData;
  const ProductCard({
    Key? key,
    required this.productData,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final productData = widget.productData;

    return Container(
      child: Column(children: [
        SizedBox(
          height: 70,
          child: Image.network(productData.image),
        )
         ,
        ]
      ),
    );
  }
}
