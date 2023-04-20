// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_rss/api/feed_api.dart' as _i6;
import 'package:flutter_rss/common/bloc_utils.dart' as _i9;
import 'package:flutter_rss/coordinator/coordinator.dart' as _i4;
import 'package:flutter_rss/coordinator/my_coordinator_impl.dart' as _i5;
import 'package:flutter_rss/presentation/bloc/feed/feed_bloc.dart' as _i10;
import 'package:flutter_rss/repository/feed_repository.dart' as _i7;
import 'package:flutter_rss/repository/feed_repository_impl.dart' as _i8;
import 'package:flutter_rss/router/router.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.AppRouter>(_i3.AppRouter());
    gh.singleton<_i4.Coordinator>(_i5.MyCoordinatorImpl());
    gh.factory<_i6.FeedApi>(() => _i6.FeedApiImpl());
    gh.lazySingleton<_i7.FeedRepository>(
        () => _i8.FeedRepositoryImpl(gh<_i6.FeedApi>()));
    gh.singleton<_i9.MyBlocObserver>(_i9.MyBlocObserver());
    gh.factory<_i10.FeedBloc>(() => _i10.FeedBloc(gh<_i7.FeedRepository>()));
    return this;
  }
}
