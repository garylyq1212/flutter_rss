part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoadingUser extends AuthState {}

class DoneLoadUser extends AuthState {
  final User user;

  const DoneLoadUser({required this.user});

  @override
  List<Object> get props => [user];
}

class FailedLoadUser extends AuthState {
  final String message;

  const FailedLoadUser({required this.message});

  @override
  List<Object> get props => [message];
}
