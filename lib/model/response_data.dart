import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'response_data.g.dart';

@JsonSerializable()
class ResponseData {
  String message;
  int status;
  bool error;

  ResponseData(
      {this.message,
        this.status,
        this.error});

  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
