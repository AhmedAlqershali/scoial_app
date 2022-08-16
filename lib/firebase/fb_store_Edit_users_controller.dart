import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoial_app/models/usersStoreEdit_models.dart';

class FbStoreEditUsersController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future create({required UsersStoreEditModels usersStoreEditModels}) async {
    return await _firebaseFirestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('EditUsers')
        .doc()
        .set(usersStoreEditModels.toMap())
        .then((value) {
      return true;
    }).onError((error, stackTrace) => false);
  }

  Stream<QuerySnapshot<UsersStoreEditModels>> getEditUsers() async* {
    yield* _firebaseFirestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('EditUsers')
        .withConverter<UsersStoreEditModels>(
        fromFirestore: (snapshot, options) =>
            UsersStoreEditModels.fromMap(snapshot.data()!),
        toFirestore: (UsersStoreEditModels value, options) => value.toMap())
        .snapshots();
  }

  Future<bool> updateEditUsers({required UsersStoreEditModels updatedUsersEdit}) async {
    return await _firebaseFirestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('EditUsers')
        .doc()
        .update(updatedUsersEdit.toMap())
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }

}
