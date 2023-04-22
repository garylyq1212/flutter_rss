import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_rss/coordinator/coordinator.dart';
import 'package:flutter_rss/model/my_feed.dart';
import 'package:flutter_rss/router/router.gr.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: Coordinator)
class MyCoordinatorImpl implements Coordinator {
  @override
  void navigateToHomeScreen(BuildContext context) {
    context.router.push(const HomeRoute());
  }

  @override
  void navigateToLoginScreen(BuildContext context) {
    context.router.replace(const LoginRoute());
  }

  @override
  void navigateToFeedDetailsScreen(BuildContext context, MyFeed myFeed) {
    context.router.push(FeedDetailsRoute(myFeed: myFeed));
  }
}
