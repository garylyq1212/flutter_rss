import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rss/model/my_feed.dart';

@RoutePage()
class FeedDetailsScreen extends StatelessWidget {
  final MyFeed myFeed;

  const FeedDetailsScreen({Key? key, required this.myFeed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: myFeed.imageUrl.isNotEmpty
                ? myFeed.imageUrl
                : 'https://via.placeholder.com/400x200?text=IMAGE',
            fit: BoxFit.fitWidth,
            width: 400,
            height: 250,
            errorWidget: (context, url, error) => Image.asset(
              'assets/images/placeholder.png',
              width: 400,
              height: 250,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              myFeed.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              myFeed.description,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
