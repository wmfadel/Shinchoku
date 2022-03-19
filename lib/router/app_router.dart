import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shinchoku/core/pages/error_page.dart';
import 'package:shinchoku/features/authentication/pages/authentication.dart';
import 'package:shinchoku/features/authentication/pages/login.dart';
import 'package:shinchoku/features/authentication/pages/register.dart';
import 'package:shinchoku/features/create_note/create_note.dart';
import 'package:shinchoku/features/home/controllers/home_tabs_bloc.dart';
import 'package:shinchoku/features/home/home_page.dart';
import 'package:shinchoku/features/splash/splah.dart';
import 'package:shinchoku/router/home_tabs.dart';
import 'package:shinchoku/router/routes_info.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
      initialLocation: RoutesInfo.splashPath,
      urlPathStrategy: UrlPathStrategy.path,
      redirect: _redirectHandler,
      refreshListenable: GoRouterRefreshStream(
        FirebaseAuth.instance.authStateChanges(),
      ),
      routes: [
        /// Splash
        GoRoute(
          path: RoutesInfo.splashPath,
          name: RoutesInfo.splashName,
          pageBuilder: (BuildContext context, GoRouterState routerState) {
            return MaterialPage(
              key: routerState.pageKey,
              child: const SplashPage(),
            );
          },
        ),

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
        GoRoute(
          path: RoutesInfo.registerPath,
          name: RoutesInfo.registerName,
          pageBuilder: (BuildContext context, GoRouterState routerState) {
            return MaterialPage(
              key: routerState.pageKey,
              child: RegisterPage(
                email: routerState.queryParams['email'] ?? 'Unkown@email.com',
              ),
            );
          },
        ),
        GoRoute(
          path: RoutesInfo.loginPath,
          name: RoutesInfo.loginName,
          pageBuilder: (BuildContext context, GoRouterState routerState) =>
              MaterialPage(
            key: routerState.pageKey,
            child: const LoginPage(),
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
                  path: RoutesInfo.newNotePath,
                  name: RoutesInfo.newNoteName,
                  pageBuilder:
                      (BuildContext context, GoRouterState routerState) {
                    _extractHomeTabName(routerState, context);
                    return MaterialPage(
                      key: routerState.pageKey,
                      child: CreateNotePage(
                        /// `noteId` is nullable String value of the task that
                        /// will be shown in [CreateNotePage] for editing the
                        /// task, if not provided the page will be opened in
                        /// create new task mood.
                        noteId: (routerState.extra as String?),
                      ),
                    );
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
        !_isInAuthFlow(routerState.location)) {
      return RoutesInfo.authPath;
    }

    /// If User in Auth Page and he has already logged in, Redirect to Home
    if (FirebaseAuth.instance.currentUser != null &&
        _isInAuthFlow(routerState.location)) {
      return RoutesInfo.splashPath;
    }
    return null;
  }

  static bool _isInAuthFlow(String location) {
    return location.startsWith(RoutesInfo.authPath);
  }

  /// Used to get current [HomeTab] item from path and set it in [HomeTabsBloc]
  static _extractHomeTabName(GoRouterState routerState, BuildContext context) {
    final String tabName = routerState.params['tab']!;
    BlocProvider.of<HomeTabsBloc>(context)
        .add(ChangeHomeTabs(tabFromName(tabName)));
  }
}
