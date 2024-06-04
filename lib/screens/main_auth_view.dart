import 'package:connector/main.dart';
import 'package:connector/screens/dash.dart';
import 'package:connector/screens/login_view.dart';
import 'package:flutter/material.dart';

class MainAuthView extends StatelessWidget {
  const MainAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    // if logged in show the design view, else show the login view
    return Builder(
      builder: (context) {
        const bool isLoggedIn = false;
        if (isLoggedIn) {
          return const Dash();
        } else {
          return const LoginView();
        }
      },
    );
  }
}
