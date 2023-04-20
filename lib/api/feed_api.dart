import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_rss/common/exception.dart';
import 'package:flutter_rss/model/my_feed.dart';
import 'package:webfeed/webfeed.dart';
import 'package:injectable/injectable.dart';

abstract class FeedApi {
  Future<List<RssItem>> fetchFeeds();
}

@Injectable(as: FeedApi)
class FeedApiImpl implements FeedApi {
  late Dio _dio;

  FeedApiImpl() {
    _dio = Dio();
  }

  @override
  Future<List<RssItem>> fetchFeeds() async {
    final response = await _dio
        .get('https://rss.nytimes.com/services/xml/rss/nyt/World.xml');

    final rssFeed = RssFeed.parse(response.data);

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return rssFeed.items ?? [];
  }
}
