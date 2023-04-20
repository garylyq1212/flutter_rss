part of 'feed_bloc.dart';

@immutable
abstract class FeedState {}

class FeedInitial extends FeedState {}

class LoadingFeeds extends FeedState {}

class SuccessLoadFeeds extends FeedState {}
