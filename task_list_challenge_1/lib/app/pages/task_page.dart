import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:task_list_challenge_1/app/controller/task_controller.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/widgets/task/add_tasks.dart';
import 'package:task_list_challenge_1/app/widgets/task/card_task_config.dart';
import 'package:task_list_challenge_1/app/widgets/task/menu_button.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Adiar a chamada para função até que a fase de construção atual seja concluída
    try {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Provider.of<TaskController>(context, listen: false).rebuildList();
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Internal error !")));
    }
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
          actions: const [
            PopUpMenuButtonConfig(),
          ],
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.only(top: 18),
                    child: AddTasks(
                      textEditingController: textEditingController,
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
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
                            index: index,
                            editingController: editController,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
