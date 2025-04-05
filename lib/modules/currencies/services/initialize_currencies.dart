import 'package:coin_track/modules/currencies/models/currency.dart';
import 'package:coin_track/modules/currencies/services/create_currencies.dart';
import 'package:coin_track/modules/currencies/services/get_currencies.dart';
import 'package:coin_track/modules/exchange_rate_api/services/get_supported_codes.dart';

class InitializeCurrenciesService {
  final GetCurrenciesService _getCurrenciesService = GetCurrenciesService();
  final CreateCurrenciesService _createCurrenciesService =
      CreateCurrenciesService();
  final GetSupportedCodesService _getSupportedCodesService =
      GetSupportedCodesService();

  Future<void> initialize() async {
    try {
      final currencies = await _getCurrenciesService.get();

      if (currencies.isEmpty) {
        final supportedCodes = await _getSupportedCodesService.get();

        for (var code in supportedCodes) {
          final currency = Currency(symbol: code.code, name: code.name);
          await _createCurrenciesService.create(currency);
        }
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
