import 'dart:convert';

import 'package:cae_app/model/borrowing.dart';
import 'package:cae_app/model/room.dart';
import 'package:json_annotation/json_annotation.dart';

part 'key_model.g.dart';

@JsonSerializable()
class KeyModel {
  String name;
  String hash;
  String availability;

  Room room;

  Borrowing borrowing;

  KeyModel({
    this.name,
    this.hash,
    this.availability,
    this.room,
    this.borrowing
  });

  factory KeyModel.fromJson(Map<String, dynamic> json) => _$KeyModelFromJson(json);

  Map<String, dynamic> toJson() => _$KeyModelToJson(this);

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
