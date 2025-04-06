import 'package:coin_track/modules/conversions/services/get_conversions.dart';
import 'package:coin_track/modules/exchange_rate_api/services/get_rate_pair_conversion.dart';

import '../models/conversion.dart';
import '../repositories/conversion.dart';

class GetAndUpdateLatestRatesService {
  final ConversionRepository _conversionRepository = ConversionRepository();
  final GetConversionsService _getConversionsService = GetConversionsService();
  final GetRatePairConversionService _getRatePairConversionService =
      GetRatePairConversionService();

  Future<void> update() async {
    try {
      List<Conversion> conversions = await _getConversionsService.get();

      if (conversions.isNotEmpty) {
        for (var conversion in conversions) {
          final rate = await _getRatePairConversionService.get(
            conversion.fromSymbol,
            conversion.toSymbol,
          );

          if (rate != conversion.rate) {
            conversion.rate = rate;
            conversion.result = conversion.amount * rate;
            await _conversionRepository.update(conversion);
          }
        }
      }
    } catch (e) {
      throw Exception('Error updating conversions rate: $e');
    }
  }
}
