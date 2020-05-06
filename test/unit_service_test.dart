import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_record_app_01/model/Record.dart';
import 'package:study_record_app_01/service/RecordService.dart';

main() {
  group("RecordService unit test", () {
    Record dummyRecord;

    setUp(() {
      dummyRecord = Record(
        id: 0,
        title: 'Flutter',
        kind: 'Programming',
        iconCodePoint: Icons.computer.codePoint,
        iconFontFamily: Icons.computer.fontFamily,
        fromDate: "000000000000",
        toDate: "000000000000",
        version: 0
      );
    });

    test("isIncludeSpecifiedDate", () async {
      final int basisDate = 20020615;
      final Record recordOne = Record.fromJson(dummyRecord.toJson());
      recordOne.fromDate = "200206140000"; // 6/14
      recordOne.fromDate = "200206142359"; // 6/14
      final Record recordTwo = Record.fromJson(dummyRecord.toJson());
      recordTwo.fromDate = "200206150000"; // 6/15
      recordTwo.fromDate = "200206152359"; // 6/15
      final Record recordThree = Record.fromJson(dummyRecord.toJson());
      recordThree.fromDate = "200206160000"; // 6/16
      recordThree.fromDate = "200206162359"; // 6/16
      expect(false, RecordService.isIncludeSpecifiedDate(basisDate, recordOne));
      expect(true, RecordService.isIncludeSpecifiedDate(basisDate, recordTwo));
      expect(false, RecordService.isIncludeSpecifiedDate(basisDate, recordThree));
    });

    test("validate", () async {
      Record record;
      record = Record.fromJson(dummyRecord.toJson());
      expect(true, RecordService.validate(record));

      record = Record.fromJson(dummyRecord.toJson());
      record.title = null;
      expect(false, RecordService.validate(record));

      record = Record.fromJson(dummyRecord.toJson());
      record.kind = null;
      expect(false, RecordService.validate(record));

      record = Record.fromJson(dummyRecord.toJson());
      record.iconCodePoint = null;
      expect(false, RecordService.validate(record));

      record = Record.fromJson(dummyRecord.toJson());
      record.iconFontFamily = null;
      expect(false, RecordService.validate(record));

      record = Record.fromJson(dummyRecord.toJson());
      record.fromDate = "1";
      expect(false, RecordService.validate(record));
      record.fromDate = "abcdefghijkl";
      expect(false, RecordService.validate(record));

      record = Record.fromJson(dummyRecord.toJson());
      record.toDate = "1";
      expect(false, RecordService.validate(record));
      record.toDate = "abcdefghijkl";
      expect(false, RecordService.validate(record));
    });
  });
}