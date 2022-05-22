import 'package:flutter/material.dart';
import 'package:shinchoku/core/constants/images.dart';
import 'package:shinchoku/core/enums/dialogs_enum.dart';
import 'package:shinchoku/core/widgets/shi_image.dart';
import 'package:shinchoku/router/app_router.dart';

extension Dialogs on BuildContext {
  showShiDialog({required DialogType type, required String message}) {
    AppRouter.scaffoldMessengerKey.currentState?.clearSnackBars();
    AppRouter.scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      clipBehavior: Clip.none,
      backgroundColor: Colors.transparent,
      elevation: 0,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
      content: ShiDialog(type: type, message: message),
      duration: const Duration(seconds: 3),
    ));
  }
}

class ShiDialog extends StatefulWidget {
  final DialogType type;
  final String message;

  const ShiDialog({
    required this.type,
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  State<ShiDialog> createState() => _ShiDialogState();
}

class _ShiDialogState extends State<ShiDialog> with SingleTickerProviderStateMixin{

  late final AnimationController controller;
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    controller = AnimationController(vsync: this,duration:const Duration(milliseconds: 500));
    scaleAnimation = Tween<double>(begin:0.4,end:1).animate(controller);
    controller.forward();
    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            //  margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.fromLTRB(85, 8, 12, 8),
            constraints: const BoxConstraints(minHeight: 110),
            width: double.infinity,
            decoration: BoxDecoration(
              color: widget.type.color,
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
                        widget.type.message,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Flexible(
                        child: Text(
                          widget.message,
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
                color: widget.type.bubbleColor,
                width: 64,
                height: 64,
              ),
            ),
          ),
          Positioned(
            top: -28,
            left: 22,
            child: ShiImage(widget.type.image, width: 58, height: 58),
          ),
        ],
      ),
    );
  }
}
