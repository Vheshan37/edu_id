part of 'auth_bloc.dart';

abstract class AuthEvent {}

class RequestLogin extends AuthEvent {
  final String email;
  final String password;

  RequestLogin({required this.email, required this.password});
}
