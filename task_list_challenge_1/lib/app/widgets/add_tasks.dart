import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/service/task_service.dart';

class AddTasks extends StatelessWidget {
  final TextEditingController _textEditingController;
  const AddTasks({super.key, required TextEditingController textEditingController}):
  _textEditingController=textEditingController;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskService>(
      builder: (_,taskService,widget) {
        return Expanded(
          flex: 25,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _textEditingController,
              cursorColor: const Color.fromARGB(255, 11, 11, 11),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        taskService.setMessageField(
                            _textEditingController.text, context);
                        _textEditingController.text = taskService.messageField;
                      },
                      icon: const Icon(Icons.add)),
                  hintText: "New Task",
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(255, 19, 19, 19)),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      style: BorderStyle.solid,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 5, 5, 5),
                          style: BorderStyle.solid))),
            ),
          ),
        );
      }
    );
  }
}
