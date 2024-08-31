import 'dart:convert';

import 'package:dkejvh/domain/auth/entities/user.dart';

class UserModel {
  final String username;
  final String birthDate;

  UserModel({
    required this.username,
    required this.birthDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'birthDate': birthDate,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      birthDate: map['birthDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      username: username,
      birthDate: birthDate,
    );
  }
}
