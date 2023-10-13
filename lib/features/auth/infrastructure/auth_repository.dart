import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';

import '../domain/model_user.dart';

@lazySingleton
class AuthRepository {
  final FirebaseFirestore _firestore;

  AuthRepository(this._firestore);

  Future<User?> login(String username, String password) {
    return _firestore.collection("users").get().then(
        (querySnapshot) {
          final snapshot = querySnapshot.docs.singleWhereOrNull((docSnapshot) {
            if (docSnapshot.id == username) {
              final data = docSnapshot.data();
              if (data['password'] == password) {
                return true;
              }
            }
            return false;
          });

          if (snapshot != null) {
            return User(username: snapshot.data()['username']);
          }

          return null;
        },
        onError: (e) => null,
      );
  }
}
