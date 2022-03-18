import 'package:shinchoku/features/authentication/repositories/auth_interface.dart';
import 'package:shinchoku/features/authentication/repositories/fire_auth.dart';

class AuthenticationService {
  final IAuth authRepository = FireAuth();
}
