import 'package:shinchoku/core/repositories/authentication/auth_interface.dart';
import 'package:shinchoku/core/repositories/authentication/fire_auth.dart';

class AuthenticationService {
  final IAuth authRepository = FireAuth();
}
