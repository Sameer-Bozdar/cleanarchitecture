part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class UserLoggedIn extends AppUserState {
  final User user;

  UserLoggedIn({required this.user});
}


// core can not be depend on other folders/features

// other folders can depend on core foldder/features