import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'RecordListScreen.dart';

class CalendarScreen extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<CalendarScreen> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _navigateToRecordListScreen(final BuildContext context, final DateTime datetime) {
    final route = MaterialPageRoute(builder: (context) => RecordListScreen(datetime: datetime));
    Navigator.of(context).push(route);
  }

  void _onDaySelected(DateTime day, List events) {
    _navigateToRecordListScreen(context, day);
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'ja_JP',
      calendarController: _calendarController,
      onDayLongPressed: (day, events) => _onDaySelected(day, events),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildTableCalendar(),
    );
  }
}