import '../models/conversion.dart';
import '../repositories/conversion.dart';

class UpdateConversionsService {
  final ConversionRepository _conversionRepository = ConversionRepository();

  Future<void> update(Conversion conversion) async {
    try {
      await _conversionRepository.update(conversion);
    } catch (e) {
      throw Exception('Error updating conversion: $e');
    }
  }
}
