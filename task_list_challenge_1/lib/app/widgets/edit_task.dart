import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/service/task_service.dart';

class EditConfigWidget extends StatelessWidget {
  late TextEditingController _editController;
  late Task _task;
  EditConfigWidget(
      {super.key,
      required TextEditingController editController,
      required Task task}) {
    _task = task;
    _editController = editController;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskService>(builder: (_, taskService, widget) {
      return InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext bc) {
                _editController.text = _task.getTitle;
                return AlertDialog(
                  title: const Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Wrap(
                    children: [
                      TextFormField(
                        controller: _editController,
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        taskService.saveEdition(_editController.text, context);
                        _task.setTitle = taskService.textEdited;
                      },
                      child: const Text(
                        "Save",
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(
            size: 30,
            Icons.edit_note,
            color: Color.fromARGB(255, 24, 5, 227),
          ));
    });
  }
}
