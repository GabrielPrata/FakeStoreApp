import 'package:fake_store_app/Presentation/widgets/app_header_products.dart';
import 'package:fake_store_app/Presentation/widgets/dropdown_menu_custom.dart';
import 'package:fake_store_app/util/alerts.dart';
import 'package:flutter/material.dart';
import 'package:fake_store_app/Presentation/style/app_theme.dart';

class PaymentScreen extends StatefulWidget {
  final double totalPrice;

  const PaymentScreen({Key? key, required this.totalPrice}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController _dropdownController = TextEditingController();

  final TextEditingController _receivedValueController =
      TextEditingController();

  final List<String> paymentOptions = [
    'Dinheiro',
    'Pix',
    'Cartão de Crédito',
    'Cartão de Débito',
  ];

  double get receivedValue {
    final value =
        double.tryParse(_receivedValueController.text.replaceAll(',', '.'));
    return value ?? 0;
  }

  @override
  void initState() {
    super.initState();
    _dropdownController.text = "Dinheiro";
  }

  double get changeValue => receivedValue - widget.totalPrice;

  concludeSale() {
    if(receivedValue < widget.totalPrice) {
      Alerts.showInfonackBar("O valor recebido não pode ser menor do que o valor total da venda!", context);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AppHeaderProducts(
                searchActive: false,
                headerTitle: "Fechar Venda",
              ),
              Container(
                height: 2,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Forma de Pagamento",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: DropdownMenu<String>(
                  controller: _dropdownController,
                  initialSelection: paymentOptions.first,
                  onSelected: (String? value) {
                    if (value != 'Dinheiro') {
                      Alerts.showInfonackBar(
                          "Apenas o pagamento em dinheiro está ativo!",
                          context);
                      setState(() => _dropdownController.text = 'Dinheiro');
                    }
                  },
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  menuStyle: MenuStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                  ),
                  dropdownMenuEntries: paymentOptions.map((option) {
                    final isEnabled = option == 'Dinheiro';

                    return DropdownMenuEntry<String>(
                      value: option,
                      label: option,
                      labelWidget: Text(
                        option,
                        style: TextStyle(
                          color: isEnabled ? Colors.black : Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  style: Theme.of(context).textTheme.labelSmall,
                  cursorColor: Theme.of(context).colorScheme.surface,
                  controller: _receivedValueController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    labelText: "Valor recebido",
                    labelStyle: Theme.of(context).textTheme.labelSmall,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 40),
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
                      text: "R\$ ${widget.totalPrice.toStringAsFixed(2)}\n",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              changeValue > 0
                  ? Center(
                      child: Text(
                        "Troco: R\$ ${changeValue.toStringAsFixed(2)}",
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    )
                  : SizedBox(),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: Theme.of(context).filledButtonTheme.style,
                  onPressed: () {
                    concludeSale();
                  },
                  child: Text(
                    "FINALIZAR VENDA",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dropdownController.dispose();
    super.dispose();
  }
}
