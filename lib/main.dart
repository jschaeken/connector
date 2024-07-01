import 'dart:developer';

import 'package:connector/core/common/data/firebase_options.dart';
import 'package:connector/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:connector/features/auth/presentation/pages/main_auth_view.dart';
import 'package:connector/features/engage/presentation/bloc/engage_bloc.dart';
import 'package:connector/features/engage/presentation/bloc/engage_notifier.dart';
import 'package:connector/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:connector/core/common/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart' as ic;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MultiProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),
          BlocProvider<EngageBloc>(create: (context) => sl<EngageBloc>()),
          ChangeNotifierProvider<EngageNotifier>(
              create: (context) => sl<EngageNotifier>()),
        ],
        builder: (context, child) {
          return MaterialApp(
            themeMode: ThemeMode.system,
            theme: lightTheme,
            darkTheme: darkTheme,
            title: 'ESSENCE Connector',
            debugShowCheckedModeBanner: false,
            home: const MainAuthView(),
          );
        });
  }
}
