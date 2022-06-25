// Hide Firebase User's functionality from the UI
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/cupertino.dart';

@immutable // Their internals are never going to be changed after initialization
class AuthUser {
  // Must know whether Email is verified
  final bool isEmailVerified;
  const AuthUser({required this.isEmailVerified});

  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isEmailVerified: user.emailVerified);
}
