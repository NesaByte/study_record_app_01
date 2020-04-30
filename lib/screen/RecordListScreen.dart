import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_record_app_01/model/Record.dart';
import 'package:study_record_app_01/screen/RegisterRecordScreen.dart';

class RecordListScreen extends StatefulWidget {
  RecordListScreen({Key key, this.datetime}) : super(key: key);

  final DateTime datetime;

  @override
  _State createState() => _State();
}

class _State extends State<RecordListScreen> {
  final _testDataList = [
    Record(
      title: 'Ruby on Rails',
      kind: 'Programming',
      iconCodePoint: Icons.computer.codePoint,
      iconFontFamily: Icons.computer.fontFamily,
      fromDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "090000",
      toDate: DateFormat('yyyyMMdd', "ja_JP").format(DateTime.now()) + "104500",
      version: 0
    ),
    Record(
      title: '初めてのGraphQL',
      kind: 'Reading',
      iconCodePoint: Icons.book.codePoint,
      iconFontFamily: Icons.book.fontFamily,
      fromDate: "20200430124500",
      toDate: "20200430151500",
      version: 0
    ),
  ];

  DateTime createDatetimeFromString(final String dateStr) {
    String formattedDateStr =  dateStr.substring(0, 8) + 'T' + dateStr.substring(8);
    return DateTime.parse(formattedDateStr);
  }

  String createFormattedDatetime(final DateTime datetime) {
    return DateFormat('a h:mm').format(datetime);
  }

  String createFormattedElaspedTime(final String fromDate, final String toDate) {
    int elaspedHour = int.parse(toDate.substring(8, 10)) - int.parse(fromDate.substring(8, 10));
    int elaspedMinute = int.parse(toDate.substring(10, 12)) - int.parse(fromDate.substring(10, 12));
    return (elaspedHour + (elaspedMinute / 60)).toStringAsPrecision(3) + "h";
  }

  Widget _buildRecordComponent(Record _record) {
    return ListTile(
      leading: Icon(
        IconData(
          _record.iconCodePoint,
          fontFamily: _record.iconFontFamily
        )
      ),
      title: Text(_record.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_record.kind),
          Text(createFormattedDatetime(createDatetimeFromString(_record.fromDate)) + " ~ " + createFormattedDatetime(createDatetimeFromString(_record.toDate))),
        ],
      ),
      trailing: Text(createFormattedElaspedTime(_record.fromDate,_record.toDate)),
    );
  }

  Widget _wrapCommonContainer(Widget _widget) => Container(
    padding: EdgeInsets.all(8.0),
    child: _widget,
  );

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      tooltip: 'Register',
      onPressed: () {
        print('Click Button for natigating Register Page...');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterRecordScreen(initialDate: DateFormat('yyyyMMdd', "ja_JP").format(widget.datetime))
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String _formatted = DateFormat('yyyy/MM/dd EEEE', "ja_JP").format(widget.datetime);

    return Scaffold(
      appBar: AppBar(
        title: Text(_formatted),
      ),
      drawer: Drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _wrapCommonContainer(_buildRecordComponent(_testDataList[0])),
            _wrapCommonContainer(_buildRecordComponent(_testDataList[1])),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context)
    );
  }
}