import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
