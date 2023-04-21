import 'package:flutter/material.dart';
import 'package:flutter_rss/model/my_feed.dart';

abstract class Coordinator {
  void navigateToHomeScreen(BuildContext context);

  void navigateToLoginScreen(BuildContext context);

  void navigateToFeedDetailsScreen(BuildContext context, MyFeed myFeed);
}
