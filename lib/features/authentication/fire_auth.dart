// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireAuth extends ChangeNotifier {
  late User? _user;
  User? get user => _user;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get authStateChange => _auth.authStateChanges();

  FireAuth() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      if (user == null) {
        _isLoggedIn = false;
      } else {
        _isLoggedIn = true;
      }
      notifyListeners();
    });
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      Navigator.pushNamed(
        context,
        '/loading',
      );
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      await verifyUser();
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        ModalRoute.withName('/'),
      );
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  ModalRoute.withName('/'),
                );
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password,
      String username, BuildContext context) async {
    try {
      Navigator.pushNamed(
        context,
        '/loading',
      );
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await verifyUser();
      await _auth.currentUser?.updateDisplayName(username);
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        ModalRoute.withName('/'),
      );
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  ModalRoute.withName('/'),
                );
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      Navigator.pushNamed(
        context,
        '/loading',
      );
      await _auth.signInWithCredential(credential);
      await verifyUser();
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        ModalRoute.withName('/'),
      );
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    ModalRoute.withName('/'),
                  );
                },
                child: const Text("OK"))
          ],
        ),
      );
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    // Create a new provider
    FacebookAuthProvider facebookProvider = FacebookAuthProvider();

    facebookProvider.addScope('email');
    facebookProvider.setCustomParameters({
      'display': 'popup',
    });

    try {
      Navigator.pushNamed(
        context,
        '/loading',
      );
      await _auth.signInWithPopup(facebookProvider);
      await verifyUser();
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        ModalRoute.withName('/'),
      );
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  ModalRoute.withName('/'),
                );
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  Future<void> signInWithGitHub(BuildContext context) async {
    // Create a new provider
    GithubAuthProvider githubProvider = GithubAuthProvider();

    try {
      Navigator.pushNamed(
        context,
        '/loading',
      );
      await _auth.signInWithPopup(githubProvider);
      await verifyUser();
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        ModalRoute.withName('/'),
      );
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  ModalRoute.withName('/'),
                );
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  Future<void> verifyUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> signOut(BuildContext context) async {
    Navigator.pushNamed(
      context,
      '/loading',
    );
    await _auth.signOut();
    _isLoggedIn = false;
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      ModalRoute.withName('/'),
    );
  }
}
