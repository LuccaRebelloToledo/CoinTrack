import '../../../shared/database/database.dart';
import '../models/conversion.dart';

class ConversionRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> create(Conversion conversion) async {
    final db = await _databaseHelper.database;

    return await db.insert('conversions', {
      'from_symbol': conversion.fromSymbol,
      'to_symbol': conversion.toSymbol,
      'rate': conversion.rate,
      'amount': conversion.amount,
      'result': conversion.result,
    });
  }

  Future<List<Conversion>> readAll() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('conversions');

    return maps.map((map) => Conversion.fromMap(map)).toList();
  }

  Future<Conversion?> read(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'conversions',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Conversion.fromMap(maps.first);
    }

    return null;
  }

  Future<int> update(Conversion conversion) async {
    final db = await _databaseHelper.database;

    return await db.update(
      'conversions',
      {
        'from_symbol': conversion.fromSymbol,
        'to_symbol': conversion.toSymbol,
        'rate': conversion.rate,
        'amount': conversion.amount,
        'result': conversion.result,
      },
      where: 'id = ?',
      whereArgs: [conversion.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _databaseHelper.database;

    return await db.delete('conversions', where: 'id = ?', whereArgs: [id]);
  }
}
