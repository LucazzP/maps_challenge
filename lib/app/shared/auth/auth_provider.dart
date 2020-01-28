import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  static Future<FirebaseUser> get getCurrentUser => FirebaseAuth.instance.currentUser();
}