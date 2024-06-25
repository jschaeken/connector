import 'package:connector/core/error/failures.dart';
import 'package:connector/features/auth/data/datasources/auth_datasource.dart';
import 'package:connector/features/auth/domain/entities/user.dart';
import 'package:connector/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource dataSource;

  AuthRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, void>> loginWithEmailandPassword(
      String email, String password) async {
    return await dataSource.loginWithEmailandPassword(email, password);
  }

  @override
  Stream<ConnectorUser?> get authStateChangesStream =>
      dataSource.authStateChangesStream;
}
