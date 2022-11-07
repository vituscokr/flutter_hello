import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
//https://medium.com/@thecodingpapa/json-flutter-61815c214eb8

/// 이 부분은 자동으로 생성된 파일을 User class가 접근이 가능하도록 해준다.
/// 만약 User class 파일명이 "user.dart"이면 자동 생성되는 파일은 "user.g.dart"이다.
/// 즉, 생성되는 파일명 = 파일명(.dart 빼고) + g.dart
//part 'user.g.dart';

/// 이 annotation이 User class는 serialization코드를 생성해야된다는 표시를 해주는 것이다.
// @JsonSerializable()
// class User with ChangeNotifier {
//   User(this.name, this.email);
//
//   String name;
//   String email;
//
//   /// 자동으로 생성된 파일에 private function이 생성되는데
//   /// map으로 User object로 생성해주는 `_$UserFromJson()`이 생성된다.
//   /// function명 = _$ + class명 + FromJson
//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
//
//   /// User object에서 map으로 변경해주는 fuction도 비슷하게 생성된다.
//   /// function명 = _$ + class명 + ToJson
//   Map<String, dynamic> toJson() => _$UserToJson(this);
// }