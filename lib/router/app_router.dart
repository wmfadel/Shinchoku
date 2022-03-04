import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shinchoku/features/authentication/authentication.dart';
import 'package:shinchoku/features/home/home_page.dart';
import 'package:shinchoku/router/routes_info.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
      initialLocation: RoutesInfo.authPath,
      redirect: (GoRouterState routerState) {
        debugPrint('REDIRECT: path ${routerState.path}');
        debugPrint('REDIRECT: name ${routerState.name}');
        debugPrint('REDIRECT: location ${routerState.location}');
        debugPrint('REDIRECT: user ${FirebaseAuth.instance.currentUser}');

        /// If User in The App Without logging in, Redirect to Auth.
        if (FirebaseAuth.instance.currentUser == null &&
            routerState.location != RoutesInfo.authPath) {
          return RoutesInfo.authPath;
        }

        /// If User in Auth Page and he has already logged in, Redirect to Home
        if (FirebaseAuth.instance.currentUser != null &&
            routerState.location == RoutesInfo.authPath) {
          return RoutesInfo.homePath;
        }
        return null;
      },
      refreshListenable: GoRouterRefreshStream(
        FirebaseAuth.instance.authStateChanges(),
      ),
      routes: [
        GoRoute(
          path: RoutesInfo.authPath,
          name: RoutesInfo.authName,
          builder: (BuildContext context, GoRouterState routerState) =>
              const Authentication(),
        ),
        GoRoute(
          path: RoutesInfo.homePath,
          name: RoutesInfo.homeName,
          builder: (BuildContext context, GoRouterState routerState) =>
              const HomePage(),
        ),
      ],
      errorBuilder: (BuildContext context, GoRouterState routerState) {
        /// TODO: Replace with Actual Error Page.
        return Text(routerState.location + ' Error');
      });
}
