import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/controller/task_controller.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/widgets/task/delete_task.dart';
import 'package:task_list_challenge_1/app/widgets/task/edit_task.dart';

class CardTaskConfig extends StatelessWidget {
  final Task _task;
  final TextEditingController _editingController;
  final int _index;

  const CardTaskConfig(
      {super.key,
      required Task task,
      required int index,
      required TextEditingController editingController})
      : _task = task,
        _index = index,
        _editingController = editingController;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(builder: (_, taskController, widget) {
      return Card(
        elevation: 8,
        shadowColor: Colors.black,
        color: const Color.fromARGB(192, 243, 243, 59),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                left: 20,
                top: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TASK ${_index + 1}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        EditConfigWidget(
                            editController: _editingController, task: _task),
                        const SizedBox(
                          width: 5,
                        ),
                        DeleteConfigWidget(
                          task: _task,
                        ),
                        Checkbox(
                            activeColor: Colors.green,
                            value: _task.isFinished,
                            onChanged: (value) {
                              taskController.setIsFinished(value!, _task.getId);
                              _task.isFinished =
                                  taskController.isFinished(_task.getId);
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Flexible(
                flex: 1,
                child: Text(
                  _task.getTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      );
    });
  }
}
