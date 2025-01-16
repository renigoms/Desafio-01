import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:task_list_challenge_1/app/model/task_model.dart';

class ProgressService extends ChangeNotifier {
  double _percentCompleted = 0.0, _percentPending = 0.0;

  int _touchedIndex = 0;

  double get percentCompleted => _percentCompleted;

  double get percentPending => _percentPending;

  int get touchedIndex => _touchedIndex;

  Future<void> calculatePercentCompleted(List<Task> listTasks) async {
    await Future.delayed(const Duration(seconds: 2));
    final totalSize = listTasks.length,
        completedTasks = listTasks.where((task) => task.isFinished).length;
    final percentBase =
        totalSize != 0 ? (completedTasks * 100) / totalSize : 0.0;
    _percentCompleted = percentBase / 100;
    notifyListeners();
  }

  Future<void> calculatePercentPending(List<Task> listTasks) async {
    await Future.delayed(const Duration(seconds: 1));
    final totalSize = listTasks.length,
        completedTasks = listTasks.where((task) => !task.isFinished).length;
    final percentBase =
        totalSize != 0 ? (completedTasks * 100) / totalSize : 0.0;
    _percentPending = percentBase / 100;
    notifyListeners();
  }

  void animationLogic(FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
    if (!event.isInterestedForInteractions ||
        pieTouchResponse?.touchedSection == null ||
        pieTouchResponse == null) {
      _touchedIndex = -1;
      notifyListeners();
      return;
    }
    _touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
    notifyListeners();
  }
}
