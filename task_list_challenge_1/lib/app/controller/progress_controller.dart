import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:task_list_challenge_1/app/service/progress_service.dart';

class ProgressController extends ChangeNotifier {
  final _progressService = ProgressService();

  double getPercentCompleted() => _progressService.percentCompleted;

  double getPercentPending() => _progressService.percentPending;

  int getTouchedIndex() => _progressService.touchedIndex;

  Future<void> calculatePercentCompleted() async {
    await _progressService.calculatePercentCompleted();
    notifyListeners();
  }

  Future<void> calculatePercentPending() async {
    await _progressService.calculatePercentPending();
    notifyListeners();
  }

  void animationLogic(FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
    if (!event.isInterestedForInteractions ||
        pieTouchResponse?.touchedSection == null ||
        pieTouchResponse == null) {
      _progressService.animationDeselect();
      notifyListeners();
      return;
    }
    _progressService.animationSelect(pieTouchResponse);
    notifyListeners();
  }
}
