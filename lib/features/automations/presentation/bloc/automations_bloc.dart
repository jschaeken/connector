import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'automations_event.dart';
part 'automations_state.dart';

class AutomationsBloc extends Bloc<AutomationsEvent, AutomationsState> {
  AutomationsBloc() : super(AutomationsInitial()) {
    on<AutomationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
