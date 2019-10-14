import 'package:flutter_todo_simple/app/data/models/todo_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodoList();

  Future<List<TodoModel>> getCompletedTodoList();

  Future<TodoModel> getTodo(String id);

  Future<List<TodoModel>> saveTodo(String text);

  Future<List<TodoModel>> deleteTodo(List<String> ids);

  Future<List<TodoModel>> updateTodo(TodoModel todoModel);
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
    await todoBox.put(todoModel.id, todoModel);

    return getTodoList();
  }

  @override
  Future<List<TodoModel>> deleteTodo(List<String> ids) async {
    await todoBox.deleteAll(ids);

    return getTodoList();
  }

  @override
  Future<List<TodoModel>> updateTodo(TodoModel todoModel) async {
    await todoBox.put(todoModel.id, todoModel);

    return getTodoList();
  }

  @override
  Future<TodoModel> getTodo(String id) async {
    return todoBox.get(id);
  }

  @override
  Future<List<TodoModel>> getCompletedTodoList() async {
    final list = List<TodoModel>();

    final completedTodoList = todoBox.values.where((todo) => todo.completed);
    for (var value in completedTodoList) {
      if (value is TodoModel) {
        list.add(value);
      }
    }

    return list;
  }
}
