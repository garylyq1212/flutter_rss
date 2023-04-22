import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rss/model/user/user.dart';
import 'package:flutter_rss/repositories/user_repository/user_repository.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@Injectable()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc(this._userRepository) : super(AuthInitial()) {
    on<GetUser>((event, emit) async {
      emit(LoadingUser());
      var userResponse = await _userRepository.getUser();

      userResponse.fold(
        (err) => emit(FailedLoadUser(message: err.toString())),
        (user) => DoneLoadUser(user: user),
      );
    });
  }
}
