import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rss/common/bloc_utils.dart';
import 'package:flutter_rss/injection/injection.dart';
import 'package:flutter_rss/router/router.dart';
import 'package:flutter_rss/service/hive_service.dart';

void main() async {
  configureDependencies();
  await getIt<HiveService>().init();
  Bloc.observer = getIt<MyBlocObserver>();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter RSS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: getIt<AppRouter>().config(),
    );
  }
}
