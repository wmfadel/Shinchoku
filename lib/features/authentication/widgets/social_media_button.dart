import 'package:flutter/material.dart';
import 'package:shinchoku/core/widgets/shi_image.dart';

class SocialMediaButton extends StatelessWidget {
  final String image;
  final String platformName;
  final void Function()? onPressed;

  const SocialMediaButton({
    required this.image,
    required this.platformName,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.white,
      height: 58,
      minWidth: double.maxFinite,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShiImage(
              image,
              width: 36,
              height: 36,
            ),
            const SizedBox(width: 14),
            Text('Continue with $platformName'),
          ],
        ),
      ),
    );
  }
}
