// ignore_for_file: prefer_final_fields

import 'package:bloc/bloc.dart';
import 'package:connector/core/common/data/customer_data_properties.dart';
import 'package:connector/features/engage/domain/entities/send_push_params.dart';
import 'package:connector/features/engage/domain/entities/variable_values.dart';
import 'package:connector/features/engage/domain/usecases/send_push_notification.dart';
import 'package:connector/features/engage/domain/usecases/set_deafult_values.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'engage_event.dart';
part 'engage_state.dart';

class EngageBloc extends Bloc<EngageEvent, EngageState> {
  // Use cases
  SendPushNotification sendPushNotification;

  EngageBloc({
    required this.sendPushNotification,
  }) : super(EngageInitial()) {
    on<EngageEvent>((event, emit) async {
      switch (event.runtimeType) {
        case const (SendPushEvent):
          debugPrint('SendPushEvent received');
          debugPrint('state hashcode from bloc: ${state.hashCode}');
          event as SendPushEvent;
          emit(PushSending());
          final result = await sendPushNotification(
            SendPushParams(
              message: event.message,
              variables: event.variables ?? [],
              segment: event.segment ?? '',
            ),
          );
          result.fold((l) {
            emit(PushSentFailure(message: l.message));
            debugPrint('Error: ${l.message}');
          }, (r) {
            emit(
              PushSentSuccess(
                  message:
                      "Push sent successfully. \nDevices: ${r.totalTokensAttempted} \nDelivered: ${r.pushSuccess} \nUndelivered: ${r.pushFailure}"),
            );
            debugPrint(
                'Push sent successfully. \nDevices: ${r.totalTokensAttempted} \nDelivered: ${r.pushSuccess} \nUndelivered: ${r.pushFailure}');
          });
          break;
      }
    });
  }
}
