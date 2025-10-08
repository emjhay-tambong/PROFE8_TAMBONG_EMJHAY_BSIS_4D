import 'package:flutter/material.dart';

class TodoItem {
  final String id;
  String title;
  String description;
  bool isCompleted;
  DateTime createdAt;

  TodoItem({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
  });
}

class TodoProvider extends ChangeNotifier {
  final List<TodoItem> _todos = [];

  List<TodoItem> get todos => _todos;

  List<TodoItem> get completedTodos => _todos.where((todo) => todo.isCompleted).toList();

  List<TodoItem> get pendingTodos => _todos.where((todo) => !todo.isCompleted).toList();

  int get totalTodos => _todos.length;

  int get completedCount => completedTodos.length;

  int get pendingCount => pendingTodos.length;

  void addTodo(String title, String description) {
    final todo = TodoItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    _todos.add(todo);
    notifyListeners();
  }

  void toggleTodo(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index >= 0) {
      _todos[index].isCompleted = !_todos[index].isCompleted;
      notifyListeners();
    }
  }

  void updateTodo(String id, String title, String description) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index >= 0) {
      _todos[index].title = title;
      _todos[index].description = description;
      notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void clearCompleted() {
    _todos.removeWhere((todo) => todo.isCompleted);
    notifyListeners();
  }

  void clearAll() {
    _todos.clear();
    notifyListeners();
  }
}
