import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shinchoku/features/authentication/data/app_user.dart';
import 'package:shinchoku/features/authentication/services/authentication_service.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthBloc get(BuildContext context) =>
      BlocProvider.of<AuthBloc>(context);

  final AuthenticationService autService;

  AuthBloc(this.autService) : super(AuthInitial()) {
    on<CheckUser>((event, emit) async {
      emit(AuthLoading());
      bool userExists =
          await autService.checkUserExistsByEmail(email: event.email);
      if (userExists) return emit(AuthOldUser(event.email));
      emit(AuthNewUser(event.email));
    });
  }

  AppUser? _appUser;

  AppUser? get appUser => _appUser;
}
