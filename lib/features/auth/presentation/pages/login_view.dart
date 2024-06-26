import 'dart:developer';

import 'package:connector/core/navigation/presentation/widgets/color_fade_box.dart';
import 'package:connector/core/navigation/presentation/widgets/custom_textfield.dart';
import 'package:connector/core/navigation/presentation/widgets/login_box.dart';
import 'package:connector/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class LoginView extends StatefulWidget {
  final String message;

  const LoginView({
    super.key,
    this.message = '',
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController clientCodeController = TextEditingController();
  final FocusNode clientCodeFocusNode = FocusNode();
  final TextEditingController passkeyController = TextEditingController();
  final FocusNode passkeyFocusNode = FocusNode();
  late final String message;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    message = widget.message;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      clientCodeFocusNode.requestFocus();
      if (message.isNotEmpty) {
        _showErrorSnackbar(message);
      }
    });
  }

  void _onHover(bool isHovering) {
    if (_isHovering != isHovering) {
      setState(() {
        _isHovering = isHovering;
      });
    }
  }

  _loginTapped(String clientCode, String passkey) async {
    debugPrint('Current clientCode: $clientCode, passkey: $passkey');
    context.read<AuthBloc>().add(
          LoginWithEmailPasswordEvent(
            clientCode,
            passkey,
          ),
        );
  }

  Future<void> _showErrorSnackbar(String message) async {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(message),
        backgroundColor: Colors.red,
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    }
  }

  Offset _mousePosition = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MouseRegion(
        onHover: (event) {
          setState(() {
            _mousePosition = event.localPosition;
          });
        },
        child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          debugPrint('Login view, Auth state: ${state.runtimeType}');
          if (state is AuthUnauthenticated && state.message.isNotEmpty) {
            _showErrorSnackbar(state.message);
          }
        }, builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              ColorFadeBox(
                position: _mousePosition,
              ),
              IgnorePointer(
                ignoring: state is AuthLoading,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Image.network(
                          'https://i.ibb.co/SnTcdPx/image.png',
                          width: 70,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: double.infinity, height: 20),
                        const Text(
                          'Connector',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 400,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            children: [
                              CustomTextField(
                                focusNode: clientCodeFocusNode,
                                controller: clientCodeController,
                                labelText: 'client_id',
                              ),
                              const SizedBox(height: 40),
                              CustomTextField(
                                controller: passkeyController,
                                labelText: 'passkey',
                                onSubmitted: () {
                                  _loginTapped(
                                    clientCodeController.text,
                                    passkeyController.text,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    LoginButton(
                      onTap: () {
                        _loginTapped(
                          clientCodeController.text,
                          passkeyController.text,
                        );
                      },
                    ),
                  ],
                ),
              ),
              state is AuthLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        }),
      ),
    );
  }
}
