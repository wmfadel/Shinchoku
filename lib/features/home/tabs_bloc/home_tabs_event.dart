part of 'home_tabs_bloc.dart';

@immutable
abstract class HomeTabsEvent {
  final int index;
  const HomeTabsEvent(this.index);
}

class ChangeHomeTabs extends HomeTabsEvent {
  const ChangeHomeTabs(int index) : super(index);
}
