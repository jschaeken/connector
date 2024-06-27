part of 'engage_bloc.dart';

abstract class EngageState extends Equatable {
  const EngageState();

  @override
  List<Object> get props => [];
}

class EngageInitial extends EngageState {}

class EngageLoading extends EngageState {}

class PushSentSuccess extends EngageState {
  final String message;

  const PushSentSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class PushSentFailure extends EngageState {
  final String message;

  const PushSentFailure({required this.message});

  @override
  List<Object> get props => [message];
}
