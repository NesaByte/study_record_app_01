import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_record_app_01/model/Record.dart';

void main() {
  group("Record model test", () {
    Record record;
    Map<String, dynamic> json;

    setUp(() {
      record = Record(
        id: 10,
        title: 'Flutter',
        kind: 'Programming',
        iconCodePoint: Icons.computer.codePoint,
        iconFontFamily: Icons.computer.fontFamily,
        fromDate: "202004010900",
        toDate: "202004011045",
        version: 5
      );
      json = {
        "id": 10,
        "title": 'Flutter',
        "kind"  : 'Programming',
        "iconCodePoint": Icons.computer.codePoint,
        "iconFontFamily": Icons.computer.fontFamily,
        "fromDate": "202004010900",
        "toDate": "202004011045",
        "version": 5
      };
    });

    test("Record.fromJson", () async {
      expect(record.toJson(), json);
    });
    test("toJson", () async {
      expect(Record.fromJson(json).toJson(), record.toJson());
    });
  });
}