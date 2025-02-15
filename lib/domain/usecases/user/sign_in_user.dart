import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/domain/repositories/user_repsoitory.dart';

import '../../../core/error/failure.dart';
import '../../entities/user/user.dart';

class SignInUseCase implements UseCase<User, SignInParams> {
  final UserRepository repository;
  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await repository.signIn(params);
    
  }
}

class SignInParams {
  final String username;
  final String password;
  const SignInParams({
    required this.username,
    required this.password,
  });
}