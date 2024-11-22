import 'package:blog_app/core/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.password});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        password: map['password'] ?? '');
  }
}
