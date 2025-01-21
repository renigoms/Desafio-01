import 'package:uuid/uuid.dart';

class Task {
  String _id = "0";
  String _title = "";
  bool _isFinished = false;

  Task(this._title, this._isFinished) {
    _id = const Uuid().v1();
  }

  Task._(this._id, this._title, this._isFinished);

  factory Task.fromMap(Map<String, dynamic> taskMap) {
    return Task._(
      taskMap["id"],
      taskMap["title"],
      taskMap["isFinished"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": _id,
        "title": _title,
        "isFinished": _isFinished,
      };

  String get getId => _id;

  String get getTitle => _title;

  set setTitle(String value) => _title = value;

  bool get isFinished => _isFinished;

  set isFinished(bool value) => _isFinished = value;
}
