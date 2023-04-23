import 'package:dartz/dartz.dart';
import 'package:flutter_rss/api/feed_api.dart';
import 'package:flutter_rss/common/exception.dart';
import 'package:flutter_rss/model/my_feed.dart';
import 'package:flutter_rss/repositories/feed_repository/feed_repository.dart';
import 'package:flutter_rss/service/network_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  final FeedApi _feedApi;
  final NetworkService _networkService;

  FeedRepositoryImpl(this._feedApi, this._networkService);

  @override
  Future<Either<Exception, List<MyFeed>>> fetchFeeds() async {
    try {
      if (await _networkService.isConnected()) {
        final rssItems = await _feedApi.fetchFeeds();
        final List<MyFeed> myFeeds =
            rssItems.map((item) => MyFeed.fromRssItem(item)).toList();

        return Right(myFeeds);
      }
    } on NoInternetConnectionException catch (e) {
      return Left(e);
    } on ServerException {
      //
    } on Exception catch (e) {
      return Left(e);
    }

    return Left(Exception('Something Wrong'));
  }
}
