import 'package:dartz/dartz.dart';
import 'package:quizlet/domain/models/user.dart';
import 'package:quizlet/helpers/failures.dart';
import '../../../data/entities/user.dart';
import '../../../data/local/user/user_lds.dart';
import '../../../data/remote/user/user_rds.dart';
import 'user_in_repo.dart';

class UserInRepoImpl implements UserInRepo {
  UserRDS userRDS;
  UserLocalDataSource userLocalDataSource;

  UserInRepoImpl(this.userRDS, this.userLocalDataSource);

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    try {
      UserEntity userEntity = await userRDS.getUser();

      // ignore: non_constant_identifier_names
      UserModel userModel = userEntity.toModel();

      await userLocalDataSource.cacheUser(userModel);
      return right(userModel);
    } on Failure catch (failure) {
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, UserModel>> refreshAccessTokenUser(
      String token) async {
    try {
      UserEntity userEntity = await userRDS.refreshAccessTokenUser(token);

      // ignore: non_constant_identifier_names
      UserModel userModel = userEntity.toModel();

      await userLocalDataSource.cacheUser(userModel);
      return right(userModel);
    } on Failure catch (failure) {
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, void>> logOutUser() async {
    try {
      await userRDS.logOutUser();

      // ignore: non_constant_identifier_names

      await userLocalDataSource.deleteCachedCustomer();
      return right(null);
    } on Failure catch (failure) {
      return left(failure);
    }
  }
}
