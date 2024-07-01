import 'dart:convert';
import 'dart:developer';

import 'package:connector/core/error/failures.dart';
import 'package:connector/features/engage/domain/entities/push_result.dart';
import 'package:connector/features/engage/domain/entities/send_push_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class EngageDatasource {
  Future<Either<Failure, PushResult>> sendPush(
    String message,
    List<SendPushVariable> variables,
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
    List<SendPushVariable> variables,
    String projectPrefixId,
    String segment,
  ) async {
    try {
      final encodedMessage = Uri.encodeComponent(message);
      final allvariables = variables.map((e) {
        return """{"${e.key}": "${e.defaultValue}"}""";
      }).join(',');
      final encodedVariables = Uri.encodeComponent('[$allvariables]');
      final fullUri = Uri.parse(
          'https://pushglobalnotification-$projectPrefixId.a.run.app/?token=essence-software-secure-token&message=$encodedMessage&variables=$encodedVariables');
      log('Full URI: $fullUri');
      final response = await client.get(
        Uri.parse(fullUri.toString()),
      );
      log('Response: ${response.body}');
      if (response.statusCode == 200) {
        // Decode the response body into a map
        Map<String, dynamic> decodedResponse = json.decode(response.body);
        int attempted = response.body.contains('attempted')
            ? decodedResponse['attempted'] ?? 0
            : 0;
        int success =
            response.body.contains('sent') ? decodedResponse['sent'] ?? 0 : 0;
        return Right(
          PushResult(
            totalTokensAttempted: attempted,
            pushFailure: attempted - success,
            pushSuccess: success,
          ),
        );
      } else {
        return Left(ServerFailure(
            'Failed to send push notification, ${response.body}'));
      }
      // log('encodedMessage: $encodedMessage, encodedVariables: $encodedVariables');
      // return Right(
      //   PushResult(
      //     totalTokensAttempted: 0,
      //     pushFailure: 0,
      //     pushSuccess: 0,
      //   ),
      // );
    } catch (e, s) {
      debugPrint('Error: $e, StackTrace: $s');
      return Left(ServerFailure(e.toString()));
    }
  }
}
