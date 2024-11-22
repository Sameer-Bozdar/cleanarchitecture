// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/core/entities/user.dart';
import 'package:fpdart/src/either.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';

import 'package:blog_app/features/auth/domain/repository/auth_respository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  AuthRespository authRepository;
  UserSignUp({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
        email: params.email, name: params.name, password: params.password);
  }
}

// class for passing more than one parameters
class UserSignUpParams {
  final String name;
  final String email;
  final String password;
  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
