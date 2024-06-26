import 'package:flutter/material.dart';

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
