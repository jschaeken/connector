import 'package:connector/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:connector/features/insights/presentation/pages/insights.dart';
import 'package:connector/injection_container.dart';
import 'package:connector/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dash extends StatelessWidget {
  const Dash({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                isDarkMode
                    ? 'assets/brand_images/esd_logo_white.png'
                    : 'assets/brand_images/esd_logo_black.png',
                height: 10,
              ),
              const SizedBox(height: 25),
              Image.asset(
                isDarkMode
                    ? 'assets/brand_images/connector_white.png'
                    : 'assets/brand_images/connector_black.png',
                height: 25,
              ),
            ],
          ),
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
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w100,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
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
    return Center(
      child: Text(
        'Design View',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading: true,
      ),
      body: BlocProvider(
        create: (context) => sl<AuthBloc>(),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(builder: (context) {
                  if (state is AuthAuthenticated) {
                    return Text(
                      'Logged in as: ${state.user.email}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    );
                  } else {
                    return Text('state is: ${state.runtimeType}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ));
                  }
                }),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Settings View',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class IntegrationsView extends StatelessWidget {
  const IntegrationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Integrations View',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class AutomationView extends StatelessWidget {
  const AutomationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Automation View',
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
    ));
  }
}

class EngageView extends StatelessWidget {
  const EngageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Engage View',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
