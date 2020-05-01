import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = 'study_record_one_db.db';
  static final _dbVersion = 1;

  static final tableNameRecord = 'RECORD';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> getDatabase() async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _dbName);
    await deleteDatabase(path);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableNameRecord (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        kind TEXT NOT NULL,
        iconCodePoint INTEGER NOT NULL,
        iconFontFamily TEXT NOT NULL,
        fromDate TEXT NOT NULL,
        toDate TEXT NOT NULL,
        version INTEGER NOT NULL
      );
    ''');
  }

  Future<int> insert(final Map<String, dynamic> row, final String table) async {
    final Database db = await instance.getDatabase();
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> selectAllRows(final String table) async {
    final Database db = await instance.getDatabase();
    return await db.query(table);
  }

  Future<Map<String, dynamic>> selectOneRow(final String primaryKeyName, final String primaryKeyValue, final String table) async {
    final Database db = await instance.getDatabase();
    final List result = await db.query(table, where: '$primaryKeyName = ?', whereArgs: [primaryKeyValue]);
    if (result.length == 1) {
      return result[0];
    } else {
      return null; // Unexpected
    }
  }

  Future<int> countAllRows(final String table) async {
    final Database db = await instance.getDatabase();
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(final Map<String, dynamic> row, final String primaryKeyName, final String table) async {
    final Database db = await instance.getDatabase();
    final primaryKey = row[primaryKeyName];
    return await db.update(table, row, where: '$primaryKey = ?', whereArgs: [primaryKeyName]);
  }

  Future<int> delete(final String primaryKeyName, final String primaryKeyValue, final String table) async {
    Database db = await instance.getDatabase();
    return await db.delete(table, where: '$primaryKeyName = ?', whereArgs: [primaryKeyValue]);
  }
}