import 'package:bloc/bloc.dart';
import 'package:flutter_rss/repository/feed_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'feed_event.dart';
part 'feed_state.dart';

@Injectable()
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository _feedRepository;

  FeedBloc(this._feedRepository) : super(FeedInitial()) {
    on<GetFeeds>((event, emit) {
      emit(LoadingFeeds());
      _feedRepository.fetchFeeds();
      emit(SuccessLoadFeeds());
    });
  }
}
