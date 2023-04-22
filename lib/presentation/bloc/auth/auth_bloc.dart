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

      final userResponse = await _userRepository.getUser();

      return userResponse.fold(
        (err) => emit(FailedLoadUser(message: err.toString())),
        (user) => emit(DoneLoadUser(user: user)),
      );
    });
    on<LoginUser>((event, emit) async {
      emit(LoadingUser());

      final userResponse =
          await _userRepository.login(event.name, event.password);

      return userResponse.fold(
        (l) => null,
        (user) => emit(SuccessLoginUser()),
      );
    });
    on<Logout>((event, emit) async {
      emit(LoadingUser());

      final userResponse = await _userRepository.logout();

      return userResponse.fold(
        (l) => null,
        (r) => emit(SucessLogoutUser()),
      );
    });
  }
}
