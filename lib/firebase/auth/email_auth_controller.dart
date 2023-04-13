import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();

  User? get user => _auth.currentUser;
  signInWithEmail() async {


      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(email: 'email@mail.com', password: 'password');

      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          _firestore.collection("users").doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
            'phoneNumber': user.phoneNumber,
            'seller': false,
          });
        }
        return "success";
      } else {
        return "failed";
      }
    }
  }

