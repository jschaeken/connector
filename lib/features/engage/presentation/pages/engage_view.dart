import 'dart:developer';

import 'package:connector/core/common/data/customer_data_properties.dart';
import 'package:connector/core/common/theme/theme.dart';
import 'package:connector/core/common/widgets/loading_overlay.dart';
import 'package:connector/core/common/widgets/shared_widgets.dart';
import 'package:connector/features/engage/domain/entities/send_push_params.dart';
import 'package:connector/features/engage/presentation/bloc/engage_bloc.dart';
import 'package:connector/features/engage/presentation/bloc/engage_notifier.dart';
import 'package:connector/features/engage/presentation/widgets/push_variable_chip.dart';
import 'package:connector/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class EngageView extends StatefulWidget {
  const EngageView({super.key});

  @override
  State<EngageView> createState() => _EngageViewState();
}

class _EngageViewState extends State<EngageView> {
  late VariableTextController _controller;
  final FocusNode pushFocusNode = FocusNode();
  late final EngageNotifier engageNotifier;

  @override
  void initState() {
    super.initState();
    // Getting the UI state change notifier
    engageNotifier = Provider.of<EngageNotifier>(context, listen: false);
    _controller = VariableTextController(
      validVariables: engageNotifier.variableKeysAvailable,
      onVariablesUsed: (vars) => _setVariablesUsed(vars),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pushFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    pushFocusNode.dispose();
    super.dispose();
  }

  // Event Handlers
  _sendPushPressed() {
    engageNotifier.sendPushNotification(
      _controller.text,
      context,
    );
  }

  _setNewDefaultValue(int index, String value) {
    final key = engageNotifier.variableKeysAvailable[index];
    engageNotifier.setDefaultValue(key, value);
  }

  _setVariablesUsed(List<String> varStringsUsed) {
    engageNotifier.setVariableStringsUsed(varStringsUsed);
  }

  // UI Helpers
  _showSnackBar(String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        BlocConsumer<EngageBloc, EngageState>(
          bloc: sl<EngageBloc>(),
          listener: (context, state) {
            if (state is PushSentSuccess) {
              _showSnackBar(state.message, true);
            } else if (state is PushSentFailure) {
              _showSnackBar(state.message, false);
            }
          },
          builder: (context, state) {
            return Expanded(
              child: Stack(children: [
                // Normal View
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Send Push Notification',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                            // Push Notification Input Textfield
                            Flexible(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: 500,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface
                                                      .withOpacity(
                                                        pushFocusNode.hasFocus
                                                            ? 1
                                                            : .5,
                                                      )),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                ThemeBuilder.glowBoxShadow(
                                                    context)
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              focusNode: pushFocusNode,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface),
                                              maxLines: 4,
                                              controller: _controller,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    'Enter your push notification message here, use {{variable}} to insert dynamic customer fields.',
                                                fillColor: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 70,
                                    ),
                                    ElevatedButton(
                                      onPressed: () => _sendPushPressed(),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          shape: StadiumBorder(
                                            side: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                          )),
                                      child: Text(
                                        'Send Push',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Dynamic Customer Fields
                      SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(.7),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dynamic Customer Fields',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 300,
                                child: Consumer<EngageNotifier>(
                                    builder: (context, value, child) {
                                  return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        value.variableKeysAvailable.length,
                                    itemBuilder: (context, index) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: PushVariableChip(
                                          text: value
                                              .variableKeysAvailable[index],
                                          isActive: value.variableStringsUsed
                                              .contains(
                                                  value.variableKeysAvailable[
                                                      index]),
                                          defaultValue: value
                                              .defaultPushVariables
                                              .firstWhere(
                                            (element) =>
                                                element.key ==
                                                value.variableKeysAvailable[
                                                    index],
                                            orElse: () {
                                              return SendPushVariable(
                                                  key: value
                                                          .variableKeysAvailable[
                                                      index],
                                                  defaultValue: '');
                                            },
                                          ).defaultValue,
                                          onSubmitted: (value) {
                                            _setNewDefaultValue(index, value);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Loading View
                if (state is PushSending)
                  const LoadingOverlay(text: 'Sending Push Notification...')
              ]),
            );
          },
        ),
      ],
    ));
  }
}
