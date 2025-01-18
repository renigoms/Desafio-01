import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/service/task_service.dart';

class TaskController extends ChangeNotifier {
  final _taskService = TaskService();

  void rebuildList() {
    _taskService.rebuildList();
    notifyListeners();
  }

  void saveEdition(String edit, BuildContext context) {
    _taskService.saveEdition(edit);
    GoRouter.of(context).pop();
    notifyListeners();
  }

  void removeTask(String id, BuildContext context) {
    _taskService.removeTask(id);
    GoRouter.of(context).pop();
    notifyListeners();
  }

  void taskFilter(String filter) {
    _taskService.taskFilter(filter);
    notifyListeners();
  }

  List<Task> getTasks() => _taskService.tasks;

  String getMessageField() => _taskService.messageField;

  void setMessageField(String message) {
    _taskService.setMessageField(message);
    notifyListeners();
  }

  String getTxtEdited() => _taskService.textEdited;

  bool isFinished() => _taskService.isFinished;

  setIsFinished(bool value) {
    _taskService.isFinished = value;
    notifyListeners();
  }
}
