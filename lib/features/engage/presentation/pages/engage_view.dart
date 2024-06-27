import 'package:connector/features/engage/presentation/bloc/engage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EngageView extends StatefulWidget {
  const EngageView({super.key});

  @override
  State<EngageView> createState() => _EngageViewState();
}

class _EngageViewState extends State<EngageView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  _sendPushPressed() {
    context.read<EngageBloc>().add(
          SendPushEvent(
            message: _controller.text,
            segment: null,
          ),
        );
  }

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
        body: BlocConsumer<EngageBloc, EngageState>(
      listener: (context, state) {
        if (state is PushSentSuccess) {
          _showSnackBar(state.message, true);
        } else if (state is PushSentFailure) {
          _showSnackBar(state.message, false);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Engage View'),
            TextField(
              controller: _controller,
            ),
            ElevatedButton(
              onPressed: () => _sendPushPressed(),
              child: const Text('Send Push'),
            )
          ],
        );
      },
    ));
  }
}
