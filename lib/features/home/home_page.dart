import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinchoku/features/collaboration/collaboration.dart';
import 'package:shinchoku/features/dashboard/dashboard.dart';
import 'package:shinchoku/features/home/controllers/home_tabs_bloc.dart';
import 'package:shinchoku/features/tasks_lists/tasks_lists.dart';
import 'package:shinchoku/router/home_tabs.dart';
import 'package:go_router/go_router.dart';
import 'package:shinchoku/router/routes_info.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeTabsBloc homeTabsBloc =
        BlocProvider.of<HomeTabsBloc>(context, listen: true);
    return Scaffold(
      body: IndexedStack(
        index: homeTabsBloc.homeTabs.index,
        children: const [
          TasksListsPage(),
          DashboardPage(),
          CollaborationPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        animationDuration: const Duration(seconds: 1),
        onDestinationSelected: (selectedIndex) {
          /// return if clicked on the FAB
          if(selectedIndex >= HomeTab.values.length)return;
          context.goNamed(RoutesInfo.homeName,
              params: {'tab': HomeTab.values[selectedIndex].name});
        },
        selectedIndex: homeTabsBloc.homeTabs.index,
        backgroundColor: Colors.white,
        height: 72,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Home',
          ),
          const NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          const NavigationDestination(
            icon: Icon(Icons.people_alt),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: FloatingActionButton(
              onPressed: () => context.goNamed(
                RoutesInfo.newNoteName,
                params: {'tab': homeTabsBloc.homeTabs.name},
              ),
              child: const Icon(Icons.add_outlined),
            ),
            label: 'Collaboration',
          ),
        ],
      ),
    );
  }
}
