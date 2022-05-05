import 'package:flutter/material.dart';
import 'package:shinchoku/features/tasks_lists/utils/appbar_constants.dart';
import 'package:shinchoku/features/tasks_lists/widgets/appbar_title.dart';

import '../utils/appbar_wave_clipper.dart';

class SliverWaveAppbar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var adjustedShrinkOffset =
        shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.62;
    double topPadding = MediaQuery.of(context).padding.top + 16;
    print('adjust $adjustedShrinkOffset');
    print('offset $offset');
    print('shrink $shrinkOffset');
    print('factor ${40 / shrinkOffset}');
    return Stack(
      children: [
        ClipPath(
          clipper: AppbarWaveClipper(),
          child: Container(
            padding: const EdgeInsets.all(12),
            width: MediaQuery.of(context).size.width,
            height: AppbarConstants.appbarMaxHeight,
            color: Theme.of(context).colorScheme.secondary,
            child: SafeArea(
              child: Column(
                children: const [
                  AppbarTitle(),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: topPadding + offset,
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: (40 / shrinkOffset) < 1
                ? (40 / shrinkOffset) < 0.8
                    ? 0
                    : 40 / shrinkOffset
                : 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 185,
              color: Colors.green,
            ),
          ),
        ),
      ],
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
