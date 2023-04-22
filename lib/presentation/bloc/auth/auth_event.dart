part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class GetUser extends AuthEvent {}

class LoginUser extends AuthEvent {
  final String name;
  final String password;

  const LoginUser({required this.name, required this.password});

  @override
  List<Object> get props => [name, password];
}

class Logout extends AuthEvent {}
