import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoial_app/models/usersAuth.dart';
import 'package:intl/intl.dart';
import 'package:scoial_app/models/users_post_models.dart';

class FbStorePostController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UsersPostModels? users;

  Future create({required UsersPostModels UsersPostModels}) async {
    return await _firebaseFirestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('UsersPost')
        .doc()
        .set((UsersPostModels.toMap()))
        .then((value) {
      return true;
    }).onError((error, stackTrace) => false);
  }

  Stream<QuerySnapshot<UsersPostModels>> getPostUsers() async* {
    yield* _firebaseFirestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('UsersPost')
        .withConverter<UsersPostModels>(
            fromFirestore: (snapshot, options) =>
                UsersPostModels.fromMap(snapshot.data()!),
            toFirestore: (UsersPostModels value, options) => value.toMap())
        .snapshots();
  }
}
