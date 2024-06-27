import 'package:connector/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ProjectInfoRepo {
  Future<Either<Failure, String>> getProjectPrefixId(String uid);
}
