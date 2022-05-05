import 'package:flutter/material.dart';

class TasksListAppbar extends StatelessWidget {
  const TasksListAppbar({Key? key}) : super(key: key);

  static const double appbarHeight = 280;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AppbarWaveClipper(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: appbarHeight,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.2),
          ],
        )),
      ),
    );
  }
}


