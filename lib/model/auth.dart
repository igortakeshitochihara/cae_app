import 'dart:convert';

import 'package:cae_app/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth {
  String token;
  User user;

  Auth({
    this.token,
    this.user,
  });

  factory Auth.fromJson(Map<String, dynamic> json) =>
      _$AuthFromJson(json);

  Map<String, dynamic> toJson() => _$AuthToJson(this);

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
