import 'dart:developer';

import 'package:connector/core/error/failures.dart';
import 'package:connector/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  Future<Either<Failure, void>> loginWithEmailandPassword(
      String email, String password);

  // authStateChangesStream
  Stream<ConnectorUser?> get authStateChangesStream;
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
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
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
}
