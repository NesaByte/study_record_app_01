import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_record_app_01/model/Record.dart';
import 'package:table_calendar/table_calendar.dart';

import 'RecordListScreen.dart';

final Map<DateTime, List> _holidays = {
  DateTime(2020, 1, 1): ['元日'],
  DateTime(2020, 1, 13): ['成人の日'],
  DateTime(2020, 2, 11): ['建国記念の日'],
  DateTime(2020, 2, 23): ['天皇誕生日'],
  DateTime(2020, 2, 24): ['振替休日'],
  DateTime(2020, 3, 20): ['春分の日'],
  DateTime(2020, 4, 29): ['昭和の日'],
  DateTime(2020, 5, 3): ['憲法記念日'],
  DateTime(2020, 5, 4): ['みどりの日'],
  DateTime(2020, 5, 5): ['こどもの日'],
  DateTime(2020, 5, 6): ['振替休日'],
  DateTime(2020, 7, 23): ['海の日'],
  DateTime(2020, 7, 24): ['スポーツの日'],
  DateTime(2020, 8, 10): ['山の日'],
  DateTime(2020, 9, 21): ['敬老の日'],
  DateTime(2020, 9, 22): ['秋分の日'],
  DateTime(2020, 11, 3): ['文化の日'],
  DateTime(2020, 11, 23): ['勤労感謝の日'],
};



class CalendarScreen extends StatefulWidget {

  CalendarScreen(this.recordList);
  final List<Record> recordList;

  @override
  _State createState() => _State();
}

class _State extends State<CalendarScreen> {
  CalendarController _calendarController;
  DateTime _selectedDate;
  Map<DateTime, List> _events;
  Map<String, List<Record>> _recordMap;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _selectedDate = DateTime.now();
    _events = _createEvents(widget.recordList);
    _recordMap = _convertMap(widget.recordList);
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Map<DateTime, List> _createEvents(final List<Record> recordList) {
    Map<DateTime, List> results = {};
    recordList.forEach((element) {
      DateTime key = DateTime.parse(element.fromDate.substring(0, 8));
      if (results.containsKey(key)) {
        results[key].add(element.title);
      } else {
        results[key] = [element.title];
      }
    });
    return results;
  }

  Map<String, List<Record>> _convertMap(final List<Record> recordList) {
    Map<String, List<Record>> results = {};
    recordList.forEach((element) {
      String key = element.fromDate.substring(0, 8);
      if (results.containsKey(key)) {
        results[key].add(element);
      } else {
        results[key] = [element];
      }
    });
    return results;
  }

  void _navigateToRecordListScreen(final BuildContext context, final DateTime datetime) {
    final route = MaterialPageRoute(builder: (context) => RecordListScreen(datetime: datetime));
    Navigator.of(context).push(route);
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDate = day;
    });
    print(_selectedDate);
  }

  void _onDayLongPressed(DateTime day, List events) {
    _navigateToRecordListScreen(context, day);
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'ja_JP',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      onDaySelected: (day, events) => _onDaySelected(day, events),
      onDayLongPressed: (day, events) => _onDayLongPressed(day, events),
    );
  }

  Widget _buildDayDetails() {
    List<Widget> _children = <Widget>[];
    String dateKey = DateFormat('yyyyMMdd', "ja_JP").format(_selectedDate);
    _children.add(_wrapCommonContainer(
        Text(
          DateFormat('yyyy/MM/dd EEEE', "ja_JP").format(_selectedDate),
          style: TextStyle(
            fontSize: 18.0
          ),
        )
    ));
    if (_recordMap.containsKey(dateKey)) {
      Map<IconData, int> map = {};
      _recordMap[dateKey].forEach((element) {
        IconData iconData = IconData(element.iconCodePoint, fontFamily: element.iconFontFamily);
        if (map.containsKey(iconData)) {
          map[iconData]++;
        } else {
          map[iconData] = 1;
        }
      });
      List<Widget> _tableRowsHeader = <Widget>[];
      List<Widget> _tableRowsData = <Widget>[];
      map.forEach((key, value) {
        _tableRowsHeader.add(
          TableCell(
            child: Center(child: Icon(key)),
            verticalAlignment: TableCellVerticalAlignment.middle,
          )
        );
        _tableRowsData.add(
          TableCell(
            child: Center(child: Text(value.toString())),
            verticalAlignment: TableCellVerticalAlignment.middle,
          )
        );
      });
      _children.add(
        Table(
          border: TableBorder.all(color: Colors.grey, width: 1, style: BorderStyle.none),
          children: [
            TableRow(children: _tableRowsHeader),
            TableRow(children: _tableRowsData)
          ],
        )
      );
    } else {
      _children.add(_wrapCommonContainer(Text('NODATA')));
    }
    return Column(
      children: _children,
    );
  }

  Widget _wrapCommonContainer(final Widget _widget) => Container(
    padding: EdgeInsets.all(8.0),
    child: _widget,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          _buildTableCalendar(),
          _buildDayDetails(),
        ],
      ),
    );
  }
}