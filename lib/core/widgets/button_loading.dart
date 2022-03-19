import 'package:flutter/material.dart';

class ShiLoading extends StatelessWidget {
  const ShiLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 32,
      height: 38,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
