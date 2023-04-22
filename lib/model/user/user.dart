import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String password;

  const User({required this.name, required this.password});

  @override
  List<Object?> get props => [];
}
