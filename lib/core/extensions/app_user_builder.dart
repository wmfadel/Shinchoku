import 'package:firebase_auth/firebase_auth.dart';
import 'package:shinchoku/core/data/app_user.dart';

extension AppUserBuilder on UserCredential {
  AppUser? buildUserModel() {
    final User? fireUser = user;
    return AppUser(
      id: user?.uid,
      name: fireUser?.displayName,
      email: fireUser?.email,
      image: fireUser?.photoURL,
      phoneNumber: fireUser?.phoneNumber,
      isVerified: fireUser?.emailVerified,
      providerId: credential?.providerId,
      signInMethod: credential?.signInMethod,
    );
  }
}
