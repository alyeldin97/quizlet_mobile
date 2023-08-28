import 'dart:developer';

import 'package:quizlet/domain/models/user.dart';
import 'package:quizlet/helpers/app_global_data.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quizlet/helpers/hive_helper.dart';
import 'dart:io' show Platform;

import 'configs/constants/hive.dart';

class Inits {
  static Future initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    await HiveHelper(HiveConstants.onboarding).openBox();
    await HiveHelper(HiveConstants.language).openBox();
    await HiveHelper(HiveConstants.user).openBox();
    await HiveHelper(HiveConstants.refreshToken).openBox();
    await HiveHelper(HiveConstants.accessToken).openBox();
  }

  // static Future<DeviceType> deviceType() async {
  //   if (Platform.isIOS) {
  //     IosDeviceInfo iOsInfo = await DeviceInfoPlugin().iosInfo;
  //     bool isPad = iOsInfo.name.toLowerCase().contains("ipad");

  //     if (isPad) {
  //       return DeviceType.iPad;
  //     }
  //   }
  //   return DeviceType.default_;
  // }

  static getCachedData() async {
    String cachedLanguage = await HiveHelper(HiveConstants.language)
            .getWithKey(HiveConstants.language) ??
        '';
    AppGlobalData.LANG = cachedLanguage;

    UserModel? cachedUser =
        await HiveHelper(HiveConstants.user).getWithKey(HiveConstants.user);

    AppGlobalData.CURRENT_USER = cachedUser;
    String? refreshToken = await HiveHelper(HiveConstants.refreshToken)
        .getWithKey(HiveConstants.refreshToken);

    log('LOG ANA TOKEN: $refreshToken');

    AppGlobalData.REFRESH_TOKEN = refreshToken;
    String? accessToken = await HiveHelper(HiveConstants.accessToken)
        .getWithKey(HiveConstants.accessToken);

    AppGlobalData.ACCESS_TOKEN = accessToken;
    print("AppGlobalData.ACCESS_TOKEN${AppGlobalData.ACCESS_TOKEN}");
  }
}

enum DeviceType {
  iPad,
  default_,
}
