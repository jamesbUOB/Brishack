import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
  class ScoreIndicator extends StatelessWidget {
  final String title;
  final double foxScore;
  final double foodScore;
  final double radius;
  final double lineWidth;
  final Color progressColor;
  final Color backgroundColor;

  const ScoreIndicator({
    super.key,
    required this.title,
    required this.foxScore,
    required this.foodScore,
    required this.radius,
    required this.lineWidth,
    required this.progressColor,
    required this.backgroundColor,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CircularPercentIndicator(
          radius: radius,
          lineWidth: lineWidth,
          percent: 1 - (foodScore/100),
          center: Text(
            "${foodScore.toStringAsFixed(2)}%",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          progressColor: progressColor,
          backgroundColor: backgroundColor,
        ),
        SizedBox(height: 10),
        Text(
          'Score: $foxScore',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
  }