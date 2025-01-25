import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

abstract class SectionConfig {
  static String _percentToString(double percent) => percent != 1
      ? "${(double.parse(percent.toStringAsPrecision(2)) * 100).toStringAsPrecision(2)}%"
      : "${(percent * 100).toInt()}%";

  static PieChartSectionData pieChartSectionDataConfig(bool isTouchedCompleted,
          double percent, Color color, BoxConstraints constraint) =>
      PieChartSectionData(
        borderSide: const BorderSide(
          color: Colors.black,
          width: 5,
        ),
        radius: isTouchedCompleted
            ? constraint.maxHeight * 0.25
            : constraint.maxHeight * 0.18,
        value: percent,
        title: _percentToString(percent),
        titleStyle: TextStyle(
          fontSize: isTouchedCompleted ? 35 : 27,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        color: color,
      );
}
