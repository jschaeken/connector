import 'package:bloc/bloc.dart';
import 'package:connector/features/engage/domain/entities/send_push_params.dart';
import 'package:connector/features/engage/domain/usecases/send_push_notification.dart';
import 'package:equatable/equatable.dart';

part 'engage_event.dart';
part 'engage_state.dart';

class EngageBloc extends Bloc<EngageEvent, EngageState> {
  SendPushNotification sendPushNotification;
  EngageBloc({required this.sendPushNotification}) : super(EngageInitial()) {
    on<EngageEvent>((event, emit) async {
      if (event is SendPushEvent) {
        emit(EngageLoading());
        final result = await sendPushNotification(
          SendPushParams(
            message: event.message,
            segment: event.segment ?? '',
          ),
        );
        result.fold((l) {
          emit(PushSentFailure(message: l.message));
        }, (r) {
          emit(
            PushSentSuccess(
                message:
                    "Push sent successfully. \nDevices: ${r.totalTokensAttempted} \nDelivered: ${r.pushSuccess} \nUndelivered: ${r.pushFailure}"),
          );
        });
      }
    });
  }
}
