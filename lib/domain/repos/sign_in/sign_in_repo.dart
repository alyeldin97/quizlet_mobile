import 'package:dartz/dartz.dart';

import '../../../helpers/failures.dart';
import '../../models/user.dart';

abstract class SignInRepo {
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
    required bool cache,
  });
}
