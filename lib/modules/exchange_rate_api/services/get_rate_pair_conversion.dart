import 'package:coin_track/shared/constants/exchange_rate_api.dart';
import 'package:dio/dio.dart';

class GetRatePairConversionService {
  final Dio _dio = Dio();

  Future<double> get(String fromSymbol, String toSymbol) async {
    try {
      final response = await _dio.get(
        '$exchangeRateAPIBaseURL/pair/$fromSymbol/$toSymbol',
      );
      if (response.data['result'] == 'success') {
        return response.data['conversion_rate'];
      } else {
        throw Exception(
          'Error ao buscar a taxa de conversão para $fromSymbol/$toSymbol',
        );
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
