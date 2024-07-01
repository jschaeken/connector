import 'package:connector/core/error/failures.dart';
import 'package:connector/features/engage/domain/entities/push_result.dart';
import 'package:connector/features/engage/domain/entities/send_push_params.dart';
import 'package:dartz/dartz.dart';

abstract class EngageRepo {
  Future<Either<Failure, PushResult>> sendPush(
    String message,
    List<SendPushVariable> variables,
    String segment,
  );
}
