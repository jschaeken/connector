import 'package:flutter/material.dart';

class PushVariableChip extends StatefulWidget {
  const PushVariableChip({
    super.key,
    required this.text,
    required this.onSubmitted,
    this.defaultValue,
    required this.isActive,
  });

  final String text;
  final Function(String) onSubmitted;
  final String? defaultValue;
  final bool isActive;

  @override
  State<PushVariableChip> createState() => _PushVariableChipState();
}

class _PushVariableChipState extends State<PushVariableChip> {
  late final FocusNode _focusNode;
  late final TextEditingController defaultValueController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    defaultValueController = TextEditingController(text: widget.defaultValue);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Chip(
        backgroundColor: widget.isActive
            ? Theme.of(context).colorScheme.primary.withOpacity(0.7)
            : Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.symmetric(vertical: 8),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.text),
            const SizedBox(width: 10),
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 180),
                child: SizedBox(
                  height: 35,
                  child: TextField(
                    focusNode: _focusNode,
                    controller: defaultValueController,
                    style: TextStyle(
                      height: 1,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.right,
                    cursorHeight: 15,
                    decoration: InputDecoration(
                      suffixIcon: _focusNode.hasFocus
                          ? IconButton(
                              icon: const Icon(Icons.check),
                              onPressed: () {
                                widget.onSubmitted(defaultValueController.text);
                              },
                            )
                          : null,
                      hoverColor: Theme.of(context).colorScheme.primary,
                      focusedBorder: focusedInputBorder(context),
                      hintText: 'Default value',
                      // label: Text(widget.text),
                      border: focusedInputBorder(context),
                    ),
                    onSubmitted: (value) {
                      widget.onSubmitted(value);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder focusedInputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    );
  }
}
