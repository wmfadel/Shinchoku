part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckUser implements AuthEvent {
  final String email;

  CheckUser(this.email);
}

class GetUser implements AuthEvent {}

class LoginUser implements AuthEvent {
  final String password;

  LoginUser(this.password);
}

class CreateUser implements AuthEvent {
  final String email, password;
  final String? name;

  CreateUser({required this.email, required this.password, this.name});
}

class CreateGoogleUser implements AuthEvent {}

class CreateTwitterUser implements AuthEvent {}

class CreateGithubUser implements AuthEvent {}
class LogoutUser implements AuthEvent {}

class EditingName implements AuthEvent {
  final String name;

  EditingName(this.name);
}
