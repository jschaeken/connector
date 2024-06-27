import 'package:connector/core/error/failures.dart';
import 'package:connector/features/auth/data/datasources/auth_datasource.dart';
import 'package:connector/features/auth/domain/entities/user.dart';
import 'package:connector/features/auth/domain/repositories/auth_repo.dart';
import 'package:connector/features/storage/domain/repositories/project_info_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class AuthRepoImpl implements AuthRepo {
  ConnectorUser? _user;

  @override
  ConnectorUser? get user => _user;

  String? _projectPrefixId;

  @override
  String? get projectPrefixId => _projectPrefixId;

  final AuthDataSource dataSource;
  final ProjectInfoRepo projectInfoRepo;

  AuthRepoImpl({required this.dataSource, required this.projectInfoRepo});

  @override
  Future<Either<Failure, void>> loginWithEmailandPassword(
      String email, String password) async {
    final loginFuture =
        await dataSource.loginWithEmailandPassword(email, password);
    return loginFuture.fold(
      (l) => Left(l),
      (r) {
        _user = r;
        _setProjectPrefixId();
        return const Right(null);
      },
    );
  }

  @override
  Stream<ConnectorUser?> get authStateChangesStream {
    return dataSource.authStateChangesStream;
  }

  @override
  Future<Either<Failure, void>> logoutCurrentUser() async {
    return await dataSource.logoutCurrentUser();
  }

  @override
  Future<Either<Failure, void>> getCurrentUser() async {
    final res = await dataSource.getCurrentUser();
    return res.fold(
      (l) => Left(l),
      (r) {
        _user = r;
        return const Right(null);
      },
    );
  }

  _setProjectPrefixId() async {
    if (_user?.uid == null) {
      return;
    }
    final res = await projectInfoRepo.getProjectPrefixId(_user!.uid);
    res.fold(
      (l) => _projectPrefixId = null,
      (r) {
        _projectPrefixId = r;
        debugPrint('set projectPrefixId in authRepoImpl: $_projectPrefixId');
      },
    );
  }
}
