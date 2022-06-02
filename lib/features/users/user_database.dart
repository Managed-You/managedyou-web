// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:managed_web/features/users/user_model.dart';

class UserDatabase extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _userCollection;

  Future<bool> addNewUser(Users users) async {
    _userCollection = _firestore.collection('users');
    try {
      await _userCollection.add({
        'email': users.email,
      });

      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  //check if email exist
  Future<bool> checkEmail(String email) async {
    _userCollection = _firestore.collection('users');
    bool isEmailExist = false;
    try {
      await _userCollection
          .where('email', isEqualTo: email)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          isEmailExist= true;
        } else {
          isEmailExist=  false;
        }
      });
      return isEmailExist;
    } catch (e) {
      return Future.error(e);
    }
  }
}
