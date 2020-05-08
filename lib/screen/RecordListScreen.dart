import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_record_app_01/model/Record.dart';
import 'package:study_record_app_01/screen/CalendarScreen.dart';
import 'package:study_record_app_01/screen/RegisterRecordScreen.dart';
import 'package:study_record_app_01/screen/UpdateRecordScreen.dart';
import 'package:study_record_app_01/service/RecordService.dart';

class RecordListScreen extends StatefulWidget {
  RecordListScreen({Key key, this.datetime}) : super(key: key);

  final DateTime datetime;
  static final navigateToTodayRecordListScreenKey = Key('navigateToTodayRecordListScreenKey');
  static final navigateToRegisterRecordScreenKey = Key('navigateToRegisterRecordScreenKey');
  static final navigateToCalendarScreenKey = Key('navigateToCalendarScreenKey');
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

  void _navigateToCalendarScreen(final BuildContext context) {
    final route = MaterialPageRoute(builder: (context) => CalendarScreen());
    Navigator.of(context).push(route);
  }

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

  Widget _buildFloatingActionButton(final BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          key: RecordListScreen.navigateToRegisterRecordScreenKey,
          heroTag: 'register',
          tooltip: 'Register',
          child: Icon(Icons.add),
          onPressed: () => _navigateToRegisterRecordScreen(context, widget.datetime),
        ),
        FloatingActionButton(
          key: RecordListScreen.navigateToCalendarScreenKey,
          heroTag: 'calendar',
          tooltip: 'Calendar',
          child: Icon(Icons.calendar_today),
          onPressed: () => _navigateToCalendarScreen(context),
        ),
        FloatingActionButton(
          key: RecordListScreen.navigateToTodayRecordListScreenKey,
          heroTag: 'home',
          tooltip: 'HOME',
          child: Icon(Icons.home),
          onPressed: () => _navigateToRecordListScreen(context, DateTime.now()),
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
            return _RecordList(recordList: future.data);
          },
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context)
    );
  }
}

class _RecordList extends StatefulWidget {
  _RecordList({Key key, this.recordList}) : super(key: key);

  final List<Record> recordList;

  @override
  _RecordListState createState() => _RecordListState();
}

class _RecordListState extends State<_RecordList> {
  List<Record> _recordList;

  @override
  void initState() {
    super.initState();
    _recordList = widget.recordList;
  }

  void _navigateToUpdateRecordScreen(final BuildContext context, final Record _record) {
    final route = MaterialPageRoute(builder: (context) => UpdateRecordScreen(baseRecord: _record));
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

  Widget _buildRecordComponent(final Record _record) {
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

  Future<bool> _isDelete(final BuildContext context, final Record _record) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Are you sure you want to delete?",
          style: TextStyle(color: Colors.red),
        ),
        content: ListTile(
          title: Text(_record.title),
          subtitle: Text(_record.kind),
        ),
        actions: <Widget>[
          RaisedButton.icon(
            onPressed: () => Navigator.of(context).pop(true),
            icon: Icon(Icons.delete),
            label: Text("OK"),
            color: Colors.red,
          ),
          RaisedButton.icon(
            onPressed: () => Navigator.of(context).pop(false),
            icon: Icon(Icons.close),
            label: Text("Cancel"),
          ),
        ],
      ),
    ) ??
    false;
  }

  Future<bool> _isDismiss(final BuildContext context, final DismissDirection direction, final Record _record) async {
    if (direction == DismissDirection.startToEnd) {
      _navigateToUpdateRecordScreen(context, _record);
      return false;
    } else {
      return _isDelete(context, _record);
    }
  }

  Widget _buildDismissibleRecordComponent(final int index, final Record _record, final Widget child) {
    return Dismissible(
      background: Container(color: Colors.blue, child: Icon(Icons.edit)),
      secondaryBackground: Container(color: Colors.red, child: Icon(Icons.close)),
      key: Key("studyRecord.${_record.id}"),
      confirmDismiss: (direction) => _isDismiss(context, direction, _record),
      onDismissed: (direction) {
        RecordService.delete(_record.id);
        setState(() {
          _recordList.removeAt(index);
        });
      },
      child: child,
    );
  }

  Widget _wrapCommonContainer(final Widget _widget) => Container(
    padding: EdgeInsets.all(8.0),
    child: _widget,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _recordList.length,
      itemBuilder: (BuildContext context, int index) {
        Record _record = _recordList[index];
        return _buildDismissibleRecordComponent(
          index,
          _record,
          _wrapCommonContainer(_buildRecordComponent(_record))
        );
      }
    );
  }
}