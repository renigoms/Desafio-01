import 'package:shared_preferences/shared_preferences.dart';

class TaskRepository {
  static const _taskListKey = "taskListKey";

  void saveTask(String listTaskEncode) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_taskListKey, listTaskEncode);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getTaskList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_taskListKey) ?? "[]";
    } catch (e) {
      rethrow;
    }
  }
}
