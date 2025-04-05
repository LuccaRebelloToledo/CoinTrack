import 'package:coin_track/modules/exchange_rate_api/models/supported_code.dart';
import 'package:coin_track/shared/constants/exchange_rate_api.dart';
import 'package:dio/dio.dart';

class GetSupportedCodesService {
  final Dio _dio = Dio();
  final supportedCodesURL = '$exchangeRateAPIBaseURL/codes';

  Future<List<SupportedCode>> get() async {
    try {
      final response = await _dio.get(supportedCodesURL);
      if (response.data['result'] == 'success') {
        return (response.data['supported_codes'] as List)
            .map((code) => SupportedCode.fromJson(code))
            .toList();
      } else {
        throw Exception('Failed to fetch supported codes');
      }
    } catch (e) {
      throw Exception('Error fetching supported codes: $e');
    }
  }
}
