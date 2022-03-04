import 'package:flutter/material.dart';
import 'package:shinchoku/core/theme/app_theme.dart';
import 'package:shinchoku/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShinchokuApp extends StatelessWidget {
  const ShinchokuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(374, 720),
        builder: () {
          return MaterialApp.router(
            title: 'Flutter Demo',
            theme: AppTheme.light,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routerDelegate: AppRouter.router.routerDelegate,
          );
        });
  }
}
