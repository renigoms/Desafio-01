import 'dart:convert';

import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/repositories/task_repository.dart';

class TaskService {
  static List<Task> _tasks = [];
  String _messageTask = "";
  String? messageSnackBar;
  final _taskRepository = TaskRepository();

  String _encodeJsonTaskData(List<Task> taskList) =>
      jsonEncode(taskList.map((task) => task.toJson()).toList());

  List<Task> _decodeJsonTaskData(String data) {
    List decode = jsonDecode(data);
    return decode.map((taskMap) => Task.fromMap(taskMap)).toList();
  }

  void rebuildList() async {
    try {
      String repoListString = await _taskRepository.getTaskList();
      _tasks = repoListString == "" ? [] : _decodeJsonTaskData(repoListString);
    } catch (e) {
      rethrow;
    }
  }

  void addTask(String message) async {
    try {
      _tasks = _decodeJsonTaskData(await _taskRepository.getTaskList());
      _tasks.add(Task(message, false));
      _taskRepository.saveTask(_encodeJsonTaskData(_tasks));
      _messageTask = "";
    } catch (e) {
      rethrow;
    }
  }

  void saveEdition(String edit, String id) async {
    try {
      _tasks = _decodeJsonTaskData(await _taskRepository.getTaskList());
      _tasks.where((task) => task.getId == id).first.setTitle = edit;
      _taskRepository.saveTask(_encodeJsonTaskData(_tasks));
    } catch (e) {
      rethrow;
    }
  }

  void removeTask(String id) async {
    try {
      _tasks = _decodeJsonTaskData(await _taskRepository.getTaskList());
      _tasks.removeWhere((task) => task.getId == id);
      String listTaskEncode = _encodeJsonTaskData(_tasks);
      _taskRepository.saveTask(listTaskEncode);
    } catch (e) {
      rethrow;
    }
  }

  void taskFilter(String filter) async {
    try {
      var tasks = await _taskRepository.getTaskList();
      _tasks = _decodeJsonTaskData(tasks);
      if (filter == "Completed") {
        messageSnackBar = null;
        List<Task> taskFilter =
            _tasks.where((task) => task.isFinished).toList();
        if (taskFilter.isEmpty) {
          messageSnackBar = "There are no ${filter.toLowerCase()} tasks !";
          return;
        }

        _tasks = taskFilter;
      } else if (filter == "Pending") {
        messageSnackBar = null;
        List<Task> taskFilter =
            _tasks.where((task) => !task.isFinished).toList();
        if (taskFilter.isEmpty) {
          messageSnackBar = "There are no ${filter.toLowerCase()} tasks !";
          return;
        }

        _tasks = taskFilter;
      }
    } catch (e) {
      rethrow;
    }
  }

  List<Task> get tasks => _tasks;

  String get messageTask => _messageTask;

  bool getIsFinished(String id) =>
      _tasks.where((task) => task.getId == id).first.isFinished;

  void setIsFinished(bool value, String id) async {
    _tasks = _decodeJsonTaskData(await _taskRepository.getTaskList());
    _tasks.where((task) => task.getId == id).first.isFinished = value;
    _taskRepository.saveTask(_encodeJsonTaskData(_tasks));
  }
}
