part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthUnauthenticated extends AuthState {
  final String message;

  const AuthUnauthenticated({this.message = ''});

  @override
  List<Object> get props => [message];
}

class AuthAuthenticated extends AuthState {
  final ConnectorUser user;
  final String errorMessage;

  const AuthAuthenticated({
    required this.user,
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [errorMessage];
}
