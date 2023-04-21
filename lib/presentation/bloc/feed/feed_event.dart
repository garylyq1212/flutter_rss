part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent {}

class GetFeeds extends FeedEvent {
  final int offset;
  final int limit;
  final bool refresh;

  GetFeeds({required this.offset, this.limit = 10, this.refresh = false});

  @override
  String toString() => 'GetFeeds(offset: $offset)';
}
