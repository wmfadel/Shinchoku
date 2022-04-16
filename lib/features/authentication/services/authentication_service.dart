import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:shinchoku/core/errors/app_error.dart';
import 'package:shinchoku/features/authentication/data/app_user.dart';
import 'package:shinchoku/features/authentication/repositories/auth/auth_interface.dart';
import 'package:shinchoku/features/authentication/repositories/auth/fire_auth.dart';
import 'package:shinchoku/features/authentication/repositories/user/fire_user.dart';
import 'package:shinchoku/features/authentication/repositories/user/user_interface.dart';

class AuthenticationService {
  final IAuth _authRepository = FireAuth();
  final IUser _userRepository = FireUser();
  final Logger _logger = Logger();

  Future<AppUser?> checkUserExistsByEmail({required String email}) async {
    try {
      return await _userRepository.getUserByEmail(email);
    } on Exception catch (e) {
      _logger.e('${e.runtimeType} : ${e.toString()}');
      throw const ServerException('Cannot Check this user on Server');
    }
  }

  Future<AppUser> createNewUser(
      {required String email, required String password, String? name}) async {
    try {
      AppUser? user = await _authRepository.signupWithEmailAndPassword(
          email: email, password: password, name: name);
      if (user != null) {
        user = await _userRepository.storeUser(user);
      }
      return user!;
    } on FirebaseAuthException catch (fireE) {
      _logger.e(fireE);
      throw ServerException(
          fireE.message ?? 'Cannot Check this user on Server');
    } on Exception catch (e) {
      _logger.e('${e.runtimeType} : ${e.toString()}');
      throw const ServerException('Cannot Check this user on Server');
    }
  }

  Future<AppUser?> loginWithUser(
      {required String email, required String password}) async {
    try {
      return await _authRepository.loginWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (fireE) {
      _logger.e(fireE);
      throw ServerException(
          fireE.message ?? 'Cannot Check this user on Server');
    } on Exception catch (e) {
      _logger.e('${e.runtimeType} : ${e.toString()}');
      throw const ServerException('Cannot Check this user on Server');
    }
  }

  Future<AppUser?> getUSerById(String uid) async {
    try {
      return await _userRepository.getUserById(uid);
    } on Exception catch (e) {
      _logger.e('${e.runtimeType} : ${e.toString()}');
      throw const ServerException('Cannot Check this user on Server');
    }
  }

  Future<AppUser?> loginWithGoogle() async {
    try {
      AppUser? user = await _authRepository.loginWithGoogle();
      if (user == null) {
        throw const AuthenticationException('Cannot Continue with Google!');
      }
      return await _userRepository.storeUser(user);
    } on FirebaseAuthException catch (fireE) {
      _logger.e(fireE);
      throw ServerException(
          fireE.message ?? 'Cannot Check this user on Server');
    } on AuthenticationException catch (_) {
      rethrow;
    } on Exception catch (e) {
      _logger.e('${e.runtimeType} : ${e.toString()}');
      throw const ServerException('Cannot Check this user on Server');
    }
  }

  Future<AppUser?> loginWithTwitter() async {
    try {
      AppUser? user = await _authRepository.loginWithTwitter();
      if (user == null) {
        throw const AuthenticationException('Cannot Continue with Twitter!');
      }
      return await _userRepository.storeUser(user);
    } on FirebaseAuthException catch (fireE) {
      _logger.e(fireE);
      throw ServerException(
          fireE.message ?? 'Cannot Check this user on Server');
    } on AuthenticationException catch (_) {
      rethrow;
    } on Exception catch (e) {
      _logger.e('${e.runtimeType} : ${e.toString()}');
      throw const ServerException('Cannot Check this user on Server');
    }
  }

  Future<void> logout()async{
   await _authRepository.logout();
  }
}
