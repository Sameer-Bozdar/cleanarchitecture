// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/features/auth/domain/repository/auth_respository.dart';
import 'package:fpdart/src/either.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/entities/user.dart';

class UserSessionUseCase implements UseCase<User, NoParams> {
  final AuthRespository authRepository;
  UserSessionUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, User>> call(params) async {
    return await authRepository.getCurrentUser();
  }
}
