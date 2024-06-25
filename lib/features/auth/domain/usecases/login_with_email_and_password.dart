import 'package:connector/core/error/failures.dart';
import 'package:connector/core/usecases/usecase.dart';
import 'package:connector/features/auth/data/datasources/auth_datasource.dart';
import 'package:dartz/dartz.dart';

class LoginWithEmailAndPassword implements UseCase<void, EmailPasswordParams> {
  final AuthDataSource repo;

  LoginWithEmailAndPassword({required this.repo});

  @override
  Future<Either<Failure, void>> call(
      EmailPasswordParams emailPassparams) async {
    return await repo.loginWithEmailandPassword(
        emailPassparams.email, emailPassparams.password);
  }
}

class EmailPasswordParams extends Params {
  final String email;
  final String password;

  EmailPasswordParams({required this.email, required this.password});
}
