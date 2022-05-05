import 'package:flutter/material.dart';
import 'package:shinchoku/features/tasks_lists/widgets/app_bar.dart';

class TasksListsPage extends StatelessWidget {
  const TasksListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AuthBloc authBloc = BlocProvider.of<AuthBloc>(context, listen: true);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverWaveAppbar(),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'I\'m a placeholder text, doin\' my zing',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              },
              childCount: 40,
            ),
          ),
        ],
      ),
    );
  }
}
