import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';
import 'package:task_list_challenge_1/app/repositories/task_repository.dart';

class TaskService {
  List<Task> _tasks = [];
  String _messageField = "", _textEdited = "";
  final _taskRepository = TaskRepository();
  bool _isFinished = false;

  String _encodeJsonData(List<Task> taskList) =>
      jsonEncode(taskList.map((task) => task.toJson()).toList());

  void rebuildList() => _tasks = _taskRepository.getTaskList;

  void saveEdition(String edit) {
    _textEdited = edit;
    // GoRouter.of(context).pop();
  }

  void removeTask(String id, BuildContext context) {
    _taskRepository.deleteTask(id);
    GoRouter.of(context).pop();
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
  }

  List<Task> get tasks => _tasks;

  String get messageField => _messageField;

  void setMessageField(String message) {
    _taskRepository.addTask(Task(message, false));
    _messageField = "";
  }

  String get textEdited => _textEdited;

  bool get isFinished => _isFinished;

  set isFinished(bool value) => _isFinished = value;
}
