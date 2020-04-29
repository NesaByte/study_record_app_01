import 'dart:convert';

Record recordFromJson(String str) => Record.fromJson(json.decode(str));

String recordToJson(Record data) => json.encode(data.toJson());

class Record {
  String title;
  String kind;
  String fromDate;
  String toDate;
  int version;

  Record({
    this.title,
    this.kind,
    this.fromDate,
    this.toDate,
    this.version,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    title: json["title"],
    kind: json["kind"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    version: json["version"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "kind": kind,
    "fromDate": fromDate,
    "toDate": toDate,
    "version": version,
  };
}
