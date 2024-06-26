part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final DateTime timestamp;
  const AuthState({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

class AuthInitial extends AuthState {
  const AuthInitial({required super.timestamp});
}

class AuthLoading extends AuthState {
  const AuthLoading({required super.timestamp});
}

class AuthUnauthenticated extends AuthState {
  final String message;

  const AuthUnauthenticated({required this.message, required super.timestamp});

  @override
  List<Object> get props => [message, timestamp];
}

class AuthAuthenticated extends AuthState {
  final ConnectorUser user;
  final String errorMessage;

  const AuthAuthenticated({
    required this.user,
    this.errorMessage = '',
    required super.timestamp,
  });

  @override
  List<Object> get props => [errorMessage, user, timestamp];
}
