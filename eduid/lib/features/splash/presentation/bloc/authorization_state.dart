part of 'authorization_bloc.dart';

abstract class AuthorizationState {}

class AuthorizationInitial extends AuthorizationState {}

class AuthorizationLoading extends AuthorizationState {}

class Authorized extends AuthorizationState {}

class UnAuthorized extends AuthorizationState {}
