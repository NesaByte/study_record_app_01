import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:study_record_app_01/core/DatabaseHelper.dart';
import 'package:study_record_app_01/repository/RecordRepository.dart';
import 'package:study_record_app_01/screen/RecordListScreen.dart';
import 'package:study_record_app_01/service/RecordService.dart';

import 'model/Record.dart';

void main() {
  initializeDateFormatting();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Record',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: createHomeForDevelopment(), // for development env.
      // home: RecordListScreen(datetime: DateTime.now()), // for production env.
    );
  }
}

Widget createHomeForDevelopment() {
  return FutureBuilder<int>(
    future: resetTestData(),
    builder: (context, future) {
      if (!future.hasData) {
        return Center(
          child: Container(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          ),
        );
      }
      print("TEST DATA SUMMURY: RECORD count=${future.data.toString()}");
      return RecordListScreen(datetime: DateTime.now());
    },
  );
}

Future<int> resetTestData() async {
  Database db = await DatabaseHelper.instance.getDatabase();
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
      "${DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "0930"}",
      "${DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1100"}",
      0
    );
  ''');
  await RecordRepository.insert(Record(
    id: 2,
    title: 'Golang / go-gin',
    kind: 'Programming',
    iconCodePoint: Icons.computer.codePoint,
    iconFontFamily: Icons.computer.fontFamily,
    fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1115",
    toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1200",
    version: 0
  ));
  await RecordService.insert(Record(
    id: 3,
    title: '初めてのGraphQL',
    kind: 'Reading',
    iconCodePoint: Icons.book.codePoint,
    iconFontFamily: Icons.book.fontFamily,
    fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1215",
    toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1245",
    version: 0
  ));
  await RecordService.insert(Record(
    id: 4,
    title: '昼ごはん',
    kind: 'Break',
    iconCodePoint: Icons.free_breakfast.codePoint,
    iconFontFamily: Icons.free_breakfast.fontFamily,
    fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1300",
    toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1345",
    version: 0
  ));
  await RecordService.insert(Record(
    id: 5,
    title: '仕事 / 執筆',
    kind: 'Work',
    iconCodePoint: Icons.work.codePoint,
    iconFontFamily: Icons.work.fontFamily,
    fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1400",
    toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1615",
    version: 0
  ));
  await RecordRepository.insert(Record(
    id: 6,
    title: 'Golang / go-gin',
    kind: 'Programming',
    iconCodePoint: Icons.computer.codePoint,
    iconFontFamily: Icons.computer.fontFamily,
    fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1615",
    toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1730",
    version: 0
  ));
  await RecordRepository.insert(Record(
    id: 7,
    title: '仕事 / WEB制作',
    kind: 'Work',
    iconCodePoint: Icons.computer.codePoint,
    iconFontFamily: Icons.computer.fontFamily,
    fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1730",
    toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1815",
    version: 0
  ));
  await RecordService.insert(Record(
    id: 8,
    title: '夕ご飯',
    kind: 'Break',
    iconCodePoint: Icons.free_breakfast.codePoint,
    iconFontFamily: Icons.free_breakfast.fontFamily,
    fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1815",
    toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1930",
    version: 0
  ));
  await RecordService.insert(Record(
    id: 9,
    title: '休憩(風呂&家事&映画)',
    kind: 'Break',
    iconCodePoint: Icons.free_breakfast.codePoint,
    iconFontFamily: Icons.free_breakfast.fontFamily,
    fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "1945",
    toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "2115",
    version: 0
  ));
  await RecordService.insert(Record(
    id: 10,
    title: 'エクストリームプログラミング',
    kind: 'Reading',
    iconCodePoint: Icons.book.codePoint,
    iconFontFamily: Icons.book.fontFamily,
    fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "2130",
    toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "2145",
    version: 0
  ));
  await RecordService.insert(Record(
    id: 11,
    title: 'テスト駆動開発',
    kind: 'Reading',
    iconCodePoint: Icons.book.codePoint,
    iconFontFamily: Icons.book.fontFamily,
    fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "2145",
    toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "2215",
    version: 0
  ));
  await RecordService.insert(Record(
    id: 12,
    title: 'Dart / Flutter',
    kind: 'Programming',
    iconCodePoint: Icons.computer.codePoint,
    iconFontFamily: Icons.computer.fontFamily,
    fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "2215",
    toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "2300",
    version: 0
  ));
  await RecordService.insert(Record(
    id: 13,
    title: '仕事 (yesterday)',
    kind: 'Test',
    iconCodePoint: Icons.work.codePoint,
    iconFontFamily: Icons.work.fontFamily,
    fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now().add(Duration(days: -1))) + "0900",
    toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now().add(Duration(days: -1))) + "1800",
    version: 0
  ));
  await RecordService.insert(Record(
    id: 14,
    title: '仕事 (tommorow)',
    kind: 'Test',
    iconCodePoint: Icons.work.codePoint,
    iconFontFamily: Icons.work.fontFamily,
    fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now().add(Duration(days: 1))) + "0900",
    toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now().add(Duration(days: 1))) + "1800",
    version: 0
  ));
  return DatabaseHelper.instance.countAllRows("RECORD");
}