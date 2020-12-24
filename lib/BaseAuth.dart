import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'model/User.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.reference();

  Future<String> signIn(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    } catch (signInError) {
      if (signInError is PlatformException) {
        print(":::::>" + signInError.code);
        if (signInError.code == 'ERROR_USER_NOT_FOUND') {
          /// ERROR_USER_NOT_FOUND
          print('ERROR_USER_NOT_FOUND>' + signInError.code);

          return signInError.code;
        }
      }
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      isNewUser(user.uid, email, '', '');
      return user.uid;
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          /// `foo@bar.com` has alread been registered.
          print('ERROR_EMAIL_ALREADY_IN_USE>>' + signUpError.code);

          return signUpError.code;
        }
      }
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

// Future<bool> isNewUser(FirebaseUser user) async {
//   QuerySnapshot result = await Firestore.instance
//       .collection("users")
//       .where("email", isEqualTo: user.email)
//       .getDocuments();
//   final List<DocumentSnapshot> docs = result.documents;
//   return docs.length == 0 ? true : false;
// }

  Future<void> isNewUser(
      String userId, String email, String name, String imgUrl) {
    User user = User(email: email, name: name, imgUrl: imgUrl, Uid: userId);
    databaseReference.child("users").child(userId).set(user);
  }



}
