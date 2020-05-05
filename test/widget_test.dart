// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:study_record_app_01/main.dart';
import 'package:study_record_app_01/screen/RecordListScreen.dart';
import 'package:study_record_app_01/screen/RegisterRecordScreen.dart';

void main() {

  testWidgets('App unit test', (WidgetTester tester) async {
    initializeDateFormatting();
    final String _today = DateFormat('yyyy/MM/dd EEEE', "ja_JP").format(DateTime.now());

    // Build our app and trigger a frame.
    await tester.pumpWidget(App());
    expect(find.text(_today), findsOneWidget);
    expect(find.byIcon(Icons.arrow_left), findsOneWidget);
    expect(find.byIcon(Icons.arrow_right), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
  });

  testWidgets('RecordListScreen unit test', (WidgetTester tester) async {
    initializeDateFormatting();
    final String _today = DateFormat('yyyy/MM/dd EEEE', "ja_JP").format(DateTime.now());

    await tester.pumpWidget(MaterialApp(
        title: 'Study Record',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: RecordListScreen(datetime: DateTime.now())
    ));

    expect(find.text(_today), findsOneWidget);
    expect(find.byIcon(Icons.arrow_left), findsOneWidget);
    expect(find.byIcon(Icons.arrow_right), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
  });

  testWidgets('RegisterRecordScreen unit test', (WidgetTester tester) async {
    initializeDateFormatting();
    final String _today = DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now());

    await tester.pumpWidget(MaterialApp(
        title: 'Study Record',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: RegisterRecordScreen(initialDate: _today)
    ));

    expect(find.text('予定追加'), findsOneWidget);
  });
}
