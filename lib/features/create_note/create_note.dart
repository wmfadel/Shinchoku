
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shinchoku/features/authentication/controllers/auth_bloc.dart';

/// Page used for creating/editing tasks, it decides if it's going to edit or
/// create new task depending on if a `taskId` value is provided.
class CreateNotePage extends StatelessWidget {
  /// nullable String value of the task that will be shown in edit mood,
  /// if not provided the page will be opened in create task mood.
  final String? noteId;

  /// TODO: accept [Note] Model if available instead of fetching it by `noteId`
  const CreateNotePage({
    this.noteId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                Share.share('https://shinchoku.com/home/dasboard');
              },
              child: const Text('Share'),
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutUser());
              },
              child: const Text('LOGOUT'),
            ),
          ],
        ),
      ),
    );
  }
}
