import 'package:firebase_auth/firebase_auth.dart';
import 'package:shinchoku/core/errors/app_error.dart';
import 'package:shinchoku/core/extensions/app_user_builder.dart';
import 'package:shinchoku/features/authentication/data/app_user.dart';
import 'package:shinchoku/features/authentication/repositories/auth/auth_interface.dart';

class FireAuth implements IAuth {
  @override
  Future<AppUser?> signupWithEmailAndPassword({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      return credential.buildUserModel();
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(e.message ?? 'Cannot create new user!');
    }
  }

  @override
  Future<AppUser?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.buildUserModel();
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(e.message ?? 'Cannot login now!');
    }
  }

  @override
  Future<AppUser?> loginWithFacebook() {
    // TODO: implement loginWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> loginWithTwitter() {
    // TODO: implement loginWithTwitter
    throw UnimplementedError();
  }
}
