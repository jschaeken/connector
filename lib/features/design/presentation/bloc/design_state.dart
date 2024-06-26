part of 'design_bloc.dart';

abstract class DesignState extends Equatable {
  const DesignState();  

  @override
  List<Object> get props => [];
}
class DesignInitial extends DesignState {}
