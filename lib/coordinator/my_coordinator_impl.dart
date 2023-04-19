import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_rss/coordinator/coordinator.dart';
import 'package:flutter_rss/router/router.gr.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: Coordinator)
class MyCoordinatorImpl extends Coordinator {
  @override
  void navigateToHomeScreen(BuildContext context) {
    context.router.push(const HomeRoute());
  }

  @override
  void navigateToLoginScreen(BuildContext context) {
    context.router.push(const LoginRoute());
  }
}
