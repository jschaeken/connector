import 'dart:js_interop';
import 'dart:math';

import 'package:connector/core/error/failures.dart';
import 'package:connector/features/auth/domain/repositories/auth_repo.dart';
import 'package:connector/features/engage/data/datasources/engage_datasource.dart';
import 'package:connector/features/engage/domain/entities/push_result.dart';
import 'package:connector/features/engage/domain/entities/send_push_params.dart';
import 'package:connector/features/engage/domain/repositories/engage_repo.dart';
import 'package:dartz/dartz.dart';

class EngageRepoImpl implements EngageRepo {
  EngageDatasource datasource;
  AuthRepo authRepo;

  EngageRepoImpl({required this.datasource, required this.authRepo});

  @override
  Future<Either<Failure, PushResult>> sendPush(
    String message,
    List<SendPushVariable> variables,
    String segment,
  ) async {
    try {
      String? projectPrefixId = authRepo.projectPrefixId;
      if (projectPrefixId == null) {
        return const Left(
          ServerFailure(
            'Error retrieving projectId, are you logged in?',
          ),
        );
      }

      // call datasource.sendPush with message and tokens
      return await datasource.sendPush(
        message,
        variables,
        projectPrefixId,
        segment,
      );
    } catch (e) {
      final res = e.toString();
      return Left(ServerFailure(res));
    }
  }
}
