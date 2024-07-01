import 'dart:developer';

import 'package:connector/core/navigation/presentation/pages/dash.dart';
import 'package:connector/features/engage/domain/entities/send_push_params.dart';
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

class VariableTextController extends TextEditingController {
  final List<String> validVariables;
  final Function(List<String> variables) onVariablesUsed;
  final String? regexPattern;

  VariableTextController({
    String? text,
    required this.validVariables,
    required this.onVariablesUsed,
    this.regexPattern,
  }) : super.fromValue(text == null
            ? TextEditingValue.empty
            : TextEditingValue(text: text));
  List<String> variablesUsed = [];

  @override
  set value(TextEditingValue newValue) {
    super.value = newValue;
    updateVariablesUsed();
  }

  void updateVariablesUsed() {
    variablesUsed.clear();
    final RegExp matchPattern = RegExp(regexPattern ?? r'{{(.*?)}}');

    for (final Match match in matchPattern.allMatches(text)) {
      final String variableName = match.group(1)!;
      if (validVariables.any((element) => element == variableName)) {
        variablesUsed.add(variableName);
      }
    }
    onVariablesUsed(variablesUsed);
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final List<InlineSpan> children = [];
    final RegExp matchPattern = RegExp(regexPattern ?? r'{{(.*?)}}');
    int lastMatchEnd = 0;
    variablesUsed = [];

    for (final Match match in matchPattern.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        children.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }
      final String variableName = match.group(1)!;
      if (validVariables.any((element) => element == variableName)) {
        variablesUsed.add(variableName);
        children.add(
          TextSpan(
            text: match.group(0),
            style: style!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(.2),
            ),
          ),
        );
      } else {
        children.add(TextSpan(text: match.group(0)));
      }
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      children.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return TextSpan(children: children, style: style);
  }
}
