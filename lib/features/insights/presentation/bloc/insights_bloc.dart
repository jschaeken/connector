import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'insights_event.dart';
part 'insights_state.dart';

class InsightsBloc extends Bloc<InsightsEvent, InsightsState> {
  InsightsBloc() : super(InsightsInitial()) {
    on<InsightsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
