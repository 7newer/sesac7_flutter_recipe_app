import 'package:flutter_recipe_app/core/routing/routes.dart';
import 'package:flutter_recipe_app/presentation/screen/create_account/create_account_screen.dart';
import 'package:flutter_recipe_app/presentation/screen/sign_in/sign_in_screen.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screen/main_screen.dart';
import '../../presentation/screen/splash_screen/splash_screen.dart';

final router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: Routes.signInScreen,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: Routes.signUpScreen,
      builder: (context, state) {
        return const CreateAccountScreen();
      },
    ),
    GoRoute(
      path: Routes.mainScreen,
      builder: (context, state) {
        return const MainScreen();
      },
    ),
  ],
);
