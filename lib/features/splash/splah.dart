import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shinchoku/core/constants/images.dart';
import 'package:shinchoku/core/widgets/button_loading.dart';
import 'package:shinchoku/core/widgets/shi_image.dart';
import 'package:shinchoku/features/authentication/controllers/auth_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shinchoku/router/routes_info.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthBloc.get(context).add(GetUser());
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) => previous != current,
        buildWhen: (_, __) => false,
        listener: (context, state) {
          if (state is AuthCompleted) {
            Logger().v('From splash');
            context.go(RoutesInfo.homeInitialPath);
          } else if (state is AuthError) {
            context.go(RoutesInfo.authPath);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              ShiImage(
                Images.authBackground,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 128,
                child: ShiLoading(),
              )
            ],
          );
        },
      ),
    );
  }
}
