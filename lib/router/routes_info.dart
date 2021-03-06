import 'package:shinchoku/router/home_tabs.dart';

class RoutesInfo {
  RoutesInfo._();

  /// Authentication
  static const authPath = '/auth';
  static const authName = 'authentication';

  /// Registration
  static const registerPath = '/auth-register';
  static const registerName = 'registration';

  /// Login
  static const loginPath = '/auth-login';
  static const loginName = 'login';

  /// Splash - Initial data loading
  static const splashPath = '/';
  static const splashName = 'splash';

  /// '/home/:tab(${HomeTab.values.map((e) => e.name).join('|')})'
  ///
  /// Home: `/:tab(${HomeTab.values.map((e) => e.name).join('|')})` is used to
  /// ensure that [HomeTab] values are the only values accepted by this endpoint
  /// it is equivalent to `/:tab(lists|dashboard| collaboration)` but this way
  /// it will be dynamic and adding more tabs wont require adding them here.
  static final homePath =
      '/home/:tab(${HomeTab.values.map((e) => e.name).join('|')})';
  static final homeInitialPath = '/home/${HomeTab.lists.name}';
  static const homeName = 'home';

  /// Create Note
  static const newNotePath = 'newNote';
  static const newNoteName = 'new-note';
}
