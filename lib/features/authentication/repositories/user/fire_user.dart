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
    if(snapshot.docs.isEmpty) return null;

    /// TODO: convert snapshot to [AppUser] model
    /// return snapshot.docs.first.data();
    return null;
  }

  @override
  Future<AppUser?> getUserById(String uid) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> storeUser(AppUser user) async {
    try {
      DocumentReference doc = await FirebaseFirestore.instance
          .collection('users')
          .add(user.toJson());
      user.id = doc.id;
      return user;
    } catch (_) {
      throw const ServerException('Cannot save user data on server!');
    }
  }
}
