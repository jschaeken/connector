import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connector/core/usecases/usecase.dart';
import 'package:connector/features/auth/domain/entities/user.dart';
import 'package:connector/features/auth/domain/usecases/get_current_user.dart';
import 'package:connector/features/auth/domain/usecases/login_with_email_and_password.dart';
import 'package:connector/features/auth/domain/usecases/logout_current_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithEmailAndPassword loginWithEmailAndPassword;
  final LogoutCurrentUser logoutCurrentUser;
  final GetCurrentUser getCurrentUser;
  final Stream<ConnectorUser?> authStateChanges;
  AuthBloc({
    required this.loginWithEmailAndPassword,
    required this.logoutCurrentUser,
    required this.getCurrentUser,
    required this.authStateChanges,
  }) : super(AuthInitial(timestamp: DateTime.now())) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginWithEmailPasswordEvent) {
        debugPrint(
            'LoginWithEmailPasswordEvent: ${event.email}, ${event.password}, ${state.runtimeType}');
        // Set Loading
        emit(AuthLoading(timestamp: DateTime.now()));

        debugPrint('LoginWithEmailPasswordEvent: ${state.runtimeType}');

        // Login with email and password
        final res = await loginWithEmailAndPassword(
            EmailPasswordParams(email: event.email, password: event.password));
        log('LoginWithEmailPasswordEvent: $res');
        return res.fold((l) {
          emit(
            AuthUnauthenticated(
              message: l.message,
              timestamp: DateTime.now(),
            ),
          );
        }, (r) {
          // Auth state changes will emit AuthStateChangedEvent, which will in turn, update the state
        });
      } else if (event is LogoutEvent) {
        // Set Loading
        emit(AuthLoading(timestamp: DateTime.now()));

        // Logout the user in the repository/database
        await logoutCurrentUser(NoParams());
        emit(AuthUnauthenticated(
            message: 'Logged out', timestamp: DateTime.now()));
      } else if (event is AuthStateChangedEvent) {
        // if the user is not null, emit AuthAuthenticated
        emit(AuthAuthenticated(
            user: event.user, errorMessage: "", timestamp: DateTime.now()));
      } else if (event is GetCurrentUserEvent) {
        // Set Loading
        emit(AuthLoading(timestamp: DateTime.now()));

        // Get current user
        final res = await getCurrentUser(NoParams());

        // If the user is not authenticated, or an error occurred, emit Unauthenticated
        res.fold((l) {
          emit(AuthUnauthenticated(
              message: l.message, timestamp: DateTime.now()));
        }, (r) {
          // Auth state changes will emit AuthStateChangedEvent, which will in turn, update the state
        });
      }
    });

    authStateChanges.listen((user) {
      if (user != null) {
        add(AuthStateChangedEvent(user));
      }
    });
  }
}
