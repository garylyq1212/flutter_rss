import 'package:dartz/dartz.dart';
import 'package:flutter_rss/injection/injection.dart';
import 'package:flutter_rss/model/user/user.dart';
import 'package:flutter_rss/repositories/user_repository/user_repository.dart';
import 'package:flutter_rss/service/hive_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  bool _initializedHiveAdapter = false;

  @override
  Future<Either<Exception, User>> getUser() async {
    try {
      if (!_initializedHiveAdapter) {
        getIt<HiveService>().registerAdapter(UserAdapter());
        _initializedHiveAdapter = true;
      }

      final box = await getIt<HiveService>().openBox('user_box');

      final user = box.get('user');

      if (user == null) {
        return Left(Exception('No User found'));
      }

      // Simulating api request
      await Future.delayed(const Duration(milliseconds: 1000));

      return Right(user);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, User>> login(String name, String password) async {
    try {
      if (!_initializedHiveAdapter) {
        getIt<HiveService>().registerAdapter(UserAdapter());
        _initializedHiveAdapter = true;
      }

      final box = await getIt<HiveService>().openBox('user_box');

      final user = User(name: name, password: password);

      box.put('user', user);

      // Simulating api request
      await Future.delayed(const Duration(milliseconds: 1000));

      return Right(user);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, bool>> logout() async {
    try {
      final box = await getIt<HiveService>().openBox('user_box');

      if (!_initializedHiveAdapter) {
        getIt<HiveService>().registerAdapter(UserAdapter());
      }

      await box.delete('user');

      // Simulating api request
      await Future.delayed(const Duration(milliseconds: 1000));

      return const Right(true);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
