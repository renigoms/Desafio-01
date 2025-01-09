import 'package:flutter/material.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';

class ProgressService extends ChangeNotifier {
  double _percent = 0.0;

  double get percent => _percent;

  Future <void> refreshList(List<Task> listTasks) async {
    await Future.delayed(const Duration(seconds: 2));
    final totalSize = listTasks.length,
        completedTasks = listTasks.where((task) => task.isFinished).length;
    final percentBase =
        totalSize != 0 ? (completedTasks * 100) / totalSize : 0.0;
    _percent = percentBase / 100;
    notifyListeners();
  }
}
