part of 'feed_bloc.dart';

@immutable
abstract class FeedState {}

class FeedInitial extends FeedState {}

class LoadingFeeds extends FeedState {}

class SuccessLoadFeeds extends FeedState {}

class FailedLoadFeeds extends FeedState {
  final Exception exception;

  FailedLoadFeeds({required this.exception});

  @override
  String toString() {
    return 'FailedLoadFeeds: $exception';
  }
}
