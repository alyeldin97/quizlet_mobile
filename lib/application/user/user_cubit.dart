import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizlet/data/local/user/user_lds.dart';
import 'package:quizlet/helpers/app_global_data.dart';
import 'package:quizlet/presentation/utils/navigators.dart';
import 'package:quizlet/presentation/utils/routes.dart';
import 'package:equatable/equatable.dart';

import '../../domain/models/user.dart';
import '../../domain/repos/user/user_in_repo.dart';
import '../../helpers/failures.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserLocalDataSource userLocalDataSource;
  UserInRepo userInRepo;
  static UserCubit get(context) => BlocProvider.of(context);

  UserCubit(this.userLocalDataSource, this.userInRepo) : super(UserInitial());
  bool? _isCached;

  bool get isCached {
    return _isCached ?? false;
  }

  Future<bool> checkCachedUser() async {
    bool isCached = await userLocalDataSource.checkCachedCustomer();
    _isCached = isCached;
    return isCached;
  }

  signOut(context) async {
    await userLocalDataSource.deleteCachedCustomer();
    AppNavigator.navigateToRouteAndRemoveUntil(Routes.signIn, context);
  }

  Future<void> getUser() async {
    emit(UserLoading());
    Either<Failure, UserModel> customerOrFailure = await userInRepo.getUser();
    customerOrFailure.fold((failure) => emit(UserFailure(failure: failure)),
        (customer) {
      emit(UserSuccess());
    });
  }

  Future<void> refreshAccessToken() async {
    emit(RefreshAccessTokenLoading());
    Either<Failure, UserModel> customerOrFailure = await userInRepo
        .refreshAccessTokenUser(AppGlobalData.CURRENT_USER!.refreshToken);
    customerOrFailure
        .fold((failure) => emit(RefreshAccessTokenFailure(failure: failure)),
            (customer) {
      emit(RefreshAccessTokenSuccess());
    });
  }

  Future<void> logOutUser() async {
    emit(LogOutUserLoading());
    Either<Failure, void> customerOrFailure = await userInRepo.logOutUser();
    customerOrFailure.fold(
        (failure) => emit(LogOutUserFailure(failure: failure)), (customer) {
      emit(LogOutUserSuccess());
    });
  }
}
