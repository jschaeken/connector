class SendPushParams {
  final String message;
  final List<SendPushVariable> variables;
  final String segment;

  SendPushParams(
      {required this.message, required this.variables, required this.segment});
}

class SendPushVariable {
  final String key;
  final String defaultValue;

  SendPushVariable({required this.key, required this.defaultValue});
}
