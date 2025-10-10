part of 'logout_bloc.dart';

abstract class LogoutState{}

class LogoutInitial extends LogoutState{}

class LogoutLoading extends LogoutState{}

class LogoutSuccess extends LogoutState{}

class LogoutFailed extends LogoutState{
  final String messsage;
  LogoutFailed({required this.messsage});
}