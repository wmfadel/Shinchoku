part of 'home_tabs_bloc.dart';

@immutable
abstract class HomeTabsEvent {
  final HomeTab tab;
  const HomeTabsEvent(this.tab);
}

class ChangeHomeTabs extends HomeTabsEvent {
  const ChangeHomeTabs(HomeTab tab) : super(tab);
}
