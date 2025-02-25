import 'package:flutter/material.dart';
import 'package:snowfall/snowfall/snowflakes.dart';

class SnowfallWidget extends StatelessWidget {
  final Widget child;
  final bool isEnabled;
  final Color color;
  final int numberOfSnowflakes;
  final int alpha;
  final double minSize;
  final double maxSize;
  const SnowfallWidget({
    Key? key,
    required this.child,
    required this.isEnabled,
    this.numberOfSnowflakes = 30,
    this.color = Colors.white,
    this.alpha = 180,
    this.minSize = 20,
    this.maxSize = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          if (isEnabled)
            Positioned.fill(
                child: Snowflakes(
              numberOfSnowflakes: numberOfSnowflakes,
              color: color,
              alpha: alpha,
              minSize: minSize,
              maxSize: maxSize,
            )),
          Positioned.fill(child: child),
        ],
      );
}
