import 'package:get_it/get_it.dart';
import 'application/global/global_cubit.dart';
import 'application/login/sign_in_cubit.dart';
import 'application/sign_up/sign_up_cubit.dart';
import 'application/user/user_cubit.dart';
import 'configs/constants/hive.dart';
import 'data/local/language/language.dart';
import 'data/local/language/language_impl.dart';
import 'data/local/user/user_lds.dart';
import 'data/local/user/user_lds_impl.dart';
import 'data/remote/sign-in/sign_in_rds.dart';
import 'data/remote/sign-in/sign_in_rds_impl.dart';
import 'data/remote/sign_up/sign_up_rds.dart';
import 'data/remote/user/user_rds.dart';
import 'domain/repos/sign_in/sign_in_repo.dart';
import 'domain/repos/sign_in/sign_in_repo_impl.dart';
import 'domain/repos/sign_up/sign_up_repo.dart';
import 'domain/repos/user/user_in_repo.dart';
import 'domain/repos/user/user_in_repo_impl.dart';
import 'helpers/api_helper.dart';
import 'helpers/hive_helper.dart';

final GetIt sl = GetIt.instance;

Future<void> initGetIt() async {
  //! NetWork Service
  sl.registerFactory<NetworkService>(
    () => NetworkServiceImpl(),
  );
  //! Hive Helpers
  sl.registerFactory<HiveHelper>(() => HiveHelper(HiveConstants.onboarding),
      instanceName: HiveConstants.onboarding);
  sl.registerFactory<HiveHelper>(() => HiveHelper(HiveConstants.refreshToken),
      instanceName: HiveConstants.refreshToken);
  sl.registerFactory<HiveHelper>(() => HiveHelper(HiveConstants.accessToken),
      instanceName: HiveConstants.accessToken);
  sl.registerFactory<HiveHelper>(() => HiveHelper(HiveConstants.language),
      instanceName: HiveConstants.language);
  sl.registerFactory<HiveHelper>(() => HiveHelper(HiveConstants.user),
      instanceName: HiveConstants.user);
  // ! Local data source

  sl.registerFactory<LanguageLocalDataSource>(() => LanguageLocalDataSourceImpl(
      sl.get(instanceName: HiveConstants.language)));

  // sl.registerFactory<TokenLocalDataSource>(() => TokenLocalDataSourceImpl(
  //     sl.get(instanceName: HiveConstants.accessToken)));
  sl.registerFactory<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sl.get(instanceName: HiveConstants.user)));

  // ! Remote data source
  sl.registerFactory<SignInRemoteDataSource>(
    () => SignInRemoteDataSourceImpl(sl()),
  );
  sl.registerFactory<SignUpRemoteDataSource>(
    () => SignUpRemoteDataSourceImpl(sl()),
  );

  sl.registerFactory<UserRDS>(
    () => UserRDSImpl(sl()),
  );

  // ! Repos

  sl.registerFactory<SignInRepo>(
    () => SignInRepoImpl(
      sl(),
    ),
  );
  sl.registerFactory<SignUpRepo>(
    () => SignUpRepoImpl(sl(), sl()),
  );

  sl.registerFactory<UserInRepo>(
    () => UserInRepoImpl(sl(), sl()),
  );
  // ! Cubits
  sl.registerFactory<GlobalCubit>(() => GlobalCubit(sl()));
  sl.registerFactory<SignInCubit>(() => SignInCubit(
        sl(),
      ));
  sl.registerFactory<UserCubit>(() => UserCubit(sl(), sl()));
  sl.registerFactory<SignUpCubit>(() => SignUpCubit(sl()));
}
