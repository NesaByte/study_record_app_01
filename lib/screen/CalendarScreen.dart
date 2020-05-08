import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_record_app_01/model/Record.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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

  Widget _buildDayDetailsHeader() {
    return _wrapCommonContainer(
      Text(
        DateFormat('yyyy/MM/dd EEEE', "ja_JP").format(_selectedDate),
        style: TextStyle(
          fontSize: 18.0
        ),
      )
    );
  }

  double _calcElaspedTime(final String fromDate, final String toDate) {
    int elaspedHour = int.parse(toDate.substring(8, 10)) - int.parse(fromDate.substring(8, 10));
    int elaspedMinute = int.parse(toDate.substring(10, 12)) - int.parse(fromDate.substring(10, 12));
    return (elaspedHour + (elaspedMinute / 60)).toDouble();
  }

  Map<IconData, double> _createSummaryMap(final String dateKey) {
    Map<IconData, double> summaryMap = {};
    _recordMap[dateKey].forEach((element) {
      IconData iconData = IconData(element.iconCodePoint, fontFamily: element.iconFontFamily);
      if (summaryMap.containsKey(iconData)) {
        summaryMap[iconData] += _calcElaspedTime(element.fromDate, element.toDate);
      } else {
        summaryMap[iconData] = _calcElaspedTime(element.fromDate, element.toDate);
      }
    });
    return summaryMap;
  }

  Widget _buildDayDetailsBody(final Map<IconData, double> summaryMap) {
    List<TableRow> _tableRows = <TableRow>[
      TableRow(
        children: [
          TableCell(
            child: Center(child: Text('Icon')),
            verticalAlignment: TableCellVerticalAlignment.middle,
          ),
          TableCell(
            child: Center(child: Text('Sum')),
            verticalAlignment: TableCellVerticalAlignment.middle,
          )
        ]
      )
    ];
    summaryMap.forEach((key, value) {
      _tableRows.add(
        TableRow(
          children: [
            TableCell(
              child: Center(child: Icon(key)),
              verticalAlignment: TableCellVerticalAlignment.middle,
            ),
            TableCell(
              child: Center(child: Text("${value.toStringAsFixed(2)}h")),
              verticalAlignment: TableCellVerticalAlignment.middle,
            )
          ]
        )
      );
    });
    return Table(
      border: TableBorder.all(color: Colors.grey, width: 1, style: BorderStyle.none),
      children: _tableRows
    );
  }

  Widget _buildDayDetails(final double maxWidth, final double maxHeight) {
    final String dateKey = DateFormat('yyyyMMdd', "ja_JP").format(_selectedDate);
    if (!_recordMap.containsKey(dateKey)) return _wrapCommonContainer(Text('NODATA'));

    final Map<IconData, double> summaryMap = _createSummaryMap(dateKey);
    return Column(
      children: <Widget>[
        SizedBox(
          width: maxWidth,
          height: maxHeight * 0.5,
          child: _buildDayDetailsBody(summaryMap)
        ),
        SizedBox(
          width: maxWidth,
          height: maxHeight * 0.5,
          child: HorizontalBarChart.fromSummaryMap(summaryMap)
        ),
      ],
    );
  }

  Widget _wrapCommonContainer(final Widget _widget) => Container(
    padding: EdgeInsets.all(8.0),
    child: _widget,
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: _buildTableCalendar(),
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.3,
              child: _buildDayDetails(size.width, size.height * 0.3)
            )
          ],
        )
      ),
    );
  }
}

class HorizontalBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  HorizontalBarChart(this.seriesList, {this.animate});

  factory HorizontalBarChart.fromSummaryMap(final Map<IconData, double> map) {
    return new HorizontalBarChart(
      _createData(map),
      animate: true,
    );
  }

  static List<charts.Series<RecordSummary, String>> _createData(final Map<IconData, double> map) {
    List<RecordSummary> data = [];
    map.forEach((key, value) => data.add(RecordSummary(key.toString(), value, Color.fromARGB(min(255, (255 / 10 * value).floor()), 0, 0, 255)))); // dummy color setting
    return [
      new charts.Series<RecordSummary, String>(
        id: 'Hours',
        domainFn: (RecordSummary sum, _) => sum.name,
        measureFn: (RecordSummary sum, _) => sum.hours,
        colorFn: (RecordSummary sum, _) => sum.color,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
    );
  }
}

class RecordSummary {
  final String name;
  final double hours;
  final charts.Color color;

  RecordSummary(this.name, this.hours, Color color)
      : this.color = new charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}