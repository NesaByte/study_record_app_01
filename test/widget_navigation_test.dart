import 'package:flutter_test/flutter_test.dart';
import 'package:study_record_app_01/main.dart';
import 'package:study_record_app_01/screen/RecordListScreen.dart';
import 'package:study_record_app_01/screen/RegisterRecordScreen.dart';

// class MockNavigationObserver extends Mock implements NavigatorObserver {}

void main() {
  group('RegisterRecordScreen navigation tests', () {

    Future<Null> _buildMainPage(WidgetTester tester) async {
      /*
      DateTime _datetime = DateTime.now();
      await tester.pumpWidget(MaterialApp(
        home: RecordListScreen(datetime: _datetime)
      ));
       */
      await tester.pumpWidget(App());
    }

    Future<Null> _navigateToRegisterRecordScreen(WidgetTester tester) async {
      await tester.tap(find.byKey(RecordListScreen.navigateToRegisterRecordScreenKey));
      await tester.pumpAndSettle();
    }

    testWidgets('navigate to RegisterRecordScreen', (WidgetTester tester) async {
      await _buildMainPage(tester);
      await _navigateToRegisterRecordScreen(tester);
      expect(find.byType(RegisterRecordScreen), findsOneWidget);
      expect(find.text('予定追加'), findsOneWidget);
    });
  });
}