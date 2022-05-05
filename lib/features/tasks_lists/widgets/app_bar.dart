import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinchoku/core/widgets/shi_image.dart';
import 'package:shinchoku/features/tasks_lists/utils/appbar_constants.dart';

import '../../../core/constants/images.dart';
import '../../authentication/controllers/auth_bloc.dart';
import '../utils/appbar_wave_clipper.dart';

class SliverWaveAppbar extends SliverPersistentHeaderDelegate {
  final double appbarMaxHeight = 320;
  final double appbarMinHeight = 140;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context, listen: true);
   // print(shrinkOffset);
    return ClipPath(
      clipper: AppbarWaveClipper(),
      child: Container(
        padding: EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width,
        height: AppbarConstants.appbarMaxHeight,
        color: Theme.of(context).colorScheme.secondary,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('My Tasks',
                      style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.white)),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => AppbarConstants.appbarMaxHeight;

  @override
  double get minExtent => AppbarConstants.appbarMinHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent;
  }
}
