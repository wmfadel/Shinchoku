import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shinchoku/router/home_tabs.dart';

part 'home_tabs_event.dart';

part 'home_tabs_state.dart';

class HomeTabsBloc extends Bloc<HomeTabsEvent, HomeTabsState> {
  HomeTabsBloc() : super(HomeTabsInitial()) {
    on<ChangeHomeTabs>((event, emit) {
      homeTabs = event.tab;
      emit(HomeTabsChanged());
    });
  }

  HomeTab homeTabs = HomeTab.lists;
}
