import 'package:firebase_auth/firebase_auth.dart';
import 'package:shinchoku/core/constants/keys.dart';
import 'package:shinchoku/core/errors/app_error.dart';
import 'package:shinchoku/core/extensions/app_user_builder.dart';
import 'package:shinchoku/features/authentication/data/app_user.dart';
import 'package:shinchoku/features/authentication/repositories/auth/auth_interface.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

class FireAuth implements IAuth {
  @override
  Future<AppUser?> signupWithEmailAndPassword({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(
          'https://avatars.dicebear.com/api/avataaars/${name?.replaceAll(' ', '_') ?? ''}.svg');
      return FirebaseAuth.instance.currentUser!.buildUserModel();
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
      return credential.user!.buildUserModel();
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(e.message ?? 'Cannot login now!');
    }
  }

  @override
  Future<AppUser?> loginWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await account?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user!.buildUserModel();
    } catch (_) {
      throw const AuthenticationException('Cannot Continue with Google!');
    }
  }

  @override
  Future<AppUser?> loginWithTwitter() async {
    try {
      final twitterLogin = TwitterLogin(
        apiKey: Keys.twitterApiKey,
        apiSecretKey: Keys.twitterApiSecretKey,
        redirectURI: Keys.twitterRedirectUri,
      );

      final authResult = await twitterLogin.login();
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(twitterAuthCredential);
      return userCredential.user!.buildUserModel();
    } catch (_) {
      throw const AuthenticationException('Cannot Continue with Google!');
    }
  }

  @override
  Future<AppUser?> loginWithFacebook() {
    // TODO: implement loginWithFacebook
    throw UnimplementedError();
  }
}
