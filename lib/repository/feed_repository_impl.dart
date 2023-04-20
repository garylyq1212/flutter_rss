import 'package:dartz/dartz.dart';
import 'package:flutter_rss/api/feed_api.dart';
import 'package:flutter_rss/model/my_feed.dart';
import 'package:flutter_rss/repository/feed_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  final FeedApi _feedApi;

  FeedRepositoryImpl(this._feedApi);

  @override
  Future<Either<Exception, List<MyFeed>>> fetchFeeds() async {
    try {
      final rssItems = await _feedApi.fetchFeeds();
      final List<MyFeed> myFeeds =
          rssItems.map((item) => MyFeed.fromRssItem(item)).toList();

      return Right(myFeeds);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
