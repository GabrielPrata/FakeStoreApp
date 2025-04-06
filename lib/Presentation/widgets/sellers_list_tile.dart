import 'package:fake_store_app/Domain/user_model.dart';
import 'package:fake_store_app/Presentation/all_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SellersListTile extends StatefulWidget {
  final UserModel sellerData;
  const SellersListTile({
    Key? key,
    required this.sellerData,
  }) : super(key: key);

  @override
  State<SellersListTile> createState() => _SellersListTileState();
}

class _SellersListTileState extends State<SellersListTile> {
  saveSellerDataInStorage(UserModel sellerData) async {
    GetStorage box = GetStorage();
    box.write('sellerData', sellerData.toJson());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AllProductsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sellerData = widget.sellerData;

    return ListTile(
      onTap: () => saveSellerDataInStorage(sellerData),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(
          "${sellerData.firstName[0].toUpperCase()}${sellerData.lastName[0].toUpperCase()}",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.black,
              ),
        ),
      ),
      title: Text(
        "${sellerData.firstName} ${sellerData.lastName}",
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.white,
            ),
      ),
      trailing: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
    );
  }
}
