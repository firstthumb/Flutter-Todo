
import 'package:flutter_todo_simple/app/data/models/todo_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodoList();

  Future<List<TodoModel>> saveTodo(String text);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final Box todoBox;

  TodoLocalDataSourceImpl({@required this.todoBox});

  @override
  Future<List<TodoModel>> getTodoList() async {
    final list = List<TodoModel>();
    for (var value in todoBox.values) {
      if (value is TodoModel) {
        list.add(value);
      }
    }

    return list;
  }

  @override
  Future<List<TodoModel>> saveTodo(String text) async {
    final todoModel = TodoModel(id: Uuid().v4(), text: text, completed: false);
    todoBox.put(todoModel.id, todoModel);

    return getTodoList();
  }
}