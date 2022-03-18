import 'package:firebase_auth/firebase_auth.dart';
import 'package:shinchoku/features/authentication/data/app_user.dart';

extension AppUserBuilder on User {
  AppUser buildUserModel() {
    return AppUser(
      id: uid,
      name: displayName,
      email: email,
      image: photoURL,
      phoneNumber: phoneNumber,
      isVerified: emailVerified,
    );
  }
}
