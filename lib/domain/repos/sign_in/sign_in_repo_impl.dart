import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:quizlet/domain/repos/sign_in/sign_in_repo.dart';
import '../../../data/entities/user.dart';
import '../../../data/remote/sign-in/sign_in_rds.dart';
import '../../../helpers/failures.dart';
import '../../models/user.dart';

class SignInRepoImpl implements SignInRepo {
  SignInRemoteDataSource signInRemoteDataSource;

  SignInRepoImpl(
    this.signInRemoteDataSource,
  );

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
    required bool cache,
  }) async {
    try {
      UserEntity customer = await signInRemoteDataSource
          .signInWithEmailAndPassword(email: email, password: password);
      UserModel customerModel = customer.toModel();
      return right(customerModel);
    } on Failure catch (failure) {
      return left(failure);
    }
  }
}
