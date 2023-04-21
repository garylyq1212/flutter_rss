import 'package:flutter/material.dart';
import 'package:flutter_rss/model/my_feed.dart';

class FeedItem extends StatelessWidget {
  final MyFeed myFeed;

  const FeedItem({Key? key, required this.myFeed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 16.0,
      ),
      child: SizedBox(
        width: 400,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: Image.network(
                  myFeed.imageUrl.isNotEmpty
                      ? myFeed.imageUrl
                      : 'https://via.placeholder.com/160?text=IMAGE',
                  fit: BoxFit.fitHeight,
                  height: 160,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 16,
                    right: 16,
                  ),
                  child: Column(
                    children: [
                      Text(
                        myFeed.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        myFeed.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
