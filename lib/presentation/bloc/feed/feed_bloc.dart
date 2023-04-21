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

  List<MyFeed> get myFeeds => _myFeeds;

  List<MyFeed> _myFeeds = [];
  final _feedList = <MyFeed>[];
  final _feedListFromApi = <MyFeed>[];

  FeedBloc(this._feedRepository) : super(FeedInitial()) {
    on<GetFeeds>((event, emit) async {
      emit(LoadingFeeds());

      if (!event.refresh) {
        _myFeeds = await _paginateFeedList(
          _feedListFromApi,
          offset: event.offset,
          limit: event.limit,
        );
      } else {
        _feedListFromApi.clear();
        _feedList.clear();

        final myFeedsResponse = await _feedRepository.fetchFeeds();
        myFeedsResponse.fold(
          // TODO(Gary): Emit error state
          (err) => Exception(),
          (myFeedList) async {
            _feedListFromApi.addAll(myFeedList);

            if (event.refresh) _feedList.clear();

            _myFeeds = await _paginateFeedList(
              _feedListFromApi,
              offset: event.offset,
              limit: event.limit,
            );
          },
        );
      }

      emit(SuccessLoadFeeds());
    });
  }

  Future<List<MyFeed>> _paginateFeedList(List<MyFeed> myFeedList,
      {int offset = 0, int limit = 10}) async {
    if (_feedList.length < myFeedList.length) {
      if (offset > 1 && offset <= myFeedList.length) {
        await Future.delayed(const Duration(milliseconds: 500));
        _feedList.addAll(myFeedList.sublist(offset, offset + limit));
      } else {
        _feedList.addAll(myFeedList.sublist(0, limit));
      }
    }

    return _feedList;
  }
}
