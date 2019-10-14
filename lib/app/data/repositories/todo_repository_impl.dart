
import 'package:dartz/dartz.dart';
import 'package:flutter_todo_simple/app/data/datasources/todo_local_datasource.dart';
import 'package:flutter_todo_simple/app/domain/entities/todo.dart';
import 'package:flutter_todo_simple/app/domain/entities/visibility_filter.dart';
import 'package:flutter_todo_simple/core/error/failures.dart';
import 'package:meta/meta.dart';

import '../../domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({
    @required this.localDataSource
  });

  @override
  Future<Either<Failure, List<Todo>>> getTodoList(VisibilityFilter filter) async {
    final todoList = await localDataSource.getTodoList();
    final filteredTodoList = todoList.where((item) => filter == VisibilityFilter.all ? true : (filter == VisibilityFilter.completed ? item.completed : !item.completed));
    return Right(filteredTodoList.map((todoModel) => todoModel.fromModel()).toList());
  }

  @override
  Future<Either<Failure, List<Todo>>> addTodo(Todo todo) async {
    final todoList = await localDataSource.saveTodo(todo.text);
    return Right(todoList.map((todoModel) => todoModel.fromModel()).toList());
  }

  @override
  Future<Either<Failure, List<Todo>>> deleteTodo(String id) async {
    final todoList = await localDataSource.deleteTodo([id]);
    return Right(todoList.map((todoModel) => todoModel.fromModel()).toList());
  }

  @override
  Future<Either<Failure, List<Todo>>> toggleTodo(String id) async {
    final todoModel = await localDataSource.getTodo(id);
    final todoList = await localDataSource.updateTodo(todoModel.toggle());
    return Right(todoList.map((todoModel) => todoModel.fromModel()).toList());
  }

  @override
  Future<Either<Failure, List<Todo>>> clearCompletedTodo() async {
    final completedTodoList = await localDataSource.getCompletedTodoList();
    final todoList = await localDataSource.deleteTodo(completedTodoList.map((t) => t.id).toList());
    return Right(todoList.map((todoModel) => todoModel.fromModel()).toList());
  }
}