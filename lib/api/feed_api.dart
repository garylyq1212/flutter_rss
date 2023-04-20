import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class FeedApi {
  Future fetchFeeds();
}

@Injectable(as: FeedApi)
class FeedApiImpl implements FeedApi {
  late Dio _dio;

  FeedApiImpl() {
    _dio = Dio();
  }

  @override
  Future fetchFeeds() async {
    final response = await _dio
        .get('https://rss.nytimes.com/services/xml/rss/nyt/World.xml');

    log('${response.data}');
  }
}
