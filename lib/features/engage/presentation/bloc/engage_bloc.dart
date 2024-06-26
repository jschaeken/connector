import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'engage_event.dart';
part 'engage_state.dart';

class EngageBloc extends Bloc<EngageEvent, EngageState> {
  EngageBloc() : super(EngageInitial()) {
    on<EngageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
