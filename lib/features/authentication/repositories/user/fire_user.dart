import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shinchoku/core/errors/app_error.dart';
import 'package:shinchoku/features/authentication/data/app_user.dart';
import 'package:shinchoku/features/authentication/repositories/user/user_interface.dart';

class FireUser implements IUser {
  @override
  Future<AppUser?> getUserByEmail(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (snapshot.docs.isEmpty) return null;
    return AppUser.fromFire(snapshot.docs.first.data() as Map<String, dynamic>);
  }

  @override
  Future<AppUser?> getUserById(String uid) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    return AppUser.fromFire((snapshot.data()! as Map<String, dynamic>));
  }

  @override
  Future<AppUser?> storeUser(AppUser user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set(user.toJson());

      return user;
    } catch (_) {
      throw const ServerException('Cannot save user data on server!');
    }
  }
}
