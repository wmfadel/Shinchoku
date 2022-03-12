import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shinchoku/core/pages/error_page.dart';
import 'package:shinchoku/features/authentication/authentication.dart';
import 'package:shinchoku/features/create_task/create_task.dart';
import 'package:shinchoku/features/home/home_page.dart';
import 'package:shinchoku/features/home/tabs_bloc/home_tabs_bloc.dart';
import 'package:shinchoku/router/home_tabs.dart';
import 'package:shinchoku/router/routes_info.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
      initialLocation: RoutesInfo.homeInitialPath,
      urlPathStrategy: UrlPathStrategy.path,
      redirect: _redirectHandler,
      refreshListenable: GoRouterRefreshStream(
        FirebaseAuth.instance.authStateChanges(),
      ),
      routes: [
        /// Authentication()
        GoRoute(
          path: RoutesInfo.authPath,
          name: RoutesInfo.authName,
          pageBuilder: (BuildContext context, GoRouterState routerState) =>
              MaterialPage(
            key: routerState.pageKey,
            child: const Authentication(),
          ),
        ),

        /// The main page -> Home Page with bottom Navbar
        GoRoute(
            path: RoutesInfo.homePath,
            name: RoutesInfo.homeName,
            pageBuilder: (BuildContext context, GoRouterState routerState) {
              _extractHomeTabName(routerState, context);
              return MaterialPage(
                  key: routerState.pageKey, child: const HomePage());
            },
            routes: [
              GoRoute(
                  path: RoutesInfo.newTaskPath,
                  name: RoutesInfo.newTaskName,
                  pageBuilder:
                      (BuildContext context, GoRouterState routerState) {
                    _extractHomeTabName(routerState, context);
                    return MaterialPage(
                        key: routerState.pageKey,
                        child: const CreateTaskPage());
                  }),
            ]),
      ],
      errorBuilder: (BuildContext context, GoRouterState routerState) {
        debugPrint('Router Error: ${routerState.error}');
        debugPrint('Router Error: ${routerState.toString()}');
        return const ErrorPage();
      });

  /// Handler for [GoRouter]'s `redirect` method, Used mainly to navigate
  /// to and from authentication flow
  static String? _redirectHandler(GoRouterState routerState) {
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
      return RoutesInfo.homeInitialPath;
    }
    return null;
  }

  /// Used to get current [HomeTab] item from path and set it in [HomeTabsBloc]
  static _extractHomeTabName(GoRouterState routerState, BuildContext context) {
    final String tabName = routerState.params['tab']!;
    BlocProvider.of<HomeTabsBloc>(context)
        .add(ChangeHomeTabs(tabFromName(tabName)));
  }
}
