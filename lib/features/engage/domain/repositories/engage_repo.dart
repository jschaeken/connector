import 'package:connector/core/error/failures.dart';
import 'package:connector/features/engage/domain/entities/push_result.dart';
import 'package:dartz/dartz.dart';

abstract class EngageRepo {
  Future<Either<Failure, PushResult>> sendPush(
    String message,
    String segment,
  );
}
