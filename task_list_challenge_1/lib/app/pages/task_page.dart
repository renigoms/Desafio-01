import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/repository/task_repository.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TaskRepository taskRepository = TaskRepository();
  TextEditingController textEditingController = TextEditingController();
  List<Task> _tasks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTasks();
  }

  void getTasks() {
    _tasks = taskRepository.getTaskList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Tasks",
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: textEditingController,
                  cursorColor: const Color.fromARGB(255, 11, 11, 11),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              taskRepository.addTask(
                                  Task(textEditingController.text, false));
                              textEditingController.text = "";
                            });
                          },
                          icon: const Icon(Icons.add)),
                      hintText: "New Task",
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 19, 19, 19)),
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
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: taskRepository.getTaskList.length,
                    itemBuilder: (BuildContext bc, int index) {
                      Task task = taskRepository.getTaskList[index];
                      return ListTile(
                        title: Text(task.getTitle),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
