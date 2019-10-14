
import 'package:dartz/dartz.dart';
import 'package:flutter_todo_simple/app/domain/entities/todo.dart';
import 'package:flutter_todo_simple/core/error/failures.dart';

import '../entities/visibility_filter.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodoList(VisibilityFilter filter);

  Future<Either<Failure, List<Todo>>> addTodo(Todo todo);

  Future<Either<Failure, List<Todo>>> toggleTodo(String id);

  Future<Either<Failure, List<Todo>>> deleteTodo(String id);

  Future<Either<Failure, List<Todo>>> clearCompletedTodo();
}