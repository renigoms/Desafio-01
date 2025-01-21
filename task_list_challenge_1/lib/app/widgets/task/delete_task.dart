import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/controller/task_controller.dart';

class DeleteConfigWidget extends StatelessWidget {
  final Task task;
  const DeleteConfigWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(builder: (_, taskController, widget) {
      return InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext bd) {
                return AlertDialog(
                  title: const Text(
                    "Delete Task",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Wrap(
                    children: [
                      Text(
                        "Do you really want to delete this task ?",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        try {
                          taskController.removeTask(task.getId, context);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      child: const Text(
                        "No",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(
            Icons.delete_forever_outlined,
            color: Colors.redAccent,
          ));
    });
  }
}
