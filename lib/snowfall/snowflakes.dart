import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snowfall/snowfall/snowflakes_painter.dart';
import 'package:snowfall/snowfall/snowflake_model.dart';
import 'package:snowfall/snowfall/snowfall_rendering.dart';

class Snowflakes extends StatefulWidget {
  final int numberOfSnowflakes;
  final Color color;
  final int alpha;
  final double minSize;
  final double maxSize;
  const Snowflakes(
      {required this.numberOfSnowflakes,
      required this.color,
      required this.alpha,
      required this.minSize,
      required this.maxSize,
      Key? key})
      : super(key: key);

  @override
  State createState() => _SnowflakesState();
}

class _SnowflakesState extends State<Snowflakes> {
  final Random random = Random();

  final List<SnowflakeModel> flakes = [];

  @override
  void initState() {
    assert(widget.minSize > 0 && widget.maxSize > 0);
    assert(widget.minSize < widget.maxSize,
        "minSize can't be greater than maxSize");
    List.generate(widget.numberOfSnowflakes, (index) {
      flakes.add(SnowflakeModel(
        random,
        minSize: widget.minSize,
        maxSize: widget.maxSize,
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SnowfallRendering(
      startTime: const Duration(seconds: 30),
      onTick: _simulateFlakes,
      builder: (context, time) {
        return CustomPaint(
          painter: SnowflakesPainter(
              snowflakes: flakes,
              time: time,
              color: widget.color,
              alpha: widget.alpha),
        );
      },
    );
  }

  _simulateFlakes(Duration time) {
    for (var flake in flakes) {
      flake.maintainRestart(time);
    }
  }
}
