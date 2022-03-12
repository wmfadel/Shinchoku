import 'package:shinchoku/router/home_tabs.dart';

class RoutesInfo {
  RoutesInfo._();

  /// Authentication
  static const authPath = '/auth';
  static const authName = 'Authentication';

  /// Home: `/:tab(${HomeTab.values.map((e) => e.name).join('|')})` is used to
  /// ensure that [HomeTab] values are the only values accepted by this endpoint
  /// it is equivalent to `/:tab(lists|dashboard| collaboration)` but this way
  /// it will be dynamic and adding more tabs wont require adding them here.
  static final homePath =
      '/home/:tab(${HomeTab.values.map((e) => e.name).join('|')})';
  static final homeInitialPath = '/home/${HomeTab.lists.name}';
  static const homeName = 'Home';

  /// Create Task
  static const newTaskPath = 'newTask';
  static const newTaskName = 'NewTask';
}
