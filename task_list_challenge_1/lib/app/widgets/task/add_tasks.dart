import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/controller/task_controller.dart';

class AddTasks extends StatelessWidget {
  final TextEditingController _textEditingController;
  const AddTasks(
      {super.key, required TextEditingController textEditingController})
      : _textEditingController = textEditingController;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(builder: (_, taskController, widget) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          shadowColor: Colors.black,
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            minLines: 1,
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
                    String message = _textEditingController.text;
                    if (message == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Blank field detected"),
                        ),
                      );
                      return;
                    }
                    try {
                      taskController.addTask(message);
                      _textEditingController.text =
                          taskController.getMessageField();
                      FocusScope.of(context).unfocus();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          "Internal error !",
                        ),
                      ));
                    }
                  },
                  icon: const Icon(Icons.add)),
              hintText: "New Task",
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 19, 19, 19)),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 0, 0, 0),
                  style: BorderStyle.solid,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 5, 5, 5),
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
