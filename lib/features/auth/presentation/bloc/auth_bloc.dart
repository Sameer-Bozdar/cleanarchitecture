import 'package:blog_app/core/cubit/app_user_cubit.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/currentUser_session.dart';
import 'package:blog_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/user_signup_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final LoginUsecase _userLogin;
  final UserSessionUseCase _userSession;
  final AppUserCubit _appUserCubit;

  AuthBloc(
      {required UserSignUp userSignUp,
      required LoginUsecase userLogin,
      required AppUserCubit appUserCubit,
      required UserSessionUseCase userSession})
      : _userSignUp = userSignUp,
        _userSession = userSession,
        _userLogin = userLogin,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => (AuthLoading()));
    on<AuthSignUp>(_onUserSignUp);
    on<AuthLogin>(_onUserLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSession(NoParams());

    res.fold((l) => emit(AuthFailure(l.error)), (r) {
      debugPrint(r.name);
      return _emitAuthSuccess(r, emit);
    });
  }

  void _onUserSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignUp(
      UserSignUpParams(
          name: event.name, email: event.email, password: event.password),
    );

    res.fold(
      (l) => emit(AuthFailure(l.error)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onUserLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));

    res.fold(
        (l) => emit(AuthFailure(l.error)), (r) => _emitAuthSuccess(r, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSucces(user));
  }
}
