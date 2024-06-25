part of 'insights_bloc.dart';

abstract class InsightsState extends Equatable {
  const InsightsState();

  @override
  List<Object> get props => [];
}

class InsightsInitial extends InsightsState {}
