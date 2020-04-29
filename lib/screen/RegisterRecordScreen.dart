import 'package:flutter/material.dart';

class RegisterRecordScreen extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<RegisterRecordScreen> {
  final _fromDateController = TextEditingController();
  final _fromTimeController = TextEditingController();
  final _toDateController = TextEditingController();
  final _toTimeController = TextEditingController();
  final _titleController = TextEditingController();
  final _kindController = TextEditingController();

  @override
  void dispose() {
    _fromDateController.dispose();
    _fromTimeController.dispose();
    _toDateController.dispose();
    _toTimeController.dispose();
    _titleController.dispose();
    _kindController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('予定追加'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('From'),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _fromDateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: 'YYYYMMDD'
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _fromTimeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: 'hh24mi'
                          ),
                        ),
                      )
                    ],
                  ),
                  Text('To'),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _toDateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: 'YYYYMMDD'
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _toTimeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: 'hh24mi'
                          ),
                        ),
                      )
                    ],
                  ),
                  Text('Title'),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(),
                      ),
                      hintText: ''
                    ),
                  ),
                  Text('Kind'),
                  TextField(
                    controller: _kindController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(),
                      ),
                      hintText: ''
                    ),
                  ),
                  Text('Icon'),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.thumb_up),
                            Radio(
                              value: '',
                              groupValue: null,
                              onChanged: null,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.thumb_up),
                            Radio(
                              value: '',
                              groupValue: null,
                              onChanged: null,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.thumb_up),
                            Radio(
                              value: '',
                              groupValue: null,
                              onChanged: null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: RaisedButton(
                      child: Icon(Icons.navigate_next),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                        print(
                          "from date :" + _fromDateController.text
                          + "/ from time : " + _fromTimeController.text
                          + "/ to date : " + _toDateController.text
                          + "/ to time : " + _toTimeController.text
                          + "/ title : " + _titleController.text
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
