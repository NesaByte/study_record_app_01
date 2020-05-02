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