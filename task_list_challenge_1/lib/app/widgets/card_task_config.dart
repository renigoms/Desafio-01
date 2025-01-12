import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/service/task_service.dart';
import 'package:task_list_challenge_1/app/widgets/delete_task.dart';
import 'package:task_list_challenge_1/app/widgets/edit_task.dart';

class CardTaskConfig extends StatelessWidget {
  final Task _task;
  final TextEditingController _editingController;

  const CardTaskConfig(
      {super.key, required Task task, required TextEditingController editingController})
      : _task = task,
        _editingController = editingController;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskService>(
      builder: (_, taskService,widget) {
        return Card(
          elevation: 8,
          color: const Color.fromARGB(255, 203, 202, 202),
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
                      "TASK ${_task.getId}",
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
                                taskService.setIsFinished(value!);
                                _task.isFinished = taskService.isFinished;
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
      }
    );
  }
}
