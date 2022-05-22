part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthCompleted extends AuthState {
  final String userName;

  AuthCompleted(this.userName);

  @override
  List<Object?> get props => [userName];
}

class AuthNewUser extends AuthState {
  final String email;

  AuthNewUser(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthOldUser extends AuthState {
  final String email;

  AuthOldUser(this.email);

  @override
  List<Object?> get props => [email];
}

/// TODO Create new bloc for updating this state
class AuthEditingName extends AuthState {
  final String name;

  AuthEditingName(this.name);

  @override
  List<Object?> get props => [name];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message) {
    Logger('AuthenticationService')
        .shout('AuthError state with message "$message"');
  }

  @override
  List<Object?> get props => [message];
}

class AuthUserLoggedOut extends AuthState {
  @override
  List<Object?> get props => [];
}
