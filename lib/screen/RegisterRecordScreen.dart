import 'package:flutter/material.dart';

class RegisterRecordScreen extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<RegisterRecordScreen> {
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
                        // TODO: confirm & register
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
