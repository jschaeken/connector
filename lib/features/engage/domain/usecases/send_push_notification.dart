import 'package:connector/core/error/failures.dart';
import 'package:connector/core/usecases/usecase.dart';
import 'package:connector/features/engage/domain/entities/push_result.dart';
import 'package:connector/features/engage/domain/entities/send_push_params.dart';
import 'package:connector/features/engage/domain/repositories/engage_repo.dart';
import 'package:dartz/dartz.dart';

class SendPushNotification implements UseCase<void, SendPushParams> {
  final EngageRepo repo;

  SendPushNotification({required this.repo});

  @override
  Future<Either<Failure, PushResult>> call(SendPushParams params) async {
    return await repo.sendPush(
      params.message,
      params.variables,
      params.segment,
    );
  }
}
