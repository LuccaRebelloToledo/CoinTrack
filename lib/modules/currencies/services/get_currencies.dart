import 'package:coin_track/modules/currencies/repositories/currency.dart';

import '../models/currency.dart';

class GetCurrenciesService {
  final CurrencyRepository _currencyRepository = CurrencyRepository();

  Future<List<Currency>> get() async {
    try {
      final List<Currency> currencies = await _currencyRepository.readAll();

      return currencies;
    } catch (e) {
      throw Exception('$e');
    }
  }
}
