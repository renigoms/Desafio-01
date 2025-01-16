import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

abstract class SectionConfig {
  static String _percentToString(double percent) =>
      "${(double.parse(percent.toStringAsPrecision(2)) * 100).toString()}%";

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
          fontSize: isTouchedCompleted ? 30 : 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        color: color,
      );
}
