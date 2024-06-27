import 'package:connector/core/error/failures.dart';
import 'package:connector/features/auth/domain/repositories/auth_repo.dart';
import 'package:connector/features/storage/data/datasources/storage_datasource.dart';
import 'package:connector/features/storage/domain/repositories/project_info_repo.dart';
import 'package:dartz/dartz.dart';

class ProjectInfoRepoImpl implements ProjectInfoRepo {
  StorageDataSource dataSource;

  ProjectInfoRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, String>> getProjectPrefixId(String uid) async {
    return await dataSource.getProjectPrefixId(uid);
  }
}
