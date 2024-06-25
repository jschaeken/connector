import 'package:connector/core/common/constants/constants.dart';
import 'package:connector/core/common/data/firebase_options.dart';
import 'package:connector/features/auth/presentation/pages/main_auth_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:connector/core/common/theme/theme.dart';
import 'injection_container.dart' as ic;

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ic.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get lightTheme => ThemeBuilder.lightTheme;

  get darkTheme => ThemeBuilder.darkTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      title: 'ESSENCE Connector',
      debugShowCheckedModeBanner: false,
      home: const MainAuthView(),
    );
  }
}
