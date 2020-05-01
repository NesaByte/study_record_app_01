import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:study_record_app_01/core/DatabaseHelper.dart';
import 'package:study_record_app_01/model/Record.dart';

class RecordRepository {
  static final _tableName = 'RECORD';
  static final _primaryKeyName = 'id';
  static DatabaseHelper dbHelper = DatabaseHelper.instance;

  static void test() async {
    Database db = await dbHelper.getDatabase();
    print(await db.rawQuery("select name from sqlite_master where type='table';"));
    print(await db.query("sqlite_master", where: "type = ?", whereArgs: ["table"]));
    await db.execute("DELETE FROM RECORD");
    await db.execute('''
      INSERT INTO RECORD(
        id,
        title,
        kind,
        iconCodePoint,
        iconFontFamily,
        fromDate,
        toDate,
        version
      ) VALUES (
        1,
        "Ruby on Rails",
        "Programming",
        ${Icons.computer.codePoint},
        "${Icons.computer.fontFamily}",
        "${DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "090000"}",
        "${DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "104500"}",
        0
      );
    ''');
    await db.execute('''
      INSERT INTO RECORD(
        id,
        title,
        kind,
        iconCodePoint,
        iconFontFamily,
        fromDate,
        toDate,
        version
      ) VALUES (
        2,
        "初めてのGraphQL",
        "Reading",
        ${Icons.book.codePoint},
        "${Icons.book.fontFamily}",
        "${DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "124500"}",
        "${DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "151500"}",
        0
      );
    ''');
    await insert(Record(
      id: 3,
      title: 'Ruby on Rails',
      kind: 'Programming',
      iconCodePoint: Icons.computer.codePoint,
      iconFontFamily: Icons.computer.fontFamily,
      fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "090000",
      toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "104500",
      version: 0
    ));
    await insert(Record(
      id: 4,
      title: '初めてのGraphQL',
      kind: 'Reading',
      iconCodePoint: Icons.book.codePoint,
      iconFontFamily: Icons.book.fontFamily,
      fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "124500",
      toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "151500",
      version: 0
    ));
    List<Map<String, dynamic>> rows = await db.query(DatabaseHelper.tableNameRecord);
    print(rows);
  }

  static Future<List<Record>> selectAll() async {
    final List<Map<String, dynamic>> rows = await dbHelper.selectAllRows(_tableName);
    List<Record> dtos = [];
    rows.forEach((row) => dtos.add(Record.fromJson(row)));
    return dtos;
  }

  static Future<Record> selectOne(final int id) async {
    final Map<String, dynamic> row = await dbHelper.selectOneRow(
      _primaryKeyName,
      id.toString(),
      _tableName
    );
    if (row == null) {
      return null;
    } else {
      return Record.fromJson(row);
    }
  }

  static Future<int> insert(final Record dto) async {
    return await dbHelper.insert(dto.toJson(), _tableName);
  }
}