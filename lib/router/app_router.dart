import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:shinchoku/core/pages/error_page.dart';
import 'package:shinchoku/features/authentication/controllers/auth_bloc.dart';
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
  final AuthBloc authBloc;
  late final GoRouter router;

  AppRouter(this.authBloc) {
    _log.finer('router constructor');
    router = _buildRouter();
  }

  static final Logger _log = Logger('AppRouter');

  GoRouter _buildRouter() {
    return GoRouter(
        initialLocation: RoutesInfo.splashPath,
        urlPathStrategy: UrlPathStrategy.path,
        redirect: _redirectHandler,
        refreshListenable: GoRouterRefreshStream(authBloc.stream),
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
            pageBuilder: (BuildContext context, GoRouterState routerState) {
              return MaterialPage(
                key: routerState.pageKey,
                child: const Authentication(),
              );
            },
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
            pageBuilder: (BuildContext context, GoRouterState routerState) {
              return MaterialPage(
                key: routerState.pageKey,
                child: const LoginPage(),
              );
            },
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
          _log.shout('Router Error: ${routerState.error}\n'
              'Router Error: ${routerState.toString()}');

          return const ErrorPage();
        });
  }

  /// Handler for [GoRouter]'s `redirect` method, Used mainly to navigate
  /// to and from authentication flow
  String? _redirectHandler(GoRouterState routerState) {
    debugPrint('REDIRECT: location ${routerState.location}');
    debugPrint('REDIRECT: user ${authBloc.appUser}');

    if (routerState.location == RoutesInfo.splashPath &&
        authBloc.isAuthComplete) {
      return RoutesInfo.homeInitialPath;
    }

    /// If User in The App Without logging in, Redirect to Auth.
    if (FirebaseAuth.instance.currentUser == null &&
        !_isInAuthFlow(routerState.location)) {
      return RoutesInfo.authPath;
    }

    /// If User in Auth Page and he has already logged in, Redirect to Home
    if (authBloc.isAuthComplete && _isInAuthFlow(routerState.location)) {
      _log.info('Home from redirect');
      return RoutesInfo.homeInitialPath;
    }
    return null;
  }

  bool _isInAuthFlow(String location) {
    return location.startsWith(RoutesInfo.authPath);
  }

  /// Used to get current [HomeTab] item from path and set it in [HomeTabsBloc]
  _extractHomeTabName(GoRouterState routerState, BuildContext context) {
    final String tabName = routerState.params['tab']!;
    BlocProvider.of<HomeTabsBloc>(context)
        .add(ChangeHomeTabs(tabFromName(tabName)));
  }
}

// extension on GoRouterState {
//   String? get report {
//     return 'name: $name, params: $params, queryParams: $queryParams, '
//         'extra: $extra, subloc: $subloc, location: $location, path: $path '
//         'fullPath: $fullpath, error: $error.';
//   }
// }
