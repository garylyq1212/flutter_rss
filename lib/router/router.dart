import 'package:auto_route/auto_route.dart';
import 'package:flutter_rss/router/router.gr.dart';
import 'package:injectable/injectable.dart';

@Singleton()
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
      ];
}
