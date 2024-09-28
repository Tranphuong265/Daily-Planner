import 'package:flutter/material.dart';

class TaskManager extends ChangeNotifier {
  Map<DateTime, List<Map<String, dynamic>>> _tasks = {};

  Map<DateTime, List<Map<String, dynamic>>> get tasks => _tasks;

  void addTask(Map<String, dynamic> task) {
    DateTime taskDate = task['date'];
    if (_tasks[taskDate] != null) {
      _tasks[taskDate]!.add(task);
    } else {
      _tasks[taskDate] = [task];
    }
    notifyListeners(); // Cập nhật tất cả widget lắng nghe
  }
}
