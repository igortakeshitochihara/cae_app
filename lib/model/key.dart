import 'dart:convert';

import 'package:cae_app/model/borrowing.dart';
import 'package:cae_app/model/room.dart';
import 'package:json_annotation/json_annotation.dart';

part 'key.g.dart';

@JsonSerializable()
class Key {
  String name;
  String hash;
  String availability;

  Room room;

  Borrowing borrowing;

  Key({
    this.name,
    this.hash,
    this.availability,
    this.room,
    this.borrowing
  });

  factory Key.fromJson(Map<String, dynamic> json) => _$KeyFromJson(json);

  Map<String, dynamic> toJson() => _$KeyToJson(this);

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
