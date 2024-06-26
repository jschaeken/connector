import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
