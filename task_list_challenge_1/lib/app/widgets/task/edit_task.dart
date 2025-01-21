import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/controller/task_controller.dart';

class EditConfigWidget extends StatelessWidget {
  final TextEditingController _editController;
  final Task _task;

  const EditConfigWidget(
      {super.key,
      required TextEditingController editController,
      required Task task})
      : _task = task,
        _editController = editController;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(builder: (_, taskController, widget) {
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
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Wrap(
                    children: [
                      Card(
                        elevation: 4,
                        color: Colors.white,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                                style: BorderStyle.solid,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 5, 5, 5),
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          minLines: 1,
                          controller: _editController,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      style: ButtonStyle(
                        elevation: WidgetStateProperty.all(4.0),
                      ),
                      onPressed: () {
                        try {
                          taskController.saveEdition(
                              _editController.text, _task.getId, context);
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Internal error !")));
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
