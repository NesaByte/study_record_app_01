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
  final _list = [
    Record(
      title: 'Ruby on Rails',
      kind: 'Programming',
      iconCodePoint: Icons.computer.codePoint,
      iconFontFamily: Icons.computer.fontFamily,
      fromDate: DateFormat('yyyyMMddHH24MI', "en_US").format(DateTime.now()),
      toDate: DateFormat('yyyyMMddHH24MI', "en_US").format(DateTime.now()),
      version: 0
    ),
    Record(
      title: '初めてのGraphQL',
      kind: 'Reading',
      iconCodePoint: Icons.book.codePoint,
      iconFontFamily: Icons.book.fontFamily,
      fromDate: DateFormat('yyyyMMddHH24MI', "en_US").format(DateTime.now()),
      toDate: DateFormat('yyyyMMddHH24MI', "en_US").format(DateTime.now()),
      version: 0
    ),
  ];

  String createFormattedDatetime(final DateTime datetime) {
    return DateFormat('a h:mm').format(datetime);
  }

  @override
  Widget build(BuildContext context) {
    String _formatted = DateFormat('yyyy/MM/dd EEEE', "en_US").format(widget.datetime);

    return Scaffold(
      appBar: AppBar(
        title: Text(_formatted),
      ),
      drawer: Drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  IconData(
                    _list[0].iconCodePoint,
                    fontFamily: _list[0].iconFontFamily
                  )
                ),
                title: Text(_list[0].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_list[0].kind),
                    Text('TODO'),
                  ],
                ),
                trailing: Text('TODO'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              child: ListTile(
                leading: Icon(
                  IconData(
                    _list[1].iconCodePoint,
                    fontFamily: _list[0].iconFontFamily
                  )
                ),
                title: Text(_list[1].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_list[1].kind),
                    Text('TODO'),
                  ],
                ),
                trailing: Text('TODO'),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Register',
        onPressed: () {
          print('Click Button for natigating Register Page...');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterRecordScreen()
            )
          );
        },
      ),
    );
  }
}