import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/controller/progress_controller.dart';
import 'package:task_list_challenge_1/app/controller/task_controller.dart';
import 'package:task_list_challenge_1/app/util/section_configuration.dart';
import 'package:task_list_challenge_1/app/widgets/listtile_config.dart';

class ProgressBarPage extends StatefulWidget {
  const ProgressBarPage({super.key});

  @override
  State<ProgressBarPage> createState() => _ProgressBarPageState();
}

class _ProgressBarPageState extends State<ProgressBarPage> {
  double _percentCompleted = 0.0, _percentPending = 0.0;

  int touchedIndex = 0;

  bool _isTouchedCompleted = false, _isTouchPending = false;

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
        return RefreshIndicator(
          color: Colors.green,
          onRefresh: () async {
            await progressController.calculatePercentCompleted();
            await progressController.calculatePercentPending();
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
                                    progressController.animationLogic(
                                        event, pieTouchResponse);
                                    touchedIndex =
                                        progressController.getTouchedIndex();
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
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ListTileConfig(
                                    icon: Icon(
                                      Icons.rectangle,
                                      color: Colors.green,
                                    ),
                                    text: "Completed",
                                  ),
                                  ListTileConfig(
                                    icon: Icon(
                                      Icons.rectangle,
                                      color: Colors.red,
                                    ),
                                    text: "Pending",
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
