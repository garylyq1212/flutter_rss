import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String password;

  const User({required this.name, required this.password});

  @override
  List<Object?> get props => [name, password];
}
