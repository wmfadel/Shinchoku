import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinchoku/features/collaboration/collaboration.dart';
import 'package:shinchoku/features/dashboard/dashboard.dart';
import 'package:shinchoku/features/home/tabs_bloc/home_tabs_bloc.dart';
import 'package:shinchoku/features/tasks_lists/tasks_lists.dart';
import 'package:shinchoku/router/home_tabs.dart';
import 'package:go_router/go_router.dart';
import 'package:shinchoku/router/routes_info.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  /// TODO: Handle state with Bloc
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeTabsBloc>(context, listen: true);
    return Scaffold(
      body: IndexedStack(
        index: BlocProvider.of<HomeTabsBloc>(context).homeTabs.index,
        children: const [
          TasksListsPage(),
          DashboardPage(),
          CollaborationPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(RoutesInfo.newTaskPath),
        child: const Icon(Icons.add_outlined),
      ),
      bottomNavigationBar: NavigationBar(

        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        animationDuration: const Duration(seconds: 1),
        onDestinationSelected: (selectedIndex) {
          BlocProvider.of<HomeTabsBloc>(context)
              .add(ChangeHomeTabs(HomeTab.values[selectedIndex]));
        },
        selectedIndex: BlocProvider.of<HomeTabsBloc>(context).homeTabs.index,
        backgroundColor: Colors.white,
        height: 72,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Collaboration',
          ),
        ],
      ),
    );
  }
}
