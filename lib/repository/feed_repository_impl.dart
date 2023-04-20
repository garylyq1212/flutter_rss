import 'package:flutter_rss/api/feed_api.dart';
import 'package:flutter_rss/repository/feed_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  final FeedApi _feedApi;

  FeedRepositoryImpl(this._feedApi);

  @override
  void fetchFeeds() async {
    await _feedApi.fetchFeeds();
  }
}
