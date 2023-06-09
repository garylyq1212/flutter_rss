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

  String name = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _feedBloc = BlocProvider.of<FeedBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.add(GetUser());
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
        title: Text(name.isEmpty ? 'Home' : 'Welcome $name'),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              _authBloc.add(Logout());
            },
            icon: const Icon(Icons.logout),
            label: const SizedBox.shrink(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _authBloc.add(GetUser());
          _feedBloc.add(GetFeeds(offset: 0, limit: 10, refresh: true));
        },
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is DoneLoadUser) {
              setState(() {
                name = state.user.name;
              });

              _feedBloc.add(GetFeeds(
                offset: offset,
                limit: limit,
                refresh: true,
              ));
            }

            if (state is FailedLoadUser || state is SucessLogoutUser) {
              getIt<Coordinator>().navigateToLoginScreen(context);
            }
          },
          builder: (context, state) {
            if (state is LoadingUser) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return BlocBuilder<FeedBloc, FeedState>(
              builder: (context, feedState) {
                if (feedState is LoadingFeeds && _feedBloc.myFeeds.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (feedState is FailedLoadFeeds) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Something went wrong!',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                backgroundColor: Colors.blueAccent,
                              ),
                              onPressed: () {
                                _feedBloc.add(
                                  GetFeeds(offset: 0, limit: 10, refresh: true),
                                );
                              },
                              child: const Text(
                                'Refresh',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
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
                      if (feedState is LoadingFeeds &&
                          _feedBloc.myFeeds.isNotEmpty)
                        const CircularProgressIndicator()
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
