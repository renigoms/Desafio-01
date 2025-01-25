import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/controller/progress_controller.dart';

class TaskNotFound extends StatelessWidget {
  const TaskNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return Consumer<ProgressController>(
          builder: (_, progressController, widget) {
        return OrientationBuilder(builder: (context, orientation) {
          return RefreshIndicator(
            color: Colors.green,
            onRefresh: () async {
              await progressController.calculatePercentCompleted();
              await progressController.calculatePercentPending();
            },
            child: ListView(
              children: [
                Container(
                  padding: orientation == Orientation.landscape
                      ? EdgeInsets.symmetric(
                          vertical: constraints.maxHeight * 0.001,
                        )
                      : EdgeInsets.symmetric(
                          vertical: constraints.maxHeight * 0.3,
                        ),
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.no_sim_outlined,
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
                  ),
                ),
              ],
            ),
          );
        });
      });
    });
  }
}
