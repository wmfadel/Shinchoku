import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_tabs_event.dart';
part 'home_tabs_state.dart';

class HomeTabsBloc extends Bloc<HomeTabsEvent, HomeTabsState> {
  HomeTabsBloc() : super(HomeTabsInitial()) {
    on<HomeTabsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChangeHomeTabs>((event, emit) {
      index = event.index;
      emit(HomeTabsChanged());
    });
  }

  int index = 0;
}
