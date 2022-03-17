import 'dart:math';

class Images {
  Images._();

  /// Error Page Images
  static const String errorDog = 'assets/pics/error_dog.svg';
  static const String error404 = 'assets/pics/error_404.svg';

  /// Message Bubbles Images
  static const String messageBubble = 'assets/pics/message_bubble.svg';

  /// Auth Pages
  static final String authBackground = 'assets/pics/simz/$_randomSimzImage.jpg';
  static const String authGoogle = 'assets/pics/google.svg';
  static const String authTwitter = 'assets/pics/twitter.svg';
  static const String authFacebook = 'assets/pics/facebook.svg';

  static int get _randomSimzImage =>
      Random(DateTime.now().microsecondsSinceEpoch).nextInt(18);
}
