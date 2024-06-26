import 'package:flutter/material.dart';

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
