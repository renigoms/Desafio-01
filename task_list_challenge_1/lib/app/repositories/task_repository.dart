// import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';

class TaskRepository {
  static const String _taskListKey = "taskListKey";
  static final List<Task> _taskListBase = [];
  // static final Future<SharedPreferences> _prefs =
  //     SharedPreferences.getInstance();
  


  void addTask(Task task) => _taskListBase.add(task);

  List<Task> get getTaskList => _taskListBase;

  void deleteTask(String id) =>
      _taskListBase.removeWhere((value) => value.getId == id);
}
