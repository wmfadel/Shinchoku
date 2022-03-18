import 'package:flutter/material.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 32,
      height: 32,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
