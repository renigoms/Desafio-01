import 'package:fl_chart/fl_chart.dart';
import 'package:task_list_challenge_1/app/service/task_service.dart';

class ProgressService {
  final TaskService _taskService = TaskService();

  double _percentCompleted = 0.0, _percentPending = 0.0;

  int _touchedIndex = 0;

  double get percentCompleted => _percentCompleted;

  double get percentPending => _percentPending;

  int get touchedIndex => _touchedIndex;

  Future<void> calculatePercentCompleted() async {
    await Future.delayed(const Duration(seconds: 1));
    var listTasks =  _taskService.tasks;
    final totalSize = listTasks.length,
        completedTasks = listTasks.where((task) => task.isFinished).length;
    final percentBase =
        totalSize != 0 ? (completedTasks * 100) / totalSize : 0.0;
    _percentCompleted = percentBase / 100;
  }

  Future<void> calculatePercentPending() async {
    await Future.delayed(const Duration(seconds: 1));
    var listTasks = _taskService.tasks;
    final totalSize = listTasks.length,
        completedTasks = listTasks.where((task) => !task.isFinished).length;
    final percentBase =
        totalSize != 0 ? (completedTasks * 100) / totalSize : 0.0;
    _percentPending = percentBase / 100;
  }

  void animationSelect(PieTouchResponse? pieTouchResponse) {
    _touchedIndex = pieTouchResponse!.touchedSection!.touchedSectionIndex;
  }

  animationDeselect() => _touchedIndex = -1;
}
