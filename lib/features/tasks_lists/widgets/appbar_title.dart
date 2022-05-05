import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinchoku/features/authentication/controllers/auth_bloc.dart';

import '../../../core/constants/images.dart';
import '../../../core/widgets/shi_image.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'My Tasks',
          style: Theme.of(context)
              .textTheme
              .headline2
              ?.copyWith(color: Colors.white),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(90)),
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: ShiImage(
              authBloc.appUser?.image ?? Images.randomUserImage,
            ),
          ),
        ),
      ],
    );
  }
}
