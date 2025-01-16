import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/service/task_service.dart';
import 'package:task_list_challenge_1/app/widgets/add_tasks.dart';
import 'package:task_list_challenge_1/app/widgets/card_task_config.dart';

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
    return Consumer<TaskService>(builder: (_, taskService, widget) {
      _tasks = taskService.tasks;
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
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                taskService.taskFilter(value);
              },
              elevation: 20,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              shadowColor: Colors.grey,
              icon: const Icon(Icons.filter_alt_outlined),
              iconColor: Colors.white,
              iconSize: 30,
              itemBuilder: (BuildContext bc) {
                return <PopupMenuEntry>[
                  const PopupMenuItem(
                    value: "Completed",
                    child: ListTile(
                      leading: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      title: Text(
                        "Completed",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const PopupMenuItem(
                    value: "Pending",
                    child: ListTile(
                      leading: Icon(
                        Icons.warning_amber,
                        color: Colors.amber,
                      ),
                      title: Text(
                        "Pending",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const PopupMenuItem(
                    value: "WithoutFilter",
                    child: ListTile(
                      leading: Icon(
                        Icons.filter_alt_off_outlined,
                        color: Colors.redAccent,
                      ),
                      title: Text(
                        "Without Filter",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                AddTasks(
                  textEditingController: textEditingController,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 200,
                  child: ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (
                      BuildContext bc,
                      int index,
                    ) {
                      Task task = _tasks[index];
                      return ListTile(
                        title: CardTaskConfig(
                          task: task,
                          editingController: editController,
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
        ),
      );
    });
  }
}
