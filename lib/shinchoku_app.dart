import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinchoku/core/theme/app_theme.dart';
import 'package:shinchoku/features/home/tabs_bloc/home_tabs_bloc.dart';
import 'package:shinchoku/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShinchokuApp extends StatelessWidget {
  const ShinchokuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(374, 720),
        builder: () {
          return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => HomeTabsBloc()),
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
