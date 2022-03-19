import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinchoku/features/authentication/controllers/auth_bloc.dart';

class TasksListsPage extends StatelessWidget {
  const TasksListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = BlocProvider.of<AuthBloc>(context, listen: true);

    return Scaffold(
      body: Center(
        child: Text(bloc.appUser?.name ?? ''),
      ),
    );
  }
}
