import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  String name;
  String hash;

  Room({
    this.name,
    this.hash,
  });

  factory Room.fromJson(Map<String, dynamic> json) =>
      _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}