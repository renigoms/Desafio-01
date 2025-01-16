import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/repositories/task_repository.dart';

class TaskService extends ChangeNotifier {
  List<Task> _tasks = [];
  String _messageField = "", _textEdited = "";
  final TaskRepository _taskRepository = TaskRepository();
  bool _isFinished = false;


  void rebuildList() {
    _tasks = _taskRepository.getTaskList;
    notifyListeners();
  }

  void saveEdition(String edit, BuildContext context) {
    _textEdited = edit;
    GoRouter.of(context).pop();
    notifyListeners();
  }

  void removeTask(String id, BuildContext context) {
    _taskRepository.deleteTask(id);
    GoRouter.of(context).pop();
    notifyListeners();
  }

  void taskFilter(String filter) {
    switch (filter) {
      case "Completed":
        _tasks = _taskRepository.getTaskList
            .where((task) => task.isFinished)
            .toList();
        break;
      case "Pending":
        _tasks = _taskRepository.getTaskList
            .where((task) => !task.isFinished)
            .toList();
        break;
      case "WithoutFilter":
        _tasks = _taskRepository.getTaskList;
        break;
    }
    notifyListeners();
  }

  List<Task> get tasks => _tasks;

  String get messageField => _messageField;

  void setMessageField(String message, BuildContext context) {
    if (message != "") {
      _taskRepository.addTask(Task(message, false));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Blank field detected")));
    }
    _messageField = "";
    notifyListeners();
  }

  String get textEdited => _textEdited;

  bool get isFinished => _isFinished;

  setIsFinished(bool value) {
    _isFinished = value;
    notifyListeners();
  }
}
