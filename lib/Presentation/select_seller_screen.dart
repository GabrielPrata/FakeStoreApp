import 'package:fake_store_app/util/alerts.dart';
import 'package:fake_store_app/util/api_error_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store_app/Presentation/widgets/sellers_list_tile.dart';
import 'package:fake_store_app/Repository/users_repository.dart';
import 'package:fake_store_app/Service/bloc/users/users_bloc.dart';
import 'package:fake_store_app/Service/bloc/users/users_event.dart';
import 'package:fake_store_app/Service/bloc/users/users_state.dart';

class SelectSellerScreen extends StatefulWidget {
  const SelectSellerScreen({Key? key}) : super(key: key);

  @override
  _SelectSellerScreenState createState() => _SelectSellerScreenState();
}

class _SelectSellerScreenState extends State<SelectSellerScreen> {
  late final UsersBloc _usersBloc;
  late final UsersRepository _usersRepository;

  @override
  void initState() {
    super.initState();
    // Inicializa o repositório
    _usersRepository = UsersRepository();
    // Cria o BLoC passando o repositório correto (não o próprio _sellerScreenBloc!)
    _usersBloc = UsersBloc(repository: _usersRepository);
    // Dispara o evento para buscar os usuários da API
    _usersBloc.add(GetAllUsers());
  }

  @override
  void dispose() {
    _usersBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.primary, // fundo azul escuro
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo e título centralizados
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                    child: Image.asset("assets/AppLogo.png"),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Quem está usando o App?",
                    style: textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
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
              child: BlocBuilder<UsersBloc, UsersState>(
                bloc: _usersBloc,
                builder: (context, state) {
                  // Enquanto estiver carregando, exibe um indicador de progresso
                  if (state is UsersLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  }
                  // Se os dados foram carregados, mapeia a lista para os widgets
                  else if (state is UsersLoadedState) {
                    final sellers = state.sellersData;
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: sellers.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        // Para cada usuário, passamos os dados para o SellersListTile
                        return SellersListTile(sellerData: sellers[index]);
                      },
                    );
                  }
                  // Em caso de erro, exibe uma mensagem adequada
                  else if (state is UsersErrorState) {
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
                    return Center(
                      child: Text(
                        "Erro ao carregar usuários: ${state.exception.toString()}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
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
