import 'package:flutter/material.dart';

class SelectIconRadioFormField extends FormField<IconData> {
  SelectIconRadioFormField(
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
        widgets.add(
          Expanded(
            flex: 1,
            child: Text(
              'Icon',
              style: TextStyle(
                fontSize: 12.0
              ),
            )
          )
        );
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
                },
              )
            ],
          ),
        )));

        if (state.hasError) {
          return Column(
            children: <Widget>[
              Row(children: widgets),
              Text(
                state.errorText,
                style: TextStyle(
                  color: Colors.red[700]
                ),
              ),
            ],
          );
        } else {
          return Row(children: widgets);
        }
      }
  );
}