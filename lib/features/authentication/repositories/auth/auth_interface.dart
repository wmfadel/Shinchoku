import 'package:shinchoku/features/authentication/data/app_user.dart';

abstract class IAuth {
  Future<AppUser?> signupWithEmailAndPassword(
      {required String email, required String password, String? name});

  Future<AppUser?> loginWithEmailAndPassword(
      {required String email, required String password});

  Future<AppUser?> loginWithGoogle();

  Future<AppUser?> loginWithTwitter();

  Future<AppUser?> loginWithGithub();

  Future<AppUser?> loginWithFacebook();
}
