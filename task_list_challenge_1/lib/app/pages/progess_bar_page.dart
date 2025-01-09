import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/repositories/task_repository.dart';
import 'package:task_list_challenge_1/app/service/progress_service.dart';

class ProgressBarPage extends StatefulWidget {
  const ProgressBarPage({super.key});

  @override
  State<ProgressBarPage> createState() => _ProgressBarPageState();
}

class _ProgressBarPageState extends State<ProgressBarPage> {
  final TaskRepository _taskRepository = TaskRepository();

  double _percent = 0.0;

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
        _percent = progressService.percent;
        return RefreshIndicator(
          onRefresh: () =>
              progressService.refreshList(_taskRepository.getTaskList),
          child: ListView(
            children: [
              const SizedBox(
                height: 150,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 140.0,
                    lineWidth: 30.0,
                    animation: true,
                    percent: _percent,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      textAlign: TextAlign.center,
                      "${(double.parse(_percent.toStringAsPrecision(2)) * 100).toString()}%",
                      style: const TextStyle(
                          fontSize: 55, fontWeight: FontWeight.bold),
                    ),
                    footer: const Padding(
                      padding: EdgeInsets.only(top: 18.0),
                      child: Text("Percentage of tasks completed",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Times New Roman",
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    progressColor: Colors.green,
                    backgroundColor: const Color.fromARGB(155, 252, 42, 27),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
