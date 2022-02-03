import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:foocafe_flutter_firebase_chat/helpers/constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Stream<User?> get user => _auth.authStateChanges();

  Future<void> signup(String name, String email, String password) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (authResult.user != null) {
        String? token = await _messaging.getToken();
        usersRef.doc(authResult.user!.uid).set({
          'name': name,
          'email': email,
          'profileImageUrl': '',
          'bio': '',
          'token': token,
        });
      }
    } on PlatformException {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on PlatformException {
      rethrow;
    }
  }

  Future<void> logout() async {
    Future.wait([
      _auth.signOut(),
    ]);
  }
}
