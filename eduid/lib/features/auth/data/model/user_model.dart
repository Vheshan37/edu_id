import 'package:eduid/features/auth/domain/entity/user_role.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final UserRole role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: UserRole(role: json['role']['role']),
    );
  }
}
