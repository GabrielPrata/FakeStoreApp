import 'package:fake_store_app/Domain/product_model.dart';
import 'package:fake_store_app/Presentation/style/app_theme.dart';
import 'package:fake_store_app/Presentation/widgets/app_header_products.dart';
import 'package:fake_store_app/Presentation/widgets/category_filter.dart';
import 'package:fake_store_app/Presentation/widgets/product_card.dart';
import 'package:fake_store_app/Repository/products_repository.dart';
import 'package:fake_store_app/Service/bloc/products/products_bloc.dart';
import 'package:fake_store_app/Service/bloc/products/products_event.dart';
import 'package:fake_store_app/Service/bloc/products/products_state.dart';
import 'package:fake_store_app/util/alerts.dart';
import 'package:fake_store_app/util/api_error_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  late final ProductsBloc _productsBloc;
  late final ProductsRepository _productsRepository;
  List<ProductModel> productsCart = [];
  List<String> categories = ['Todos'];
  String selectedCategory = 'Todos';

  @override
  void initState() {
    super.initState();
    _productsRepository = ProductsRepository();
    _productsBloc = ProductsBloc(repository: _productsRepository);
    _productsBloc.add(GetAllProducts());
  }

  @override
  void dispose() {
    _productsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeaderProducts(
              searchActive: true,
              onSearch: (query) {
                _productsBloc.add(SearchProducts(query: query));
              },
              productsCart: productsCart,
            ),
            Container(
              height: 2,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 8),
            CategoryFilter(
              categories: categories,
              selectedCategory: selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category;
                });
                _productsBloc.add(FilterProductsByCategory(category: category));
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ProductsBloc, ProductsState>(
                bloc: _productsBloc,
                builder: (context, state) {
                  if (state is ProductsLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  } else if (state is ProductsLoadedState) {
                    final products = state.productsData;

                    if (categories.length == 1) {
                      final uniqueCategories =
                          products.map((e) => e.category).toSet().toList();

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          categories.addAll(uniqueCategories);
                        });
                      });
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height * 0.8),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                            productData: products[index], cart: productsCart);
                      },
                    );
                  } else if (state is ProductsErrorState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (state.exception is ApiErrorException) {
                        final error = state.exception as ApiErrorException;
                        Alerts.showErrorSnackBar(
                            "${error.statusCode} - ${error.errorDescription}",
                            context);
                      } else {
                        Alerts.showErrorSnackBar(
                            "${state.exception.toString()}", context);
                      }
                    });
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
