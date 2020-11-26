// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Key _$KeyFromJson(Map<String, dynamic> json) {
  return Key(
    name: json['name'] as String,
    hash: json['hash'] as String,
    availability: json['availability'] as String,
    room: json['room'] == null
        ? null
        : Room.fromJson(json['room'] as Map<String, dynamic>),
    borrowing: json['borrowing'] == null
        ? null
        : Borrowing.fromJson(json['borrowing'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$KeyToJson(Key instance) => <String, dynamic>{
      'name': instance.name,
      'hash': instance.hash,
      'availability': instance.availability,
      'room': instance.room,
      'borrowing': instance.borrowing,
    };
