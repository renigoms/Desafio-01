class Task {
  String _title = "";

  bool _isFinished = false;

  Task(this._title, this._isFinished);

  String get getTitle => _title;

  set setTitle(String value) => _title = value;

  bool get isFinished => _isFinished;

  set isFinished(bool value) => _isFinished = value;
}
