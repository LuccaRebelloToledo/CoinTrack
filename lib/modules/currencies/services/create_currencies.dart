import 'package:coin_track/modules/currencies/repositories/currency.dart';

import '../models/currency.dart';

class CreateCurrenciesService {
  final CurrencyRepository _currencyRepository = CurrencyRepository();

  Future<void> create(Currency currency) async {
    try {
      await _currencyRepository.create(currency);
    } catch (e) {
      throw Exception('Error fetching currencies: $e');
    }
  }
}
