import 'package:connector/core/error/failures.dart';
import 'package:connector/core/usecases/usecase.dart';
import 'package:connector/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class LogoutCurrentUser implements UseCase<void, NoParams> {
  final AuthRepo repo;

  LogoutCurrentUser({required this.repo});

  @override
  Future<Either<Failure, void>> call(noParams) async {
    return await repo.logoutCurrentUser();
  }
}
