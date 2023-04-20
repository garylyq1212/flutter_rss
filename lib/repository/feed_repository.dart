import 'package:dartz/dartz.dart';
import 'package:flutter_rss/model/my_feed.dart';

abstract class FeedRepository {
  Future<Either<Exception, List<MyFeed>>> fetchFeeds();
}
