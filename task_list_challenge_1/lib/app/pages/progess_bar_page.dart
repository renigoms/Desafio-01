import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/controller/progress_controller.dart';
import 'package:task_list_challenge_1/app/controller/task_controller.dart';
import 'package:task_list_challenge_1/app/widgets/progress_chart/chart.dart';
import 'package:task_list_challenge_1/app/widgets/progress_chart/legends.dart';
import 'package:task_list_challenge_1/app/widgets/progress_chart/tasks_not_found.dart';

class ProgressBarPage extends StatefulWidget {
  const ProgressBarPage({super.key});

  @override
  State<ProgressBarPage> createState() => _ProgressBarPageState();
}

class _ProgressBarPageState extends State<ProgressBarPage> {
  double _percentCompleted = 0.0, _percentPending = 0.0;

  void _startPercent() async {
    var provider = Provider.of<ProgressController>(context, listen: false);
    await provider.calculatePercentCompleted();
    await provider.calculatePercentPending();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Adiar a chamada para função até que a fase de construção atual seja concluída
    try {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Provider.of<TaskController>(context, listen: false).rebuildList();
        _startPercent();
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Internal error !")));
    }
  }

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
      body: Consumer<ProgressController>(
          builder: (_, progressController, widget) {
        _percentCompleted = progressController.getPercentCompleted();
        _percentPending = progressController.getPercentPending();
        return Container(
          child: _percentCompleted == 0.0 && _percentPending == 0.0
              ? const TaskNotFound()
              : Column(
                  children: [
                    Expanded(
                        flex: 5,
                        child: ProgressPizzaChart(
                            percentCompleted: _percentCompleted,
                            percentPending: _percentPending)),
                    Expanded(
                      flex: 4,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 50),
                          width: double.infinity,
                          height: double.infinity,
                          child: const ChartLegends()),
                    )
                  ],
                ),
        );
      }),
    );
  }
}
