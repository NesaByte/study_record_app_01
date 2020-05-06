import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_record_app_01/model/Record.dart';
import 'package:study_record_app_01/screen/RegisterRecordScreen.dart';
import 'package:study_record_app_01/service/RecordService.dart';

class RecordListScreen extends StatefulWidget {
  RecordListScreen({Key key, this.datetime}) : super(key: key);

  final DateTime datetime;
  static final navigateToTodayRecordListScreenKey = Key('navigateToTodayRecordListScreenKey');
  static final navigateToRegisterRecordScreenKey = Key('navigateToRegisterRecordScreenKey');
  static final navigateToYesterdayRecordListScreenKey = Key('navigateToYesterdayRecordListScreenKey');
  static final navigateToTomorrowRecordListScreenKey = Key('navigateToTomorrowRecordListScreenKey');

  @override
  _State createState() => _State();
}

class _State extends State<RecordListScreen> {

  void _navigateToRecordListScreen(final BuildContext context, final DateTime datetime) {
    final route = MaterialPageRoute(builder: (context) => RecordListScreen(datetime: datetime));
    Navigator.of(context).push(route);
  }

  void _navigateToRegisterRecordScreen(final BuildContext context, final DateTime datetime) {
    final route = MaterialPageRoute(builder: (context) => RegisterRecordScreen(initialDate: DateFormat('yyyyMMdd', "ja_JP").format(datetime)));
    Navigator.of(context).push(route);
  }

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

  List<Widget> _buildRecordList(List<Record> list) {
    List<Widget> widgetList = [];
    list.forEach((dto) => widgetList.add(_wrapCommonContainer(_buildDismissibleRecordComponent(dto))));
    return widgetList;
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

  Widget _buildDismissibleRecordComponent(Record _record) {
    return Dismissible(
      background: Container(color: Colors.red, child: Icon(Icons.close)),
      secondaryBackground: Container(color: Colors.blue, child: Icon(Icons.edit)),
      key: Key("studyRecord.${_record.id}"),
      confirmDismiss: (direction) => _isDismiss(direction),
      /*
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          print("DELETE: No.${_record.id}");
        } else if (direction == DismissDirection.startToEnd) {
          print("EDIT: No.${_record.id}");
        }
      },
       */
      child: _buildRecordComponent(_record),
    );
  }

  Future<bool> _isDismiss(DismissDirection direction) async {
    if (direction == DismissDirection.startToEnd) {
      return false;
    } else {
      return false;
    }
  }

  Widget _wrapCommonContainer(Widget _widget) => Container(
    padding: EdgeInsets.all(8.0),
    child: _widget,
  );

  Widget _buildAppBar(final BuildContext context, final DateTime datetime) {
    return AppBar(
      title: Text(DateFormat('yyyy/MM/dd EEEE', "ja_JP").format(widget.datetime)),
      leading: RaisedButton(
        key: RecordListScreen.navigateToYesterdayRecordListScreenKey,
        child: Icon(Icons.arrow_left),
        color: Colors.grey,
        onPressed: () => _navigateToRecordListScreen(context, widget.datetime.add(Duration(days: -1))),
      ),
      actions: <Widget>[
        RaisedButton(
          key: RecordListScreen.navigateToTomorrowRecordListScreenKey,
          child: Icon(Icons.arrow_right),
          color: Colors.grey,
          onPressed: () => _navigateToRecordListScreen(context, widget.datetime.add(Duration(days: 1))),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context, widget.datetime),
      body: Center(
        child: FutureBuilder<List<Record>>(
          future: RecordService.selectFixedFromDateRecords(int.parse(DateFormat('yyyyMMdd', "ja_JP").format(widget.datetime))),
          builder: (context, future) {
            if (!future.hasData) {
              return CircularProgressIndicator();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _buildRecordList(future.data)
            );
          },
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context)
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          key: RecordListScreen.navigateToRegisterRecordScreenKey,
          heroTag: 'register',
          child: Icon(Icons.add),
          tooltip: 'Register',
          onPressed: () => _navigateToRegisterRecordScreen(context, widget.datetime),
        ),
        FloatingActionButton(
          key: RecordListScreen.navigateToTodayRecordListScreenKey,
          heroTag: 'home',
          child: Icon(Icons.home),
          tooltip: 'HOME',
          onPressed: () => _navigateToRecordListScreen(context, DateTime.now()),
        ),
      ],
    );
  }
}