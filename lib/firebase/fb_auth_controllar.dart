import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoial_app/models/firebase_response.dart';
import 'package:scoial_app/models/usersAuth.dart';

class FbAuthControllar {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<FirebaseResponse> createAccount(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.sendEmailVerification();



      return FirebaseResponse(
          success: true,
          message: 'Account created successfully, activate to start');
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(success: false, message: e.message ?? '');
    }

  }












  Future<FirebaseResponse> sginIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      String message = userCredential.user!.emailVerified
          ? 'Logged in successfully'
          : 'Login failed!, activate your email';
      return FirebaseResponse(
          success: userCredential.user!.emailVerified, message: message);
    }on FirebaseAuthException catch (e) {
      return FirebaseResponse(success: false, message: e.message ?? '');
    }
  }

  Future<void> signOut() async => _firebaseAuth.signOut();

}