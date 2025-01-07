class Task {
  static int _count = 0;
  String _id = "0";
  String _title = "";
  bool _isFinished = false;

  Task(this._title, this._isFinished) {
    _id = _countID();
  }

  static String _countID() => (_count += 1).toString();

  String get getId => _id;

  String get getTitle => _title;

  set setTitle(String value) => _title = value;

  bool get isFinished => _isFinished;

  set isFinished(bool value) => _isFinished = value;
}
