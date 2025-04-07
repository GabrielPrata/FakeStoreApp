import 'package:fake_store_app/Domain/cart_model.dart';
import 'package:fake_store_app/Presentation/widgets/cart_details_bottomsheet.dart';
import 'package:flutter/material.dart';

class CartCard extends StatefulWidget {
  final CartModel cartData;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const CartCard({
    super.key,
    required this.cartData,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  double _calculateTotal() {
    return widget.cartData.products.fold(
      0.0,
      (total, product) => total + product.price,
    );
  }

  Widget buildLabeledText(String label, String value, BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "$label ",
        style: Theme.of(context).textTheme.labelSmall,
        children: [
          TextSpan(
            text: value,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showModalBottomSheet(
            backgroundColor: Theme.of(context).colorScheme.primary,
            isScrollControlled: true,
            context: context,
            enableDrag: true,
            showDragHandle: true,
            builder: (BuildContext context) {
              return CartDetailsBottomsheet(cartData: widget.cartData);
            },
          );
        });
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildLabeledText("Venda Id:", "${widget.cartData.id}", context),
              const SizedBox(height: 4),
              buildLabeledText(
                "Valor Total:",
                "R\$ ${_calculateTotal().toStringAsFixed(2)}",
                context,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: widget.onDelete,
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                  IconButton(
                    onPressed: widget.onEdit,
                    icon: const Icon(Icons.edit, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
