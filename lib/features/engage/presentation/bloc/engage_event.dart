part of 'engage_bloc.dart';

abstract class EngageEvent extends Equatable {
  const EngageEvent();

  @override
  List<Object> get props => [];
}

class SendPushEvent extends EngageEvent {
  final String message;
  final List<SendPushVariable>? variables;
  final String? segment;

  const SendPushEvent(
      {required this.message, required this.variables, this.segment});

  @override
  List<Object> get props => [message, segment ?? ''];
}
