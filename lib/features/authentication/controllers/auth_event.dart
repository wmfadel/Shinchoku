part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckUser implements AuthEvent{
  final String email;
  CheckUser(this.email);
}

