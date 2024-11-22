import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:fpdart/fpdart.dart';

// repository interface

abstract interface class AuthRespository {
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String email, required String name, required String password});

  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password});

  Future<Either<Failure, User>> getCurrentUser();
}
