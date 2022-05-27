// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:managed_web/features/users/user_model.dart';
import 'package:managed_web/pages/home_page.dart';

class UserDatabase extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _userCollection;

  Future<bool> addNewUser(Users users, BuildContext context) async {
    _userCollection = _firestore.collection('users');
    try {
      await _userCollection.add({
        'user': users.userName,
        'description': users.email,
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (Route<dynamic> route) => false,
      );
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  //check username
  Future<String?> checkUserName(String userName) async {
    _userCollection = _firestore.collection('users');

    String? valid;

    await _userCollection
        .where('user', isEqualTo: userName)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        valid = "Yes";
      } else {
        valid = "No";
      }
    });
    return valid;
  }
}
