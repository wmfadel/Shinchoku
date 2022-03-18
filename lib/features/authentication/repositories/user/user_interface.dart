import 'package:shinchoku/features/authentication/data/app_user.dart';

abstract class IUser {
  Future<AppUser?> getUserByEmail(String email);

  Future<AppUser?> getUserById(String uid);

  Future<AppUser?> storeUser(AppUser user);
}
