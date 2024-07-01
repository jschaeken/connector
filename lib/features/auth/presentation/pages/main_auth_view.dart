import 'package:connector/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:connector/core/navigation/presentation/pages/dash.dart';
import 'package:connector/features/auth/presentation/pages/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAuthView extends StatefulWidget {
  const MainAuthView({super.key});

  @override
  State<MainAuthView> createState() => _MainAuthViewState();
}

class _MainAuthViewState extends State<MainAuthView> {
  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  _getCurrentUser() {
    context.read<AuthBloc>().add(GetCurrentUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                    'This app is not supported on mobile devices, please use a desktop browser.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    )),
              ),
            ),
          );
        }
        return BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) {
            if (previous.runtimeType == AuthUnauthenticated &&
                current.runtimeType == AuthLoading) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            return Builder(
              builder: (context) {
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
                    return Scaffold(
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('An error occurred',
                                textAlign: TextAlign.center),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                _getCurrentUser();
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    );
                }
              },
            );
          },
        );
      },
    );
  }
}
