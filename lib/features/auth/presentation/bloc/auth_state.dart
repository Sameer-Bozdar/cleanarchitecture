part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSucces extends AuthState {
  final User user;

  AuthSucces(this.user);
}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}
