part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthCompleted extends AuthState {
  final String userName;
  AuthCompleted(this.userName);
}

class AuthNewUser extends AuthState {
  final String email;

  AuthNewUser(this.email);
}

class AuthOldUser extends AuthState {
  final String email;

  AuthOldUser(this.email);
}

class AuthEditingName extends AuthState {
  final String name;

  AuthEditingName(this.name);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message) {
    Logger().i('AuthError state with message "$message"');
  }
}
