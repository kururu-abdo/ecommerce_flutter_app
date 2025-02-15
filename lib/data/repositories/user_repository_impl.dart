
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/networkchecker/network_info.dart';
import 'package:ecommerce_app/data/data_sources/local/user/user_local_data_source.dart';
import 'package:ecommerce_app/data/data_sources/remote/user/user_remote_data_source.dart';
import 'package:ecommerce_app/data/models/user/user_auth_response.dart';
import 'package:ecommerce_app/domain/entities/user/user.dart';
import 'package:ecommerce_app/domain/repositories/user_repsoitory.dart';

typedef _DataSourceChooser = Future<AuthenticationResponseModel> Function();

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> signIn(params) async {
    return await _authenticate(() {
      return remoteDataSource.signIn(params);
    });
  }

  // @override
  // Future<Either<Failure, User>> signUp(params) async {
  //   return await _authenticate(() {
  //     return remoteDataSource.signUp(params);
  //   });
  // }

  // @override
  // Future<Either<Failure, User>> getCachedUser() async {
  //   try {
  //     final user = await localDataSource.getUser();
  //     return Right(user);
  //   } on CacheFailure {
  //     return Left(CacheFailure());
  //   }
  // }

  // @override
  // Future<Either<Failure, NoParams>> signOut() async {
  //   try {
  //     await localDataSource.clearCache();
  //     return Right(NoParams());
  //   } on CacheFailure {
  //     return Left(CacheFailure());
  //   }
  // }

  // Future<Either<Failure, User>> _authenticate(
  //     _DataSourceChooser getDataSource,
  //     ) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final remoteResponse = await getDataSource();
  //       localDataSource.saveToken(remoteResponse.token);
  //       localDataSource.saveUser(remoteResponse.user);
  //       return Right(remoteResponse.user);
  //     } on Failure catch (failure) {
  //       return Left(failure);
  //     }
  //   } else {
  //     return Left(NetworkFailure());
  //   }
  // }

  Future<Either<Failure, User>> _authenticate(
      _DataSourceChooser getDataSource,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await getDataSource();
        localDataSource.saveToken(remoteResponse.token);
        // localDataSource.saveUser(remoteResponse.user);
        return Right(remoteResponse.user);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure());
    }
  }

}
