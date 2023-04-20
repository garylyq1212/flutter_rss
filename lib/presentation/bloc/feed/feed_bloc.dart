import 'package:bloc/bloc.dart';
import 'package:flutter_rss/model/my_feed.dart';
import 'package:flutter_rss/repository/feed_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'feed_event.dart';
part 'feed_state.dart';

@Injectable()
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository _feedRepository;

  late List<MyFeed> _myFeeds;

  List<MyFeed> get myFeeds => _myFeeds;

  FeedBloc(this._feedRepository) : super(FeedInitial()) {
    _myFeeds = [];

    on<GetFeeds>((event, emit) async {
      emit(LoadingFeeds());

      final myFeedsResponse = await _feedRepository.fetchFeeds();

      myFeedsResponse.fold(
        // TODO(Gary): Emit error state
        (err) => Exception(),
        (myFeedList) => _myFeeds = myFeedList,
      );

      emit(SuccessLoadFeeds());
    });
  }
}
