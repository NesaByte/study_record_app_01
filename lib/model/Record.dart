// To parse this JSON data, do
//
//     final record = recordFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Record recordFromJson(String str) => Record.fromJson(json.decode(str));

String recordToJson(Record data) => json.encode(data.toJson());

class Record {
  static final String primaryKeyName = "id";

  int id;
  String title;
  String kind;
  int iconCodePoint;
  String iconFontFamily;
  String fromDate;
  String toDate;
  int version;

  Record({
    @required this.id,
    @required this.title,
    @required this.kind,
    @required this.iconCodePoint,
    @required this.iconFontFamily,
    @required this.fromDate,
    @required this.toDate,
    @required this.version,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    title: json["title"],
    kind: json["kind"],
    iconCodePoint: json["iconCodePoint"],
    iconFontFamily: json["iconFontFamily"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    version: json["version"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "kind": kind,
    "iconCodePoint": iconCodePoint,
    "iconFontFamily": iconFontFamily,
    "fromDate": fromDate,
    "toDate": toDate,
    "version": version,
  };
}
