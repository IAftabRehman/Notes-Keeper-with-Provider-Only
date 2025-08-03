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
  final List<NotesModel> _tasks = [];
  List<NotesModel> get tasks => _tasks;

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
        return NotesModel.fromJson(map);
      }));
      notifyListeners();
    }
  }

  // Add Task
  void addTask(String title, String description) {
    _tasks.add(NotesModel(title: title, description: description, createdAt: DateTime.now()));
    _saveTasks();
    notifyListeners();
  }

  // Delete Task
  void deleteTask() {
    _selectedIndexes.sort((a, b) => b.compareTo(a));
    for (int index in _selectedIndexes) {
      _tasks.removeAt(index);
    }
    _selectedIndexes.clear();
    _saveTasks();
    notifyListeners();
  }


  // Update Task
  String _originalTitle = '';
  String _originalDescription = '';
  String _currentTitle = '';
  String _currentDescription = '';

  void setInitialValues(String title, String description) {
    _originalTitle = title;
    _originalDescription = description;
    _currentTitle = title;
    _currentDescription = description;
    notifyListeners();
  }

  void updateTitle(String value) {
    _currentTitle = value;
    notifyListeners();
  }

  void updateDescription(String value) {
    _currentDescription = value;
    notifyListeners();
  }

  bool get isEdited =>
      _currentTitle != _originalTitle ||
          _currentDescription != _originalDescription;

  String get title => _currentTitle;
  String get description => _currentDescription;


  // Updating Tasks
  void applyTaskUpdate(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index] = NotesModel(
        title: _currentTitle,
        description: _currentDescription,
        createdAt: _tasks[index].createdAt,
      );
      _saveTasks();
      notifyListeners();
    }
  }
}
