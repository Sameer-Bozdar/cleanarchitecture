import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_respository.dart';
import 'package:fpdart/src/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImp implements AuthRespository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImp(this.authRemoteDatasource);
  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(() async => await authRemoteDatasource
        .loginWithEmailPassword(email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String email,
      required String name,
      required String password}) async {
    return _getUser(() async => await authRemoteDatasource
        .signUpWithEmailPassword(name: name, email: email, password: password));
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await authRemoteDatasource.getCurrentUserData();

      if (user == null) {
        return left(Failure('User not loggin in '));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.error.toString()));
    }
  }
}
