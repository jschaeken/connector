import 'package:connector/features/auth/domain/entities/user.dart';
import 'package:connector/features/auth/domain/repositories/auth_repo.dart';

class AuthStateChagesStream {
  final AuthRepo repo;

  AuthStateChagesStream({required this.repo});

  Stream<ConnectorUser?> call() {
    return repo.authStateChangesStream;
  }
}
