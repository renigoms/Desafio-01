import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/configuration/section_configuration.dart';
import 'package:task_list_challenge_1/app/controller/progress_controller.dart';

// ignore: must_be_immutable
class ProgressPizzaChart extends StatefulWidget {
  late double _percentCompleted;

  late double _percentPending;

  ProgressPizzaChart({
    super.key,
    required double percentCompleted,
    required double percentPending,
  }) {
    _percentCompleted = percentCompleted;
    _percentPending = percentPending;
  }

  @override
  State<ProgressPizzaChart> createState() => _ProgressPizzaChartState();
}

class _ProgressPizzaChartState extends State<ProgressPizzaChart> {
  int _touchedIndex = 0;

  bool _isTouchedCompleted = false, _isTouchPending = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgressController>(
      builder: (_, progressController, widget2) {
        return LayoutBuilder(
          builder: (_, constraints) {
            return PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    progressController.animationLogic(
                        event, pieTouchResponse);
                    _touchedIndex = progressController.getTouchedIndex();
                    _isTouchedCompleted = _touchedIndex == 0;
                    _isTouchPending = _touchedIndex == 1;
                  },
                ),
                sectionsSpace: 5,
                centerSpaceRadius: 60,
                sections: [
                  SectionConfig.pieChartSectionDataConfig(
                    _isTouchedCompleted,
                    widget._percentCompleted,
                    Colors.green,
                    constraints
                  ),
                  SectionConfig.pieChartSectionDataConfig(
                    _isTouchPending,
                    widget._percentPending,
                    Colors.red,
                    constraints
                  )
                ],
              ),
            );
          }
        );
      },
    );
  }
}
