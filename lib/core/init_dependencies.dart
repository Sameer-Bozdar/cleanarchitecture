import 'package:blog_app/core/cubit/app_user_cubit.dart';
import 'package:blog_app/core/secrets/supabase_secret.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_imp.dart';
import 'package:blog_app/features/auth/domain/repository/auth_respository.dart';
import 'package:blog_app/features/auth/domain/usecases/currentUser_session.dart';
import 'package:blog_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/user_signup_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecret().supabase_url, anonKey: AppSecret().supabase_anon);

  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImp(
      supabaseClient: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRespository>(
    () => AuthRepositoryImp(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignUp(
      authRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => LoginUsecase(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(() => AppUserCubit());
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      userSession: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSessionUseCase(
      authRepository: serviceLocator(),
    ),
  );
}
