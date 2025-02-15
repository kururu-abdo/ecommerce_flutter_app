import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';

import '../entities/user/user.dart';
import '../usecases/user/sign_in_user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> signIn(SignInParams params);
  // Future<Either<Failure, User>> signUp(SignUpParams params);
  // Future<Either<Failure, NoParams>> signOut();
  // Future<Either<Failure, User>> getCachedUser();
}
