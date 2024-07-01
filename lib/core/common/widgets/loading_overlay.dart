import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingOverlay extends StatelessWidget {
  final String text;

  const LoadingOverlay({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Theme.of(context).colorScheme.surface.withOpacity(.5),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(),
    );
  }
}
