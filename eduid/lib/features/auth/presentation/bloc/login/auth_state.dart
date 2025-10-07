part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel userModel;
  AuthAuthenticated({required this.userModel});
}

class UnAuthenticated extends AuthState {
  final String message;
  UnAuthenticated({required this.message});
}
