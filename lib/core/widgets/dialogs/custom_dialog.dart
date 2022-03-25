import 'package:flutter/material.dart';
import 'package:shinchoku/core/constants/images.dart';
import 'package:shinchoku/core/enums/dialogs_enum.dart';
import 'package:shinchoku/core/widgets/shi_image.dart';

extension Dialogs on BuildContext {
  showShiDialog({required DialogType type, required String message}) {
    showDialog(
        context: this,
        builder: (context) {
          return ShiDialog(type: type, message: message);
        });
  }
}

class ShiDialog extends StatelessWidget {
  final DialogType type;
  final String message;

  const ShiDialog({
    required this.type,
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32))),
      insetPadding: const EdgeInsets.only(left: 8, right: 8, top: 32),
      alignment: Alignment.topCenter,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            //  margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.fromLTRB(85, 8, 12, 8),
            constraints: const BoxConstraints(minHeight: 110),
            width: double.infinity,
            decoration: BoxDecoration(
              color: type.color,
              borderRadius: const BorderRadius.all(Radius.circular(32)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        type.message,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Flexible(
                        child: Text(
                          message,
                          style: Theme.of(context)
                              .textTheme
                              .overline!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 8, minHeight: 8),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
              ),
              child: ShiImage(
                Images.dialogBubble,
                color: type.bubbleColor,
                width: 64,
                height: 64,
              ),
            ),
          ),
          Positioned(
            top: -28,
            left: 22,
            child: ShiImage(type.image, width: 58, height: 58),
          ),
        ],
      ),
    );
  }
}
