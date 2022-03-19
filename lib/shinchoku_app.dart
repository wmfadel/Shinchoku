import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinchoku/core/theme/app_theme.dart';
import 'package:shinchoku/features/authentication/controllers/auth_bloc.dart';
import 'package:shinchoku/features/authentication/services/authentication_service.dart';
import 'package:shinchoku/features/home/controllers/home_tabs_bloc.dart';
import 'package:shinchoku/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShinchokuApp extends StatelessWidget {
  const ShinchokuApp({Key? key}) : super(key: key);
  static FirebaseInAppMessaging fiam = FirebaseInAppMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(374, 720),
        builder: () {
          return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => HomeTabsBloc()),
                BlocProvider(
                  create: (_) =>
                      AuthBloc(AuthenticationService())..add(GetUser()),
                ),
              ],
              child: MaterialApp.router(
                title: 'Shinchoku',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                routeInformationParser: AppRouter.router.routeInformationParser,
                routerDelegate: AppRouter.router.routerDelegate,
              ));
        });
  }
}
