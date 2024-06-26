import 'package:connector/core/navigation/presentation/pages/dash.dart';
import 'package:flutter/material.dart';

class FadeDivider extends StatelessWidget {
  const FadeDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: .8,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Theme.of(context).colorScheme.onSurface,
            Theme.of(context).colorScheme.surface,
          ],
        ),
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
