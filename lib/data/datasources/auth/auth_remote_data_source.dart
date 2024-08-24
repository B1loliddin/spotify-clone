import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:spotify_clone/core/errors/server_exception.dart';
import 'package:spotify_clone/data/models/auth/user_model.dart';

abstract interface class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> signIn({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  const AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String message = '';

      debugPrint('Code: ${e.code}');

      switch (e.code) {
        case 'invalid-email':
          message = 'User not found';
        case 'INVALID_LOGIN_CREDENTIALS':
          message = 'Incorrect password';
        default:
          message = e.message ?? '';
      }

      debugPrint('Message: $message');

      throw ServerException(message);
    }
  }

  @override
  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userModel = UserModel(
        uid: userCredential.user!.uid,
        fullName: fullName,
        email: email,
        password: password,
      );

      firebaseFirestore.collection('users').add(userModel.toJson());
    } on FirebaseAuthException catch (e) {
      String message = '';

      debugPrint('Code: ${e.code}');

      switch (e.code) {
        case 'weak-password':
          message = 'The provided password is weak';
        case 'email-already-in-use':
          message = 'Email already in use';
        default:
          message = e.message ?? '';
      }

      debugPrint('Message: $message');

      throw ServerException(message);
    }
  }
}
