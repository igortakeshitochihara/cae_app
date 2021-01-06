// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrowing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Borrowing _$BorrowingFromJson(Map<String, dynamic> json) {
  return Borrowing(
    hash: json['hash'] as String,
    status: json['status'] as String,
    borrowingTime: json['borrowing_time'] == null
        ? null
        : DateTime.parse(json['borrowing_time'] as String),
    returnTime: json['return_time'] == null
        ? null
        : DateTime.parse(json['return_time'] as String),
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BorrowingToJson(Borrowing instance) => <String, dynamic>{
      'hash': instance.hash,
      'status': instance.status,
      'borrowing_time': instance.borrowingTime?.toIso8601String(),
      'return_time': instance.returnTime?.toIso8601String(),
      'user': instance.user,
    };
