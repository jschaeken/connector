import 'package:connector/core/error/failures.dart';
import 'package:connector/core/usecases/usecase.dart';
import 'package:connector/features/engage/domain/entities/variable_values.dart';
import 'package:dartz/dartz.dart';

class SetDefaultVariableValue implements UseCase<void, VariableValueParams> {
  final String key;
  final String value;

  SetDefaultVariableValue({required this.key, required this.value});

  @override

  /// This is not being used as of yet as the bloc will hold the default state locally and ephemerally.
  Future<Either<Failure, void>> call(VariableValueParams params) async {
    return const Right(null);
  }
}
