import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'integrations_event.dart';
part 'integrations_state.dart';

class IntegrationsBloc extends Bloc<IntegrationsEvent, IntegrationsState> {
  IntegrationsBloc() : super(IntegrationsInitial()) {
    on<IntegrationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
