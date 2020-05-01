import 'package:flutter/material.dart';
import 'package:study_record_app_01/model/Record.dart';
import 'package:study_record_app_01/repository/RecordRepository.dart';

class RegisterRecordScreen extends StatefulWidget {
  RegisterRecordScreen({Key key, this.initialDate}) : super(key: key);

  final String initialDate;

  @override
  _State createState() => _State();
}

class _State extends State<RegisterRecordScreen> {
  final _formKey = new GlobalKey<FormState>();
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
                // _wrapCommonContainer(_buildIconRow()),
                _wrapCommonContainer(RadioFormField(
                  choice: [Icons.computer, Icons.book, Icons.free_breakfast],
                  onSaved: (value) => setState(() => _iconData = value),
                )),
                Center(
                  child: RaisedButton(
                    child: Icon(Icons.navigate_next),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () async {
                      _formKey.currentState.save();
                      final int recentId = (await RecordRepository.selectAll()).length;
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
                      // print(model.toJson());
                      await RecordRepository.insert(dto);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ]
            ),
          ),
        ),
      )
    );
  }
}

class RadioFormField extends FormField<IconData> {
  RadioFormField(
    {FormFieldSetter<IconData> onSaved,
    FormFieldValidator<IconData> validator,
    IconData initialValue,
    bool autovalidate = false,
    List<IconData> choice,
    })
      : super(
        onSaved: onSaved,
        validator: validator,
        initialValue: initialValue,
        autovalidate: autovalidate,
        builder: (FormFieldState<IconData> state) {
          List<Widget> widgets = [];
          widgets.add(Expanded(flex: 1, child: Text('Icon')));
          choice.forEach((iconData) => widgets.add(Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                Icon(iconData),
                Radio(
                  value: iconData,
                  groupValue: state.value,
                  onChanged: (value) {
                    state.didChange(value);
                    // print(IconData(state.value.codePoint, fontFamily: state.value.fontFamily));
                  },
                )
              ],
            ),
          )));

          return Row(
            children: widgets,
          );
        }
      );
}
