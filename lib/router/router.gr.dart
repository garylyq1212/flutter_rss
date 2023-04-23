// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:flutter_rss/model/my_feed.dart' as _i6;
import 'package:flutter_rss/presentation/screens/feed_details/feed_details_screen.dart'
    as _i1;
import 'package:flutter_rss/presentation/screens/home/home_screen.dart' as _i2;
import 'package:flutter_rss/presentation/screens/login/login_screen.dart'
    as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    FeedDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<FeedDetailsRouteArgs>();
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.FeedDetailsScreen(
          key: args.key,
          myFeed: args.myFeed,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.WrappedRoute(child: const _i2.HomeScreen()),
      );
    },
    LoginRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.WrappedRoute(child: const _i3.LoginScreen()),
      );
    },
  };
}

/// generated route for
/// [_i1.FeedDetailsScreen]
class FeedDetailsRoute extends _i4.PageRouteInfo<FeedDetailsRouteArgs> {
  FeedDetailsRoute({
    _i5.Key? key,
    required _i6.MyFeed myFeed,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          FeedDetailsRoute.name,
          args: FeedDetailsRouteArgs(
            key: key,
            myFeed: myFeed,
          ),
          initialChildren: children,
        );

  static const String name = 'FeedDetailsRoute';

  static const _i4.PageInfo<FeedDetailsRouteArgs> page =
      _i4.PageInfo<FeedDetailsRouteArgs>(name);
}

class FeedDetailsRouteArgs {
  const FeedDetailsRouteArgs({
    this.key,
    required this.myFeed,
  });

  final _i5.Key? key;

  final _i6.MyFeed myFeed;

  @override
  String toString() {
    return 'FeedDetailsRouteArgs{key: $key, myFeed: $myFeed}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute({List<_i4.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
