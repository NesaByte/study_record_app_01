import 'package:flutter/material.dart';

class RegisterRecordScreen extends StatefulWidget {
  RegisterRecordScreen({Key key, this.initialDate}) : super(key: key);

  final String initialDate;

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
  void initState() {
    super.initState();
    _fromDateController.text= widget.initialDate;
    _toDateController.text = widget.initialDate;
  }

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

  Widget _buildFromDatetimeRow() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text('From'),
        ),
        Expanded(
          flex: 3,
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
          flex: 3,
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
        ),
      ],
    );
  }

  Widget _buildToDatetimeRow() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text('To'),
        ),
        Expanded(
          flex: 3,
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
          flex: 3,
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
    );
  }

  Widget _buildTitleRow() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text('Title'),
        ),
        Expanded(
          flex: 6,
          child: TextField(
            controller: _titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(),
              ),
              hintText: ''
            ),
          ),
        )
      ],
    );
  }

  Widget _buildKindRow() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text('Kind'),
        ),
        Expanded(
          flex: 6,
          child: TextField(
            controller: _kindController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(),
              ),
              hintText: ''
            ),
          ),
        )
      ],
    );
  }

  Widget _buildIconRow() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text('Icon'),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: <Widget>[
              Icon(Icons.computer),
              Radio(
                value: '',
                groupValue: null,
                onChanged: null,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: <Widget>[
              Icon(Icons.book),
              Radio(
                value: '',
                groupValue: null,
                onChanged: null,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: <Widget>[
              Icon(Icons.free_breakfast),
              Radio(
                value: '',
                groupValue: null,
                onChanged: null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _wrapCommonContainer(Widget _widget) => Container(
    padding: EdgeInsets.all(8.0),
    child: _widget,
  );

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
                  _wrapCommonContainer(_buildFromDatetimeRow()),
                  _wrapCommonContainer(_buildToDatetimeRow()),
                  _wrapCommonContainer(_buildTitleRow()),
                  _wrapCommonContainer(_buildKindRow()),
                  _wrapCommonContainer(_buildIconRow()),
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
