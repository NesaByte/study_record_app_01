import 'package:flutter/material.dart';
import 'package:study_record_app_01/screen/RecordListScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Record',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: RecordListScreen(date: '20200427'), // TODO: dummy
    );
  }
}
