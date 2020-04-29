import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_record_app_01/screen/RegisterRecordScreen.dart';

class RecordListScreen extends StatefulWidget {
  RecordListScreen({Key key, this.datetime}) : super(key: key);

  final DateTime datetime;

  @override
  _State createState() => _State();
}

class _State extends State<RecordListScreen> {
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
                leading: Icon(Icons.book),
                title: Text('Ruby on Rails'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Programming'),
                    Text('AM10:00 ~ AM11:00'),
                  ],
                ),
                trailing: Text('1h'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              child: ListTile(
                leading: Icon(Icons.book),
                title: Text('初めてのGraphQL'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Reading'),
                    Text('AM 11:00 ~ PM 1:00'),
                  ],
                ),
                trailing: Text('2h'),
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