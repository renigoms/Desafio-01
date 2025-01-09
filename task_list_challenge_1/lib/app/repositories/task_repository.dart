import 'package:task_list_challenge_1/app/model/task_model.dart';

class TaskRepository {
  static final List<Task> _taskListBase = [];

  void addTask(Task task) => _taskListBase.add(task);

  List<Task> get getTaskList => _taskListBase;

  void deleteTask(String id) => _taskListBase.removeWhere((value) => value.getId == id);

}
