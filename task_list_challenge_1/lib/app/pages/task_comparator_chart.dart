import 'package:flutter/material.dart';

class TaskComparatorChart extends StatefulWidget {
  const TaskComparatorChart({super.key});

  @override
  State<TaskComparatorChart> createState() => _TaskComparatorChartState();
}

class _TaskComparatorChartState extends State<TaskComparatorChart> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Gráfico de comparação de Tasks",
          style: TextStyle(
            fontFamily: "Arial",
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
