import 'dart:developer';

import 'package:connector/core/error/failures.dart';
import 'package:connector/features/engage/domain/entities/push_result.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class EngageDatasource {
  Future<Either<Failure, PushResult>> sendPush(
    String message,
    String projectPrefixId,
    String segment,
  );
}

class EngageDatasourceImpl implements EngageDatasource {
  final http.Client client;

  EngageDatasourceImpl({required this.client});

  @override
  Future<Either<Failure, PushResult>> sendPush(
    String message,
    String projectPrefixId,
    String segment,
  ) async {
    try {
      final response = await client.get(Uri.parse(
          'https://pushglobalnotification-$projectPrefixId.a.run.app/?token=essence-software-secure-token&body=$message'));
      log('Response: ${response.body}');
      if (response.statusCode == 200) {
        return Right(
          PushResult(
            totalTokensAttempted: 0,
            pushFailure: 0,
            pushSuccess: 0,
          ),
        );
      } else {
        return Left(ServerFailure(
            'Failed to send push notification, ${response.body}'));
      }
    } catch (e, s) {
      debugPrint('Error: $e, StackTrace: $s');
      return Left(ServerFailure(e.toString()));
    }
  }
}
