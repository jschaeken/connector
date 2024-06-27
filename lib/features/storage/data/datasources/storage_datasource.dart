import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connector/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class StorageDataSource {
  Future<Either<Failure, String>> getProjectPrefixId(String uid);
}

class StorageDataSourceImpl implements StorageDataSource {
  FirebaseFirestore instance;

  StorageDataSourceImpl({required this.instance});

  @override
  Future<Either<Failure, String>> getProjectPrefixId(String uid) async {
    try {
      final userDoc = await instance.collection('users').doc(uid).get();

      try {
        final projectPrefixId = userDoc.get('projectPrefixId');
        return Right(projectPrefixId);
      } catch (e) {
        return const Left(ServerFailure('Project Prefix Id not found'));
      }
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
