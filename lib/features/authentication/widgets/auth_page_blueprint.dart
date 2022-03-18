import 'package:flutter/material.dart';
import 'package:shinchoku/core/constants/images.dart';
import 'package:shinchoku/core/widgets/form_container.dart';
import 'package:shinchoku/core/widgets/shi_image.dart';

class AuthPagesBlueprint extends StatelessWidget {
  /// The content of the form page ex email, name or submit button
  final Widget form;

  const AuthPagesBlueprint({
    required this.form,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ShiImage(
          Images.authBackground,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(top: 32, left: 12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Text(
              '@SimzArts',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                FormContainer(child: form)
              ],
            ),
          ),
        )
      ],
    );
  }
}
