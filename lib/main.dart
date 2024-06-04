import 'package:connector/constants.dart';
import 'package:connector/firebase_options.dart';
import 'package:connector/screens/main_auth_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:connector/theme.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class DemoData {
  static const Map<String, Widget> featureViews = {
    'DESIGN': DesignView(),
    'ENGAGE': EngageView(),
    'INSIGHTS': InsightsView(),
    'Automation': AutomationView(),
    'Integrations': IntegrationsView(),
    'Settings': SettingsView(),
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get lightTheme => ThemeBuilder.lightTheme;

  get darkTheme => ThemeBuilder.darkTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      title: 'ESSENCE Connector',
      debugShowCheckedModeBanner: false,
      home: const MainAuthView(),
    );
  }
}

class DashView extends StatefulWidget {
  const DashView({super.key});

  @override
  State<DashView> createState() => _DashViewState();
}

class _DashViewState extends State<DashView> {
  void onDashViewTap(DashViewType key) {
    setState(() {
      selectedDashView = key;
    });
  }

  DashViewType selectedDashView = DashViewType.design;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // DashView Selector Tabs
          SizedBox(
            height: 65,
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (final view in DashViewType.values)
                        DashViewSelector(
                          view: view,
                          onTap: onDashViewTap,
                          isSelected: selectedDashView == view,
                        ),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),

          // DashView Content
          Expanded(
            child: selectedDashView.child,
          ),
        ],
      ),
    );
  }
}

class DashViewSelector extends StatelessWidget {
  const DashViewSelector({
    super.key,
    required this.view,
    required this.onTap,
    this.isSelected = false,
  });

  final DashViewType view;
  final Function(DashViewType dashViewType) onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Material(
        color: isSelected ? Theme.of(context).colorScheme.primary : null,
        child: InkWell(
          onTap: () => onTap(view),
          child: Container(
            height: double.infinity,
            alignment: Alignment.center,
            child: Text(
              view.name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : null,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

enum DashViewType {
  design('DESIGN', DesignView()),
  enagage('ENGAGE', EngageView()),
  insights('INSIGHTS', InsightsView()),
  automation('AUTOMATION', AutomationView()),
  integrations('INTEGRATIONS', IntegrationsView()),
  settings('SETTINGS', SettingsView());

  const DashViewType(this.name, this.child);
  final String name;
  final Widget child;
}

class DesignView extends StatelessWidget {
  const DesignView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Design View'),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings View'),
    );
  }
}

class IntegrationsView extends StatelessWidget {
  const IntegrationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Integrations View'),
    );
  }
}

class AutomationView extends StatelessWidget {
  const AutomationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Automation View'),
    );
  }
}

class InsightsView extends StatelessWidget {
  const InsightsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Insights View'),
    );
  }
}

class EngageView extends StatelessWidget {
  const EngageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Engage View'),
    );
  }
}
