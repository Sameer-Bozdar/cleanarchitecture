import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}

// Descriptions
// Success Type can be anything, it can be model, String , or number its depends on our logic

// Params paramter is used b/c we dont know the exactly number of params to pass over here 
