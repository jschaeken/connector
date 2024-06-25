import 'package:connector/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    // TODO: implement initState
    super.initState();
    message = widget.message;
    // Add a listener to the auth bloc
    sl<AuthBloc>().stream.listen((state) {
      if (state is AuthUnauthenticated && state.message.isNotEmpty && mounted) {
        _showErrorSnackbar(state.message);
      }
    });
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
    sl<AuthBloc>().add(
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
            debugPrint('Mouse position: ${event.localPosition}');
            _mousePosition = event.localPosition;
          });
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColorFadeBox(
              position: _mousePosition,
            ),
            Column(
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
          ],
        ),
      ),
    );
  }
}

class ColorFadeBox extends StatelessWidget {
  const ColorFadeBox({
    super.key,
    required this.position,
  });

  final Offset position;

  Offset get _mousePosition => position;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: ((_mousePosition.dx / 8) - 50),
      top: ((_mousePosition.dy / 8) - 50),
      child: Animate(
        onPlay: (controller) => controller.repeat(reverse: true),
      )
          .custom(
              duration: 5000.ms,
              curve: Curves.linear,
              builder: (context, value, child) {
                final color = HSVColor.lerp(
                  const HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0),
                  const HSVColor.fromAHSV(1.0, 360.0, 1.0, 1.0),
                  value,
                )!
                    .toColor();
                return Container(
                  width: 100 * (1 - value + .3),
                  height: 100 * (1 - value + .3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: color,
                        spreadRadius: 50,
                        blurRadius: 100,
                        offset: Offset(
                            _mousePosition.dx - 50, _mousePosition.dy - 50),
                      ),
                    ],
                  ),
                );
              })
          .fadeIn(),
    );
  }
}

class LoginButton extends StatefulWidget {
  const LoginButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isHovering = false;

  _onHover(bool isHovering) {
    if (this.isHovering != isHovering) {
      setState(() {
        this.isHovering = isHovering;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                  color: isHovering ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Connect',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: isHovering ? Colors.black : Colors.white),
                ))
            .animate(
              target: isHovering ? 1 : 0,
            )
            .scaleXY(
              end: 1.05,
            ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.focusNode,
  });

  final TextEditingController controller;
  final String labelText;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white, width: 1)),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 2,
            ),
          ),
          fillColor: Colors.black,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}
