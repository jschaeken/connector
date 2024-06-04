import 'package:connector/main.dart';
import 'package:flutter/material.dart';

class Dash extends StatelessWidget {
  const Dash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        title: Image.asset(
          'assets/images/esd_logo.png',
          height: 70,
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsView()),
              );
            },
          ),
        ],
        centerTitle: false,
      ),
      body: const DashView(),
    );
  }
}
