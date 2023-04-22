import 'package:dartz/dartz.dart';
import 'package:flutter_rss/model/user/user.dart';

abstract class UserRepository {
  Future<Either<Exception, User>> getUser();
}
