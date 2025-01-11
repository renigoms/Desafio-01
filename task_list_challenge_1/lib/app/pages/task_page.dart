import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/service/task_service.dart';
import 'package:task_list_challenge_1/app/widgets/delete_task.dart';
import 'package:task_list_challenge_1/app/widgets/edit_task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController textEditingController = TextEditingController(),
      editController = TextEditingController();
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    // Adiar a chamada para função até que a fase de construção atual seja concluída
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskService>(context, listen: false).rebuildList();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Adiar a chamada para função até que a fase de construção atual seja concluída
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskService>(context, listen: false).rebuildList();
    });
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
      body: Consumer<TaskService>(builder: (_, taskService, widget) {
        _tasks = taskService.tasks;
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 25,
                  child: Padding(
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
                                taskService.setMessageField(
                                    textEditingController.text, context);
                                textEditingController.text =
                                    taskService.messageField;
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
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 200,
                  child: ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (BuildContext bc, int index) {
                      Task task = _tasks[index];
                      return ListTile(
                        title: Card(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "TASK ${task.getId}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        children: [
                                          EditConfigWidget(
                                              editController: editController,
                                              task: task),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          DeleteConfigWidget(
                                            task: task,
                                          ),
                                          Checkbox(
                                              activeColor: Colors.green,
                                              value: task.isFinished,
                                              onChanged: (value) {
                                                taskService
                                                    .setIsFinished(value!);
                                                task.isFinished =
                                                    taskService.isFinished;
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
                    },
                  ),
                ),
                const SizedBox(
                  height: 181,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
