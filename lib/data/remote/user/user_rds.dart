import 'package:quizlet/data/entities/user.dart';
import '../../../configs/constants/api_urls.dart';
import '../../../helpers/api_helper.dart';
import '../../../helpers/failures.dart';
import '../../../helpers/network_error_helper.dart';

abstract class UserRDS {
  Future<UserEntity> getUser();

  Future<UserEntity> refreshAccessTokenUser(String token);

  Future<void> logOutUser();
}

class UserRDSImpl implements UserRDS {
  NetworkService networkService;

  UserRDSImpl(this.networkService);

  @override
  Future<UserEntity> getUser() async {
    try {
      Map<String, dynamic> response =
          await networkService.getRequest(ApiEndPoints.getUser);
      return UserEntity.fromJson(response);
    } on Failure {
      rethrow;
    } catch (exception) {
      throw NetWorkServiceErrorHandler.convertExceptionsToFailure(exception);
    }
  }

  @override
  Future<UserEntity> refreshAccessTokenUser(String token) async {
    try {
      Map<String, dynamic> response = await networkService.postRequest(
          ApiEndPoints.refreshAccessTokenUser, token);
      return UserEntity.fromJson(response);
    } on Failure {
      rethrow;
    } catch (exception) {
      throw NetWorkServiceErrorHandler.convertExceptionsToFailure(exception);
    }
  }

  @override
  Future<void> logOutUser() async {
    try {
      Map<String, dynamic> response =
          await networkService.getRequest(ApiEndPoints.logOutUser);
    } on Failure {
      rethrow;
    } catch (exception) {
      throw NetWorkServiceErrorHandler.convertExceptionsToFailure(exception);
    }
  }
}
