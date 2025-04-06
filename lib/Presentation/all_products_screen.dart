import 'package:fake_store_app/Presentation/widgets/app_header_products.dart';
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

  @override
  void initState() {
    super.initState();
    // Inicializa o repositório
    _productsRepository = ProductsRepository();
    // Cria o BLoC passando o repositório correto (não o próprio _sellerScreenBloc!)
    _productsBloc = ProductsBloc(repository: _productsRepository);
    // Dispara o evento para buscar os usuários da API
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
      backgroundColor:
          Theme.of(context).colorScheme.primary, // fundo azul escuro
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo e título centralizados
            AppHeaderProducts(),
            // Linha verde abaixo do título
            Container(
              height: 2,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            // Bloco responsável por exibir a lista de usuários
            Expanded(
              child: BlocBuilder<ProductsBloc, ProductsState>(
                bloc: _productsBloc,
                builder: (context, state) {
                  // Enquanto estiver carregando, exibe um indicador de progresso
                  if (state is ProductsLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  }
                  // Se os dados foram carregados, mapeia a lista para os widgets
                  else if (state is ProductsLoadedState) {
                    final products = state.productsData;
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: products.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        // Para cada usuário, passamos os dados para o SellersListTile
                        print(products[index]);
                        return ProductCard(productData: products[index]);
                      },
                    );
                  }
                  // Em caso de erro, exibe uma mensagem adequada
                  else if (state is ProductsErrorState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (state.exception is ApiErrorException) {
                        final error = state.exception as ApiErrorException;
                        Alerts.showErrorSnackBar(
                            "${error.statusCode} - ${error.errorDescription}",
                            context);
                      } else {
                        print(state.exception.toString());
                        Alerts.showErrorSnackBar(
                            "${state.exception.toString()}", context);
                      }
                    });
                  }
                  // Estado padrão (caso nenhum seja acionado)
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
