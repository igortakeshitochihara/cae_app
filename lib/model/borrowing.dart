import 'dart:convert';

import 'package:cae_app/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'borrowing.g.dart';

@JsonSerializable()
class Borrowing {
  @JsonKey(name: 'borrowing_time')
  DateTime borrowingTime;
  @JsonKey(name: 'return_time')
  DateTime returnTime;

  User user;

  Borrowing({
    this.borrowingTime,
    this.user,
  });

  factory Borrowing.fromJson(Map<String, dynamic> json) =>
      _$BorrowingFromJson(json);

  Map<String, dynamic> toJson() => _$BorrowingToJson(this);

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}