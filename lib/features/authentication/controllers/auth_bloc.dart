import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shinchoku/core/constants/strings.dart';
import 'package:shinchoku/core/errors/app_error.dart';

import '../data/app_user.dart';
import '../services/authentication_service.dart';

part 'auth_event.dart';

part 'auth_state.dart';

/// TODO: Listen to [AuthError] States and Handle them inUI.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthBloc get(BuildContext context) =>
      BlocProvider.of<AuthBloc>(context);

  final AuthenticationService autService;

  AuthBloc(this.autService) : super(AuthInitial()) {
    on<CheckUser>((event, emit) async {
      try {
        emit(AuthLoading());
        AppUser? serviceUser =
            await autService.checkUserExistsByEmail(email: event.email);
        if (serviceUser == null) return emit(AuthNewUser(event.email));
        _appUser = serviceUser;
        emit(AuthOldUser(event.email));
      } on AppError catch (e) {
        emit(AuthError(e.message));
      } on Exception catch (_) {
        emit(AuthError(Strings.defaultErrorMessage));
      }
    });

    on<CreateUser>((event, emit) async {
      try {
        emit(AuthLoading());
        _appUser = await autService.createNewUser(
            email: event.email, password: event.password, name: event.name);
        emit(AuthCompleted());
      } on AppError catch (e) {
        emit(AuthError(e.message));
      } on Exception catch (_) {
        emit(AuthError(Strings.defaultErrorMessage));
      }
    });

    on<CreateGoogleUser>((event, emit) async {
      emit(AuthLoading());
      try {
        _appUser = await autService.loginWithGoogle();
        if (_appUser == null) emit(AuthError('Cannot Continue with Google'));
        emit(AuthCompleted());
      } on AppError catch (e) {
        emit(AuthError(e.message));
      } on Exception catch (_) {
        emit(AuthError(Strings.defaultErrorMessage));
      }
    });

    on<CreateTwitterUser>((event, emit) async {
      try {
        emit(AuthLoading());
        _appUser = await autService.loginWithTwitter();
        if (_appUser == null) emit(AuthError('Cannot Continue with Twitter'));
        emit(AuthCompleted());
      } on AppError catch (e) {
        emit(AuthError(e.message));
      } on Exception catch (_) {
        emit(AuthError(Strings.defaultErrorMessage));
      }
    });

    on<LoginUser>((event, emit) async {
      try {
        emit(AuthLoading());
        _appUser = await autService.loginWithUser(
            email: _appUser!.email!, password: event.password);
        emit(AuthCompleted());
      } on AppError catch (e) {
        emit(AuthError(e.message));
      } on Exception catch (_) {
        emit(AuthError(Strings.defaultErrorMessage));
      }
    });

    on<EditingName>((event, emit) {
      emit(AuthEditingName(event.name));
    });

    /// Get [AppUser] object from [FirebaseAuth] `currentUser`
    on<GetUser>((event, emit) async {
      try {
        if (FirebaseAuth.instance.currentUser != null) {
          emit(AuthLoading());
          _appUser = await autService
              .getUSerById(FirebaseAuth.instance.currentUser!.uid);
          emit(AuthCompleted());
        }
      } on AppError catch (e) {
        emit(AuthError(e.message));
      } on Exception catch (_) {
        emit(AuthError(Strings.defaultErrorMessage));
      }
    });
  }

  AppUser? _appUser;

  AppUser? get appUser => _appUser;
}
