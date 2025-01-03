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
                              String msg = textEditingController.text;
                              if (msg != "") {
                                taskRepository.addTask(Task(msg, false));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Campo em branco detectado")));
                              }
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
                        title: Card(
                          elevation: 8,
                          shadowColor: Colors.green,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "TASK",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.edit),
                                          const Icon(Icons.delete),
                                          Checkbox(
                                              value: task.isFinished,
                                              onChanged: (value) {
                                                setState(() {
                                                  task.isFinished = value!;
                                                });
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Flexible(
                                  flex: 1,
                                  child: Text(
                                    task.getTitle,
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
                        ),
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
