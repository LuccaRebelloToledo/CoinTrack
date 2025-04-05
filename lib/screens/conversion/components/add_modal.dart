import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coin_track/modules/currencies/services/get_currencies.dart';
import 'package:coin_track/modules/exchange_rate_api/services/get_rate_pair_conversion.dart';
import 'package:coin_track/modules/conversions/services/create_conversions.dart';
import 'package:coin_track/modules/conversions/models/conversion.dart';

class ConversionAddController extends GetxController {
  var fromCurrency = ''.obs;
  var toCurrency = ''.obs;
  var rate = 0.0.obs;
  var result = 0.0.obs;
  var amount = 0.0.obs;
  var currencies = <String>[].obs;

  final GetCurrenciesService _getCurrenciesService = GetCurrenciesService();
  final GetRatePairConversionService _getRatePairConversionService =
      GetRatePairConversionService();
  final CreateConversionsService _createConversionsService =
      CreateConversionsService();

  @override
  void onInit() {
    super.onInit();
    fetchCurrencies();
  }

  Future<void> fetchCurrencies() async {
    try {
      final fetchedCurrencies = await _getCurrenciesService.get();
      currencies.assignAll(fetchedCurrencies.map((c) => c.symbol));
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao buscar moedas: $e');
    }
  }

  Future<void> fetchRate() async {
    if (fromCurrency.value.isNotEmpty &&
        toCurrency.value.isNotEmpty &&
        fromCurrency.value != toCurrency.value) {
      try {
        rate.value = await _getRatePairConversionService.get(
          fromCurrency.value,
          toCurrency.value,
        );
        calculateResult();
      } catch (e) {
        Get.snackbar('Erro', 'Falha ao buscar taxa de conversão: $e');
      }
    }
  }

  void calculateResult() {
    result.value = amount.value * rate.value;
  }

  void clearFields() {
    fromCurrency.value = '';
    toCurrency.value = '';
    rate.value = 0.0;
    amount.value = 0.0;
    result.value = 0.0;
  }

  Future<void> saveConversion() async {
    try {
      final conversion = Conversion(
        fromSymbol: fromCurrency.value,
        toSymbol: toCurrency.value,
        rate: rate.value,
        amount: amount.value,
        result: result.value,
      );

      await _createConversionsService.create(conversion);

      clearFields();
      Get.back(result: true);
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao salvar conversão: $e');
    }
  }
}

class ConversionAddModal extends StatelessWidget {
  late final ConversionAddController addController;

  ConversionAddModal({super.key}) {
    addController = Get.put(ConversionAddController());
    addController.amount.value = 0.0;
    addController.result.value = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () =>
              addController.currencies.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Adicionar Conversão',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: DropdownButton<String>(
                          value:
                              addController.fromCurrency.value.isEmpty
                                  ? null
                                  : addController.fromCurrency.value,
                          hint: Text(
                            'Selecione a Moeda de Origem',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                          dropdownColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          items:
                              addController.currencies
                                  .map(
                                    (currency) => DropdownMenuItem(
                                      value: currency,
                                      child: Text(
                                        currency,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(fontSize: 14),
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              addController.fromCurrency.value = value;
                              addController.fetchRate();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: DropdownButton<String>(
                          value:
                              addController.toCurrency.value.isEmpty
                                  ? null
                                  : addController.toCurrency.value,
                          hint: Text(
                            'Selecione a Moeda de Destino',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                          dropdownColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          items:
                              addController.currencies
                                  .where(
                                    (currency) =>
                                        currency !=
                                        addController.fromCurrency.value,
                                  )
                                  .map(
                                    (currency) => DropdownMenuItem(
                                      value: currency,
                                      child: Text(
                                        currency,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(fontSize: 14),
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              addController.toCurrency.value = value;
                              addController.fetchRate();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(fontSize: 14),
                          decoration: InputDecoration(
                            labelText: 'Quantidade',
                            labelStyle: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color ??
                                    Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            addController.amount.value =
                                double.tryParse(value) ?? 0.0;
                            addController.calculateResult();
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Taxa: ${addController.rate.value.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Resultado: ${addController.result.value.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: () => addController.saveConversion(),
                        child: const Text(
                          'Salvar',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
