import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  final Widget child;

  const FormContainer({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 35),
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      constraints:const BoxConstraints(maxWidth: 540),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      width: double.maxFinite,
      child: child,
    );
  }
}
