import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

abstract class SectionConfig {
  static String _percentToString(double percent) => percent != 1
      ? "${(double.parse(percent.toStringAsPrecision(2)) * 100).toStringAsPrecision(2)}%"
      : "${(percent * 100).toInt()}%";

  static PieChartSectionData pieChartSectionDataConfig(
          bool isTouchedCompleted, double percent, Color color) =>
      PieChartSectionData(
        borderSide: const BorderSide(
          color: Colors.black,
          width: 5,
        ),
        radius: isTouchedCompleted ? 105.0 : 80.0,
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
