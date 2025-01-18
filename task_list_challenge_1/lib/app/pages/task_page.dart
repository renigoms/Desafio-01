import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/controller/task_controller.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/util/consts.dart';
import 'package:task_list_challenge_1/app/widgets/task/add_tasks.dart';
import 'package:task_list_challenge_1/app/widgets/task/card_task_config.dart';

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
      Provider.of<TaskController>(context, listen: false).rebuildList();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Adiar a chamada para função até que a fase de construção atual seja concluída
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskController>(context, listen: false).rebuildList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(builder: (_, taskController, widget) {
      _tasks = taskController.getTasks();
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
                taskController.taskFilter(value);
              },
              elevation: 20,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              shadowColor: Colors.grey,
              icon: const Icon(Icons.filter_alt_outlined),
              iconColor: Colors.white,
              iconSize: 30,
              itemBuilder: (BuildContext bc) => popupMenuEntryList,
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
