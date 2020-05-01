import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_record_app_01/model/Record.dart';
import 'package:study_record_app_01/repository/RecordRepository.dart';
import 'package:study_record_app_01/screen/RegisterRecordScreen.dart';

class RecordListScreen extends StatefulWidget {
  RecordListScreen({Key key, this.datetime}) : super(key: key);

  final DateTime datetime;

  @override
  _State createState() => _State();
}

class _State extends State<RecordListScreen> {
  @override
  void initState() {
    testRepository(); // test
    super.initState();
  }

  // for test
  void testRepository() async {
    await RecordRepository.test();
    print(await RecordRepository.selectAll());
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
    list.forEach((dto) => widgetList.add(_wrapCommonContainer(_buildRecordComponent(dto))));
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

  Widget _wrapCommonContainer(Widget _widget) => Container(
    padding: EdgeInsets.all(8.0),
    child: _widget,
  );

  Widget _buildAppBar(final DateTime datetime) {
    return AppBar(
      title: Text(DateFormat('yyyy/MM/dd EEEE', "ja_JP").format(widget.datetime)),
    );
  }

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
    return Scaffold(
      appBar: _buildAppBar(widget.datetime),
      drawer: Drawer(),
      body: Center(
        child: FutureBuilder<List<Record>>(
          future: RecordRepository.selectAll(),
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
}