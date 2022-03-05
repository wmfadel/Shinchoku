import 'package:shinchoku/router/home_tabs.dart';

class RoutesInfo {
  RoutesInfo._();

  // Authentication
  static const authPath = '/auth';
  static const authName = 'Authentication';

  // Home
  static const homePath = '/home/:tab';
  static const homeInitialPath = '/home/0';
  static const homeName = 'Home';

  /// Home Page tabs
  /// Using [HomeTabs] enum for the tabs path to ensure consistency
  /// in path name while navigating
  // TasksLists
  static final listsPath = '$homePath/${HomeTabs.lists.name}';
  static const listsName = 'Lists';

  // Dashboard
  static final dashboardPath = '$homePath/${HomeTabs.dashboard.name}';
  static const dashboardName = 'Dashboard';

  // Collaboration
  static final collaborationPath = '$homePath/${HomeTabs.collaboration.name}';
  static const collaborationName = 'Collaboration';

  // Create Task
  static const newTaskPath = '/newTask';
  static const newTaskName = 'NewTask';
}
