import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:scoial_app/models/usersAuth.dart';

class FbStoreuserAuthContraller extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UsersAuth? users;

  Future create({required UsersAuth users}) async {
    return await _firebaseFirestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('UserAuth')
        .doc()
        .set(users.toMap())
        .then((value) {
      return true;
    }).onError((error, stackTrace) => false);
  }


  Stream<QuerySnapshot<UsersAuth>> getEditUsers() async* {
    yield* _firebaseFirestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('UserAuth')
        .withConverter<UsersAuth>(
        fromFirestore: (snapshot, options) =>
            UsersAuth.fromMap(snapshot.data()!),
        toFirestore: (UsersAuth value, options) => value.toMap())
        .snapshots();
  }


}
