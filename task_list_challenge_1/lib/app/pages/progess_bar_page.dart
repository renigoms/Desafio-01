import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/repositories/task_repository.dart';
import 'package:task_list_challenge_1/app/service/progress_service.dart';
import 'package:task_list_challenge_1/app/util/section_configuration.dart';

class ProgressBarPage extends StatefulWidget {
  const ProgressBarPage({super.key});

  @override
  State<ProgressBarPage> createState() => _ProgressBarPageState();
}

class _ProgressBarPageState extends State<ProgressBarPage> {
  final TaskRepository _taskRepository = TaskRepository();

  double _percentCompleted = 0.0, _percentPending = 0.0;

  int touchedIndex = 0;

  bool _isTouchedCompleted = false, _isTouchPending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Tasks Progress",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Consumer<ProgressService>(builder: (_, progressService, widget) {
        _percentCompleted = progressService.percentCompleted;
        _percentPending = progressService.percentPending;
        return RefreshIndicator(
          color: Colors.green,
          onRefresh: () async {
            await progressService
                .calculatePercentCompleted(_taskRepository.getTaskList);
            await progressService
                .calculatePercentPending(_taskRepository.getTaskList);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 80),
            child: ListView(
              children: [
                _percentCompleted == 0.0 && _percentPending == 0.0
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 200,
                          ),
                          Text(
                            "Without Tasks",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 330,
                            width: 330,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    progressService.animationLogic(
                                        event, pieTouchResponse);
                                    touchedIndex = progressService.touchedIndex;
                                    _isTouchedCompleted = touchedIndex == 0;
                                    _isTouchPending = touchedIndex == 1;
                                  },
                                ),
                                sectionsSpace: 5,
                                centerSpaceRadius: 60,
                                sections: [
                                  SectionConfig.pieChartSectionDataConfig(
                                    _isTouchedCompleted,
                                    _percentCompleted,
                                    Colors.green,
                                  ),
                                  SectionConfig.pieChartSectionDataConfig(
                                    _isTouchPending,
                                    _percentPending,
                                    Colors.red,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 150, top: 70),
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            child: const SizedBox(
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Legend",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.rectangle,
                                      color: Colors.green,
                                    ),
                                    title: Text(
                                      "Completed",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.rectangle,
                                      color: Colors.red,
                                    ),
                                    title: Text(
                                      "Pending",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
