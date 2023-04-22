import 'package:dartz/dartz.dart';
import 'package:flutter_rss/injection/injection.dart';
import 'package:flutter_rss/model/user/user.dart';
import 'package:flutter_rss/repositories/user_repository/user_repository.dart';
import 'package:flutter_rss/service/hive_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  @override
  Future<Either<Exception, User>> getUser() async {
    final box = await getIt<HiveService>().openBox('user_box');

    if (box.isEmpty) {
      return Left(Exception('Empty Box'));
    }

    var user = box.get('user');

    if (user == null) {
      return Left(Exception('No User Box found'));
    }

    return Right(user);
  }
}
