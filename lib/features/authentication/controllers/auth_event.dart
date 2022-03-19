part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckUser implements AuthEvent {
  final String email;

  CheckUser(this.email);
}

class GetUser implements AuthEvent {}

class CreateUser implements AuthEvent {
  final String email, password;
  final String? name;

  CreateUser({required this.email, required this.password, this.name});
}

class EditingName implements AuthEvent {
  final String name;

  EditingName(this.name);
}
