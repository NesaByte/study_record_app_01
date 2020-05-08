import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:study_record_app_01/main.dart';
import 'package:study_record_app_01/screen/RecordListScreen.dart';
import 'package:study_record_app_01/screen/RegisterRecordScreen.dart';

// class MockNavigationObserver extends Mock implements NavigatorObserver {}

void main() {
  Future<Null> _buildMainPage(WidgetTester tester) async {
    await tester.pumpWidget(App());
  }

  Future<Null> _navigateToRegisterRecordScreen(WidgetTester tester) async {
    await tester.tap(find.byKey(RecordListScreen.navigateToRegisterRecordScreenKey));
    await tester.pumpAndSettle(Duration(seconds: 5));
  }

  /*
  Future<Null> _navigateToHome(WidgetTester tester) async {
    await tester.tap(find.byKey(RecordListScreen.navigateToTodayRecordListScreenKey));
    await tester.pumpAndSettle(Duration(seconds: 5));
  }

  Future<Null> _navigateToYesterdayRecordListScreen(WidgetTester tester) async {
    await tester.tap(find.byKey(RecordListScreen.navigateToYesterdayRecordListScreenKey));
    await tester.pump(Duration(seconds: 5));
  }

  Future<Null> _navigateToTomorrowRecordListScreen(WidgetTester tester) async {
    await tester.tap(find.byKey(RecordListScreen.navigateToTomorrowRecordListScreenKey));
    await tester.pump(Duration(seconds: 5));
  }
   */

  group("", () {
    testWidgets('navigate to RegisterRecordScreen', (WidgetTester tester) async {
      initializeDateFormatting();
      await _buildMainPage(tester);
      await _navigateToRegisterRecordScreen(tester);
      expect(find.byType(RegisterRecordScreen), findsOneWidget);
      expect(find.text('予定追加'), findsOneWidget);

      await tester.pageBack();
      await tester.pump(Duration(seconds: 5));
      expect(find.byType(RecordListScreen), findsOneWidget);
   });

    /*
    testWidgets('navigate to home', (WidgetTester tester) async {
      initializeDateFormatting();
      await _buildMainPage(tester);
      await _navigateToHome(tester);
      expect(find.byType(RecordListScreen), findsOneWidget);
      DateTime _datetime = DateTime.now();
      expect(find.text(DateFormat('yyyy/MM/dd EEEE', "ja_JP").format(_datetime)), findsOneWidget);
    });
    */
  });
}