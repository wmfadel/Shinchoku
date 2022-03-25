import 'dart:math';

class Images {
  Images._();

  /// Error Page Images
  static const String errorDog = 'assets/pics/error_dog.svg';
  static const String error404 = 'assets/pics/error_404.svg';

  /// Auth Pages
  static final String authBackground = 'assets/pics/simz/$_randomSimzImage.jpg';
  static const String authGoogle = 'assets/pics/google.svg';
  static const String authTwitter = 'assets/pics/twitter.svg';
  static const String authFacebook = 'assets/pics/facebook.svg';
  static const String authGithub = 'assets/pics/github.svg';


  /// Dialogs Images
  static const String dialogBubble = 'assets/pics/dialogs/message_bubble.svg';
  static const String dialogInfo = 'assets/pics/dialogs/info_head.svg';
  static const String dialogError = 'assets/pics/dialogs/fail_head.svg';
  static const String dialogSuccess = 'assets/pics/dialogs/success_head.svg';
  static const String dialogWarning = 'assets/pics/dialogs/warning_head.svg';


  static int get _randomSimzImage =>
      Random(DateTime.now().microsecondsSinceEpoch).nextInt(18);
}
