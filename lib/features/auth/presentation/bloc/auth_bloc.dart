import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connector/features/auth/domain/entities/user.dart';
import 'package:connector/features/auth/domain/usecases/login_with_email_and_password.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithEmailAndPassword loginWithEmailAndPassword;
  final Stream<ConnectorUser?> authStateChanges;
  AuthBloc({
    required this.loginWithEmailAndPassword,
    required this.authStateChanges,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginWithEmailPasswordEvent) {
        log('loginWithEmailPasswordEvent: ${event.email} ${event.password}');
        final res = await loginWithEmailAndPassword(
            EmailPasswordParams(email: event.email, password: event.password));
        log('LoginWithEmailPasswordEvent: $res');
        res.fold((l) {
          emit(AuthUnauthenticated(message: l.message));
        }, (r) {
          // emit(const AuthAuthenticated(errorMessage: 'Logged in'));
        });
      } else if (event is LogoutEvent) {
        emit(const AuthUnauthenticated(message: 'Logged out'));
      } else if (event is AuthStateChangedEvent) {
        emit(AuthAuthenticated(user: event.user));
      }
    });

    authStateChanges.listen((user) {
      log('User auth state change: $user');
      if (user == null) {
        add(LogoutEvent());
      } else {
        add(AuthStateChangedEvent(user));
      }
    });
  }
}
