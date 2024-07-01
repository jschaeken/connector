import 'package:connector/core/common/data/customer_data_properties.dart';
import 'package:connector/features/engage/domain/entities/send_push_params.dart';
import 'package:connector/features/engage/presentation/bloc/engage_bloc.dart';
import 'package:connector/injection_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This is used for the engagement feature UI state management
class EngageNotifier extends ChangeNotifier {
  // Constant values
  final List<String> variableKeysAvailable = CustomerDataProperties.properties;

  // Mutable Values
  List<String> _variableStringsUsed = [];

  List<String> get variableStringsUsed => _variableStringsUsed;

  _setNewVariableStringsUsed(List<String> variables) {
    _variableStringsUsed = variables;
    notifyListeners();
  }

  List<SendPushVariable> _defaultPushVariables = [];

  List<SendPushVariable> get defaultPushVariables => _defaultPushVariables;

  _setNewDefaultVariableValue(String key, String value) {
    List<SendPushVariable> temp = _defaultPushVariables;
    temp.add(SendPushVariable(key: key, defaultValue: value));
    _defaultPushVariables = temp;
    debugPrint(
        'New default variable value set, list now: ${_defaultPushVariables.map((e) => """{${e.key}:"${e.defaultValue}"}""").toList()}');
    notifyListeners();
  }

  final EngageBloc engageBloc;

  EngageNotifier({required this.engageBloc});

  void sendPushNotification(
    String message,
    BuildContext context, {
    String? segment,
  }) {
    List<SendPushVariable> variables = _getVariablesUsedWithDefaults();
    debugPrint(
        'Variables: ${variables.map((e) => "${e.key}, ${e.defaultValue}").toList()}, Message: $message');
    engageBloc.add(
      SendPushEvent(
        message: message,
        variables: variables,
        segment: segment,
      ),
    );
  }

  void setDefaultValue(String key, String value) {
    _setNewDefaultVariableValue(key, value);
  }

  void setVariableStringsUsed(List<String> variables) {
    _setNewVariableStringsUsed(variables);
  }

  // Helper functions
  List<SendPushVariable> _getVariablesUsedWithDefaults() {
    List<SendPushVariable> variables = [];
    for (String variable in _variableStringsUsed) {
      if (_defaultPushVariables.any((element) => element.key == variable)) {
        variables.add(_defaultPushVariables
            .firstWhere((element) => element.key == variable));
      } else {
        variables.add(SendPushVariable(key: variable, defaultValue: ''));
      }
    }
    return variables;
  }
}
