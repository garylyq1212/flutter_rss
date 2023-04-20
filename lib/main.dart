import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rss/common/bloc_utils.dart';
import 'package:flutter_rss/injection/injection.dart';
import 'package:flutter_rss/router/router.dart';

void main() {
  configureDependencies();
  Bloc.observer = getIt<MyBlocObserver>();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter RSS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: getIt<AppRouter>().config(),
    );
  }
}
