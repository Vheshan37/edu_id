part of 'auth_bloc.dart';

abstract class AuthEvent {}

class RequestLogin extends AuthEvent {
  final String email;
  final String password;
  final bool isTeacher;

  RequestLogin({
    required this.email,
    required this.password,
    required this.isTeacher,
  });
}
