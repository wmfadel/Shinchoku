import 'package:flutter/cupertino.dart';
import 'package:shinchoku/core/constants/images.dart';

enum DialogType {
  info,
  warning,
  error,
  success,
}

extension DialogIcon on DialogType {
  String get image {
    switch (this) {
      case DialogType.info:
        return Images.dialogInfo;
      case DialogType.warning:
        return Images.dialogWarning;
      case DialogType.error:
        return Images.dialogError;
      case DialogType.success:
        return Images.dialogSuccess;
    }
  }

  String get message {
    switch (this) {
      case DialogType.info:
        return 'Hi there!';
      case DialogType.warning:
        return 'Warning!';
      case DialogType.error:
        return 'Oh snap!';
      case DialogType.success:
        return 'Well done!';
    }
  }

  Color get color {
    switch (this) {
      case DialogType.info:
        return const Color(0xffB8B5FF);
      case DialogType.warning:
        return const Color(0xffFCA652);
      case DialogType.error:
        return const Color(0xffF05454);
      case DialogType.success:
        return const Color(0xff2D6A4F);
    }
  }

  Color get bubbleColor {
    switch (this) {
      case DialogType.info:
        return const Color(0xff7868E6);
      case DialogType.warning:
        return const Color(0xffCC561E);
      case DialogType.error:
        return const Color(0xffAF2D2D);
      case DialogType.success:
        return const Color(0xff004440);
    }
  }

}
