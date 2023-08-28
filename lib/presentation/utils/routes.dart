// ignore_for_file: prefer_const_constructors

import 'package:quizlet/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:quizlet/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';

class Routes {
  static const String splashScreen = "/";
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) {
          return SplashScreen();
        });

      case Routes.signIn:
        return MaterialPageRoute(builder: (context) {
          return SignInScreen();
        });
      case Routes.signUp:
        return MaterialPageRoute(builder: (context) {
          return SignUpScreen();
        });

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('No Route Found'),
              ),
              body: const Center(child: Text('No Route Found')),
            ));
  }
}
