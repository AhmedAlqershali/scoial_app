import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoial_app/models/usersStoreEdit_models.dart';

import '../models/likes_models.dart';

class FbLikesController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future create({required LikesModel LikesModel}) async {


    return await _firebaseFirestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('UsersPost')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('Likes')
        .doc()
        .set(LikesModel.toMap())
        .then((value) {
      return true;
    }).onError((error, stackTrace) => false);
  }

  Stream<QuerySnapshot<LikesModel>> getEditUsers() async* {
    yield* _firebaseFirestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('EditUsers')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('Likes')
        .withConverter<LikesModel>(
            fromFirestore: (snapshot, options) =>
                LikesModel.fromMap(snapshot.data()!),
            toFirestore: (LikesModel value, options) => value.toMap())
        .snapshots();
  }
}
