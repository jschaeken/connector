import 'package:equatable/equatable.dart';

class VariableValueParams extends Equatable {
  final String key;
  final String value;

  const VariableValueParams({required this.key, required this.value});

  @override
  List<Object?> get props => [key, value];
}
