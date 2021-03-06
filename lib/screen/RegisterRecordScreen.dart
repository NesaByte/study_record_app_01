import 'package:flutter/material.dart';
import 'package:study_record_app_01/Constants.dart';
import 'package:study_record_app_01/component/SelectIconRadioFormField.dart';
import 'package:study_record_app_01/model/Record.dart';
import 'package:study_record_app_01/service/RecordService.dart';

import 'RecordListScreen.dart';

class RegisterRecordScreen extends StatefulWidget {
  RegisterRecordScreen({Key key, this.initialDate}) : super(key: key);

  static final navigateToRecordListScreenKey = Key('navigateToRecordListScreenKey');
  final String initialDate;

  @override
  _State createState() => _State();
}

class _State extends State<RegisterRecordScreen> {

  final _formKey = new GlobalKey<FormState>();
  final _choice = Constants.availableIcons.keys.toList();

  String _fromDate;
  String _fromTime;
  String _toDate;
  String _toTime;
  String _title;
  String _kind;
  IconData _iconData;

  @override
  void initState() {
    super.initState();
    _fromDate = widget.initialDate;
    _toDate = widget.initialDate;
  }

  void _navigateToRecordListScreen(final BuildContext context, final DateTime datetime) {
    final route = MaterialPageRoute(builder: (context) => RecordListScreen(datetime: datetime));
    Navigator.of(context).push(route);
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
          child: TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.number,
            autofocus: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(),
              ),
              hintText: 'YYYYMMDD'
            ),
            initialValue: _fromDate,
            validator: (value) => value.isEmpty ? 'Can\'t be empty' : null,
            onSaved: (value) => setState(() => _fromDate = value),
          )
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.number,
            autofocus: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(),
              ),
              hintText: 'HHmm'
            ),
            initialValue: _fromTime,
            validator: (value) => value.isEmpty ? 'Can\'t be empty' : null,
            onSaved: (value) => setState(() => _fromTime = value),
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
            child: TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.number,
              autofocus: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
                hintText: 'YYYYMMDD'
              ),
              initialValue: _toDate,
              validator: (value) => value.isEmpty ? 'Can\'t be empty' : null,
              onSaved: (value) => setState(() => _toDate = value),
            )
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.number,
            autofocus: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(),
              ),
              hintText: 'HHmm'
            ),
            initialValue: _toTime,
            validator: (value) => value.isEmpty ? 'Can\'t be empty' : null,
            onSaved: (value) => setState(() => _toTime = value),
          ),
        ),
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
          child: TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(),
              ),
              hintText: ''
            ),
            validator: (value) => value.isEmpty ? 'Can\'t be empty' : null,
            onSaved: (value) => setState(() => _title = value),
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
          child: TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(),
              ),
              hintText: ''
            ),
            validator: (value) => value.isEmpty ? 'Can\'t be empty' : null,
            onSaved: (value) => setState(() => _kind = value),
          ),
        )
      ],
    );
  }

  void _submitCreate() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    final int recentId = (await RecordService.selectAll()).length;
    final dto = Record(
      id: recentId + 1,
      title: _title,
      kind: _kind,
      iconCodePoint: _iconData.codePoint,
      iconFontFamily: _iconData.fontFamily,
      fromDate: _fromDate + _fromTime,
      toDate: _toDate + _toTime,
      version: 1
    );
    await RecordService.insert(dto)
      .then((value) => _navigateToRecordListScreen(context, DateTime.now()))
      .catchError((e) => print(e)
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      key: RegisterRecordScreen.navigateToRecordListScreenKey,
      child: Icon(Icons.navigate_next),
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: _submitCreate
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
        child: Container(
          padding: EdgeInsets.all(2.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _wrapCommonContainer(_buildFromDatetimeRow()),
                _wrapCommonContainer(_buildToDatetimeRow()),
                _wrapCommonContainer(_buildTitleRow()),
                _wrapCommonContainer(_buildKindRow()),
                _wrapCommonContainer(SelectIconRadioFormField(
                  choice: _choice,
                  initialValue: null,
                  onSaved: (value) => setState(() => _iconData = value),
                  validator: (value) => (value == null) ? 'Can\'t be empty' : null,
                )),
                Center(
                  child: _wrapCommonContainer(_buildSubmitButton())
                ),
              ]
            ),
          ),
        ),
      )
    );
  }
}

