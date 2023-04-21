import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rss/coordinator/coordinator.dart';
import 'package:flutter_rss/injection/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rss/model/my_feed.dart';
import 'package:flutter_rss/presentation/bloc/feed/feed_bloc.dart';
import 'package:flutter_rss/presentation/screens/home/widgets/feed_item.dart';

@RoutePage()
class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedBloc>(
          create: (_) => getIt<FeedBloc>(),
        ),
      ],
      child: this,
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late FeedBloc _feedBloc;

  @override
  void initState() {
    super.initState();
    _feedBloc = BlocProvider.of<FeedBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            if (state is LoadingFeeds) {
              return const Text('Loading');
            }

            return Column(
              children: <Widget>[
                if (_feedBloc.myFeeds.isEmpty)
                  const SizedBox.shrink()
                else
                  FeedItem(myFeed: _feedBloc.myFeeds.first),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _feedBloc.add(GetFeeds());
                  },
                  child: const Text('Fetch Feeds'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    getIt<Coordinator>().navigateToLoginScreen(context);
                  },
                  child: const Text('Navigate'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
