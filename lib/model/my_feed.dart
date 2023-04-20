import 'package:equatable/equatable.dart';
import 'package:webfeed/webfeed.dart';

class MyFeed extends Equatable {
  final String title;
  final String description;
  final String imageUrl;

  const MyFeed({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory MyFeed.fromRssItem(RssItem rssItem) {
    String imgUrl = '';

    if (rssItem.media != null &&
        rssItem.media!.contents != null &&
        rssItem.media!.contents!.isNotEmpty &&
        rssItem.media!.contents!.first.url != null) {
      imgUrl = rssItem.media!.contents!.first.url!;
    }

    return MyFeed(
      title: rssItem.title ?? '',
      description: rssItem.description ?? '',
      imageUrl: imgUrl,
    );
  }

  @override
  List<Object?> get props => [title, description, imageUrl];
}
