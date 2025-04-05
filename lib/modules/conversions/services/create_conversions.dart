import '../models/conversion.dart';
import '../repositories/conversion.dart';

class CreateConversionsService {
  final ConversionRepository _conversionRepository = ConversionRepository();

  Future<void> create(Conversion conversion) async {
    try {
      await _conversionRepository.create(conversion);
    } catch (e) {
      throw Exception('Error creating conversion: $e');
    }
  }
}
