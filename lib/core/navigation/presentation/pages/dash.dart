import 'package:connector/core/common/widgets/shared_widgets.dart';
import 'package:connector/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:connector/features/auth/presentation/pages/auth_settings_view.dart';
import 'package:connector/features/automations/presentation/pages/automations_view.dart';
import 'package:connector/features/design/presentation/pages/design_view.dart';
import 'package:connector/features/engage/presentation/pages/engage_view.dart';
import 'package:connector/features/insights/presentation/pages/insights.dart';
import 'package:connector/features/integrations/presentation/pages/integrations_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum DashViewType {
  // design('DESIGN', DesignView()),
  enagage('ENGAGE', EngageView()),
  insights('INSIGHTS', InsightsView()),
  // automation('AUTOMATION', AutomationView()),
  // integrations('INTEGRATIONS', IntegrationsView()),
  settings('SETTINGS', SettingsView());

  const DashViewType(this.name, this.child);
  final String name;
  final Widget child;
}

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
                height: 11,
              ),
              const SizedBox(height: 18),
              Image.asset(
                isDarkMode
                    ? 'assets/brand_images/connector_white.png'
                    : 'assets/brand_images/connector_black.png',
                height: 20,
              ),
            ],
          ),
        ),
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.runtimeType) {
                case const (AuthAuthenticated):
                  return Text(
                    (state as AuthAuthenticated).user.email ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  );
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
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

  DashViewType selectedDashView = DashViewType.values.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Divider Line
          const FadeDivider(),

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
                const Spacer(flex: 4),
              ],
            ),
          ),
          const FadeDivider(),

          // DashView Content
          Expanded(
            child: selectedDashView.child,
          ),
        ],
      ),
    );
  }
}
