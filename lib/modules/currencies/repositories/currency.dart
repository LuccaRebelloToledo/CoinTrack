import 'package:coin_track/modules/currencies/models/currency.dart';
import 'package:sqflite/sqflite.dart';
import '../../../shared/database/database.dart';

class CurrencyRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final String tableName = 'currencies';

  Future<void> create(Currency currency) async {
    final db = await _databaseHelper.database;

    await db.insert(
      tableName,
      currency.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Currency>> readAll() async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return maps.map((map) => Currency.fromMap(map)).toList();
  }

  Future<Currency?> read(String symbol) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'symbol = ?',
      whereArgs: [symbol],
    );

    if (maps.isNotEmpty) {
      return Currency.fromMap(maps.first);
    }

    return null;
  }

  Future<void> update(Currency currency) async {
    final db = await _databaseHelper.database;

    await db.update(
      tableName,
      currency.toMap(),
      where: 'symbol = ?',
      whereArgs: [currency.symbol],
    );
  }

  Future<void> delete(String symbol) async {
    final db = await _databaseHelper.database;

    await db.delete(tableName, where: 'symbol = ?', whereArgs: [symbol]);
  }
}
