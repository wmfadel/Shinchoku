import 'package:shinchoku/core/errors/app_error.dart';
import 'package:shinchoku/features/authentication/data/app_user.dart';
import 'package:shinchoku/features/authentication/repositories/auth/auth_interface.dart';
import 'package:shinchoku/features/authentication/repositories/auth/fire_auth.dart';
import 'package:shinchoku/features/authentication/repositories/user/fire_user.dart';
import 'package:shinchoku/features/authentication/repositories/user/user_interface.dart';

class AuthenticationService {
  final IAuth _authRepository = FireAuth();
  final IUser _userRepository = FireUser();

  Future<bool> checkUserExistsByEmail({required String email}) async {
    return await _userRepository.getUserByEmail(email) != null;
  }

  Future<AppUser> createNewUser(
      {required String email, required String password}) async {
    AppUser? user = await _authRepository.signupWithEmailAndPassword(
        email: email, password: password);
    if (user != null) {
      user = await _userRepository.storeUser(user);
    }
    return user!;
  }
}
