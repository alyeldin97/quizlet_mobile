import 'package:dartz/dartz.dart';
import 'package:quizlet/domain/models/user.dart';

import '../../../helpers/failures.dart';

abstract class UserInRepo {
  Future<Either<Failure, UserModel>> getUser();
  Future<Either<Failure, UserModel>> refreshAccessTokenUser(String token);
  Future<Either<Failure, void>> logOutUser();
}
