import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:study_record_app_01/screen/RecordListScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return MaterialApp(
      title: 'Study Record',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: RecordListScreen(datetime: DateTime.now()), // TODO: dummy
    );
  }
}
