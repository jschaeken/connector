part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginWithEmailPasswordEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogoutEvent extends AuthEvent {}

class AuthStateChangedEvent extends AuthEvent {
  final ConnectorUser user;

  const AuthStateChangedEvent(this.user);

  @override
  List<Object> get props => [user];
}
