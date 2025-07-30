import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/TaskModel.dart';

class HomeProvider extends ChangeNotifier {
  final List<int> _selectedIndexes = [];
  List<int> get selectedIndexes => _selectedIndexes;
  bool isSelected(int index) => _selectedIndexes.contains(index);

  void toggleSelection(int index) {
    if (_selectedIndexes.contains(index)) {
      _selectedIndexes.remove(index);
    } else {
      _selectedIndexes.add(index);
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedIndexes.clear();
    notifyListeners();
  }

  bool get hasSelection => _selectedIndexes.isNotEmpty;

  // Task List
  final List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  // Save to SharedPreferences
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskJsonList = _tasks.map((task) => jsonEncode(task.toJson())).toList();

    await prefs.setStringList('tasks', taskJsonList);
  }

  // Load from SharedPreferences
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskJsonList = prefs.getStringList('tasks');

    if (taskJsonList != null) {
      _tasks.clear();
      _tasks.addAll(taskJsonList.map((jsonTask) {
        final map = jsonDecode(jsonTask);
        return TaskModel.fromJson(map);
      }));
      notifyListeners();
    }
  }

  // Add Task
  void addTask(String title, String description) {
    _tasks.add(TaskModel(title: title, description: description));
    _saveTasks(); // Save after adding
    notifyListeners();
  }

  // Delete Task
  void deleteTask() {
    _selectedIndexes.sort((a, b) => b.compareTo(a));
    for (int index in _selectedIndexes) {
      _tasks.removeAt(index);
    }
    _selectedIndexes.clear();
    _saveTasks(); // Save after deleting
    notifyListeners();
  }
}
