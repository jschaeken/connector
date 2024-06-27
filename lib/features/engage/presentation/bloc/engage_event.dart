part of 'engage_bloc.dart';

abstract class EngageEvent extends Equatable {
  const EngageEvent();

  @override
  List<Object> get props => [];
}

class SendPushEvent extends EngageEvent {
  final String message;
  final String? segment;

  const SendPushEvent({required this.message, this.segment});

  @override
  List<Object> get props => [message, segment ?? ''];
}
