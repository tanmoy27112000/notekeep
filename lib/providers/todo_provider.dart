import 'package:flutter/material.dart';
import 'package:notekeep/helpers/database_helper.dart';
import 'package:notekeep/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  void addTodo(TodoModel todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(int index) {
    
    DatabaseHelper.instance.deleteTodo(_todos[index].id);
    _todos.removeAt(index);
    notifyListeners();
  }

  void updateTodo(int index, TodoModel todo) {
    _todos[index] = todo;
    DatabaseHelper.instance.updateTodo(todo);
    notifyListeners();
  }

  getTodo() async {
    _todos = await DatabaseHelper.instance.getTodos();
    notifyListeners();
  }
}
