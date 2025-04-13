import 'package:dio/dio.dart';

class CurrencyHistoryService {
  final Dio _dio = Dio();

  Future<double> get(
    String fromSymbol,
    String toSymbol,
    String startDate,
    String endDate,
  ) async {
    try {
      final response = await _dio.get(
        'https://economia.awesomeapi.com.br/json/daily/$fromSymbol-$toSymbol/?start_date=$startDate&end_date=$endDate',
      );

      if (response.data is List && response.data.isNotEmpty) {
        return double.parse(response.data[0]['bid']);
      } else {
        throw Exception(
          'Error ao buscar ao buscar historico de $fromSymbol/$toSymbol nos intervalos de $startDate/$endDate',
        );
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
