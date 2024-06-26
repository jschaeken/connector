import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'design_event.dart';
part 'design_state.dart';

class DesignBloc extends Bloc<DesignEvent, DesignState> {
  DesignBloc() : super(DesignInitial()) {
    on<DesignEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
