import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
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
}
