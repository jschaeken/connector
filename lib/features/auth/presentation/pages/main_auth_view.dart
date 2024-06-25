import 'package:connector/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:connector/injection_container.dart';
import 'package:connector/core/navigation/presentation/pages/dash.dart';
import 'package:connector/features/auth/presentation/pages/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAuthView extends StatelessWidget {
  const MainAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (AuthInitial):
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case const (AuthAuthenticated):
              return const Dash();
            case const (AuthUnauthenticated):
              return const LoginView();
            default:
              return const Scaffold(
                body: Center(
                  child: Text('An error occurred'),
                ),
              );
          }
        },
      ),
    );
  }
}
