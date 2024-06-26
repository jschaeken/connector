import 'dart:developer';

import 'package:connector/core/error/failures.dart';
import 'package:connector/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class AuthDataSource {
  Future<Either<Failure, void>> loginWithEmailandPassword(
      String email, String password);
  Stream<ConnectorUser?> get authStateChangesStream;
  Future<Either<Failure, void>> logoutCurrentUser();
  Future<Either<Failure, void>> getCurrentUser();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth instance;

  AuthDataSourceImpl({required this.instance});

  @override
  Future<Either<Failure, void>> loginWithEmailandPassword(
      String email, String password) async {
    try {
      final user = await instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('User: $user');

      return const Right(
        null,
      );
    } on FirebaseException catch (e, s) {
      debugPrint('Firebase Error: ${e.code}, Stack trace: $s');
      switch (e.code) {
        case 'invalid-email':
          return const Left(ServerFailure(
              'Invalid email, please check the email you entered'));
        case 'user-not-found':
          return const Left(ServerFailure(
              'User not found, please check the email you entered'));
        case 'wrong-password':
          return const Left(ServerFailure(
              'Invalid password, please check the password you entered'));
        case 'invalid-credential':
          return const Left(ServerFailure(
              'Invalid credentials, please check the password you entered'));
        case 'user-disabled':
          return const Left(
              ServerFailure('User is disabled, please contact support'));
        default:
          return const Left(ServerFailure(
              'Error Status 500. An unexped server error occurred'));
      }
    } catch (e, s) {
      debugPrint('Sever Error: $e, Stack trace: $s');
      return const Left(
          ServerFailure('Error Status 500. An unexped server error occurred'));
    }
  }

  @override
  Stream<ConnectorUser?> get authStateChangesStream {
    return instance.authStateChanges().map((user) {
      if (user == null) {
        return null;
      } else {
        return ConnectorUser(uid: user.uid, email: user.email);
      }
    });
  }

  @override
  Future<Either<Failure, void>> logoutCurrentUser() async {
    try {
      await instance.signOut();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> getCurrentUser() async {
    try {
      final user = instance.currentUser;
      if (user == null) {
        return const Left(ServerFailure('User not found'));
      } else {
        return const Right(null);
      }
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
