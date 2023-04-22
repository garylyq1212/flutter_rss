import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rss/coordinator/coordinator.dart';
import 'package:flutter_rss/injection/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rss/presentation/bloc/auth/auth_bloc.dart';

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
        BlocProvider(
          create: (_) => getIt<AuthBloc>(),
        ),
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
  late AuthBloc _authBloc;

  int offset = 0;
  int limit = 10;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _feedBloc = BlocProvider.of<FeedBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.add(GetUser());
    _feedBloc.add(GetFeeds(offset: offset, limit: limit, refresh: true));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _feedBloc.add(GetFeeds(offset: offset + limit));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _feedBloc.add(GetFeeds(offset: 0, limit: 10, refresh: true));
        },
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            log('STATE: $state');

            if (state is FailedLoadUser) {
              getIt<Coordinator>().navigateToLoginScreen(context);
            }
          },
          child: BlocBuilder<FeedBloc, FeedState>(
            builder: (context, state) {
              if (state is LoadingFeeds && _feedBloc.myFeeds.isEmpty) {
                return const Text('Loading');
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _feedBloc.myFeeds.length,
                        itemBuilder: (context, index) {
                          return FeedItem(
                            myFeed: _feedBloc.myFeeds[index],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (state is LoadingFeeds && _feedBloc.myFeeds.isNotEmpty)
                      const CircularProgressIndicator()
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
