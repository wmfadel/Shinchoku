import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:shinchoku/core/theme/app_theme.dart';
import 'package:shinchoku/features/authentication/controllers/auth_bloc.dart';
import 'package:shinchoku/features/authentication/services/authentication_service.dart';
import 'package:shinchoku/features/home/controllers/home_tabs_bloc.dart';
import 'package:shinchoku/router/app_router.dart';

class ShinchokuApp extends StatelessWidget {

  final Logger _log = Logger('ShinchokuApp');
  ShinchokuApp({Key? key}) : super(key: key) {
    _authBloc = AuthBloc(AuthenticationService());
    appRouter  = AppRouter(_authBloc);
    _log.finer('main constructor');
  }


 late final AuthBloc _authBloc;
 late final AppRouter appRouter ;

  @override
  Widget build(BuildContext context) {
    _log.fine('main build');
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeTabsBloc()),
        BlocProvider.value(value: _authBloc),
      ],
      child:MaterialApp.router(
        key: const ValueKey('__material_app_key__'),
        title: 'Shinchoku',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routeInformationParser: appRouter.router.routeInformationParser,
        routerDelegate: appRouter.router.routerDelegate,
      ),
    );
  }
}
