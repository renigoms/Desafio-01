import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/service/task_service.dart';

class TaskController extends ChangeNotifier {
  final _taskService = TaskService();
  String? messageSnackBar;

  void rebuildList() {
    try {
      _taskService.rebuildList();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void saveEdition(String edit, String id, BuildContext context) {
    try {
      _taskService.saveEdition(edit, id);
      GoRouter.of(context).pop();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void addTask(String message) {
    try {
      _taskService.addTask(message);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void removeTask(String id, BuildContext context) {
    try {
      _taskService.removeTask(id);
      GoRouter.of(context).pop();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void taskFilter(String filter, BuildContext context) {
    try {
      _taskService.taskFilter(filter);
      messageSnackBar = _taskService.messageSnackBar;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  List<Task> getTasks() => _taskService.tasks;

  String getMessageField() => _taskService.messageTask;

  bool isFinished(String id) => _taskService.getIsFinished(id);

  setIsFinished(bool value, String id) {
    _taskService.setIsFinished(value, id);
    notifyListeners();
  }
}
