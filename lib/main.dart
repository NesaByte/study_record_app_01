import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:study_record_app_01/core/DatabaseHelper.dart';
import 'package:study_record_app_01/repository/RecordRepository.dart';
import 'package:study_record_app_01/screen/RecordListScreen.dart';
import 'package:study_record_app_01/service/RecordService.dart';

import 'model/Record.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    createTestData();

    return MaterialApp(
      title: 'Study Record',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: RecordListScreen(datetime: DateTime.now()), // TODO: dummy
    );
  }

  // for test
  void createTestData() async {
    Database db = await DatabaseHelper.instance.getDatabase();
    print(await db.rawQuery("select name from sqlite_master where type='table';"));
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
        "${DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "0900"}",
        "${DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1045"}",
        0
      );
    ''');
    await RecordRepository.insert(Record(
        id: 2,
        title: 'Golang / go-gin',
        kind: 'Programming',
        iconCodePoint: Icons.computer.codePoint,
        iconFontFamily: Icons.computer.fontFamily,
        fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "0900",
        toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1045",
        version: 0
    ));
    await RecordService.insert(Record(
        id: 1,
        title: '初めてのGraphQL',
        kind: 'Reading',
        iconCodePoint: Icons.book.codePoint,
        iconFontFamily: Icons.book.fontFamily,
        fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1245",
        toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1515",
        version: 0
    ));
  }
}
