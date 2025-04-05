import '../models/conversion.dart';
import '../repositories/conversion.dart';

class GetConversionsService {
  final ConversionRepository _conversionRepository = ConversionRepository();

  Future<List<Conversion>> get() async {
    try {
      final List<Conversion> conversions =
          await _conversionRepository.readAll();

      return conversions;
    } catch (e) {
      throw Exception('Error fetching conversions: $e');
    }
  }
}
