import '../models/conversion.dart';
import '../repositories/conversion.dart';

class DeleteConversionsService {
  final ConversionRepository _conversionRepository = ConversionRepository();

  Future<void> delete(Conversion conversion) async {
    try {
      if (conversion.id == null) {
        throw Exception('Conversion ID is null');
      }

      await _conversionRepository.delete(conversion.id!);
    } catch (e) {
      throw Exception('Error creating conversion: $e');
    }
  }
}
