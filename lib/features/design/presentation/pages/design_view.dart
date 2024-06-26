import 'package:flutter/material.dart';

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
