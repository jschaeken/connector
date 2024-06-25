import 'package:connector/core/error/failures.dart';
import 'package:connector/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> loginWithEmailandPassword(
      String email, String password);
  // Stream get authStateChanges;
  Stream<ConnectorUser?> get authStateChangesStream;
}
