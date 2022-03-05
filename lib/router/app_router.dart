import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shinchoku/core/pages/error_page.dart';
import 'package:shinchoku/features/authentication/authentication.dart';
import 'package:shinchoku/features/home/home_page.dart';
import 'package:shinchoku/features/home/tabs_bloc/home_tabs_bloc.dart';
import 'package:shinchoku/router/routes_info.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
      initialLocation: RoutesInfo.homeInitialPath,
      urlPathStrategy: UrlPathStrategy.hash,
      redirect: (GoRouterState routerState) {
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

        /// The main page -> Home Page with bottom Navbar
        GoRoute(
            path: RoutesInfo.homePath,
            name: RoutesInfo.homeName,
            builder: (BuildContext context, GoRouterState routerState) {
              final int tabIndex = int.parse(routerState.params['tab']!);
              BlocProvider.of<HomeTabsBloc>(context)
                  .add(ChangeHomeTabs(tabIndex));
              return const HomePage();
            }),
      ],
      errorBuilder: (BuildContext context, GoRouterState routerState) {
        debugPrint('Router Error: ${routerState.error}');
        debugPrint('Router Error: ${routerState.toString()}');
        return const ErrorPage();
      });
}
