import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'coin_track.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE currencies (
        symbol TEXT PRIMARY KEY,
        name TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE conversions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        from_symbol TEXT NOT NULL,
        to_symbol TEXT NOT NULL,
        rate REAL NOT NULL,
        amount REAL NOT NULL,
        result REAL NOT NULL,
        FOREIGN KEY (from_symbol) REFERENCES currencies (symbol),
        FOREIGN KEY (to_symbol) REFERENCES currencies (symbol)
      )
    ''');
  }

  Future<void> initializeDatabase() async {
    await database;
  }
}
